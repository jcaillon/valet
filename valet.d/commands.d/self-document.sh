#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../lib-string
source string
# shellcheck source=../lib-system
source system
# shellcheck source=../lib-array
source array

#===============================================================
# >>> command: self document
#===============================================================

##<<VALET_COMMAND
# command: self document
# function: selfDocument
# author: github.com/jcaillon
# shortDescription: Generate the documentation and code snippets for all the library functions of Valet.
# description: |-
#   Generate the documentation and code snippets for all the library functions of Valet.
#
#   It will parse all the library files and generate:
#
#   - A markdown file with the documentation.
#   - A bash file with the prototype of each function.
#   - A vscode snippet file for each function.
# options:
# - name: -o, --output <directory path>
#   description: |-
#     The directory in which the documentation will be generated.
#     Defaults to the valet user directory.
# - name: -C, --core-only
#   description: |-
#     Generate the documentation for the core functions only.
#     Will not generate for libraries present in the valet user directory.
# examples:
# - name: self document
#   description: |-
#     Generate the documentation for all the library functions of Valet and output to the default directory.
##VALET_COMMAND
function selfDocument() {
  local output coreOnly
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  # default output to the user directory
  core::getUserDirectory
  output="${output:-${RETURNED_VALUE}}"

  selfDocument::getFooter
  local pageFooter="${RETURNED_VALUE}"

  # export the documentation for each library
  selfDocument::getAllFunctionsDocumentation "${coreOnly}"

  # sort the functions by name
  declare -a SORTED_FUNCTION_NAMES=("${!RETURNED_ASSOCIATIVE_ARRAY[@]}")
  array::sort SORTED_FUNCTION_NAMES

  # write each function documentation to a file
  selfRelease_writeAllFunctionsToMarkdown "${pageFooter}" "${output}/lib-valet.md"
  log::info "The documentation has been generated in ⌜${output}/lib-valet.md⌝."

  # write each function to a file
  selfRelease_writeAllFunctionsToPrototypeScript "${pageFooter}" "${output}/lib-valet"
  log::info "The prototype script has been generated in ⌜${output}/lib-valet⌝."

  # write each function to the snippet file
  selfRelease_writeAllFunctionsToCodeSnippets "${pageFooter}" "${output}/valet.code-snippets"
  log::info "The vscode snippets have been generated in ⌜${output}/valet.code-snippets⌝."
}

# Returns the footer for the documentation.
# It indicates the version and the date of the documentation.
#
# Returns:
#
# - `RETURNED_VALUE` the footer for the documentation.
#
# ```bash
# selfDocument::getFooter
# echo "${RETURNED_VALUE}"
# ```
function selfDocument::getFooter() {
  core::getVersion
  local version="${RETURNED_VALUE}"

  system::date "%(%F)T"
  local currentDate="${RETURNED_VALUE}"
  RETURNED_VALUE="Documentation generated for the version ${version} (${currentDate})."
}

# Returns an associative array of all the function names and their documentation.
# The key is the function name and the value is the documentation.
# The documentation is the content of the comment block above the function.
# The comment block should start with a `# ##` to be considered as a documentation block.
#
# Returns:
#
# - `RETURNED_ASSOCIATIVE_ARRAY` an associative array of all the function names and their documentation.
#
# ```bash
# selfDocument::getAllFunctionsDocumentation
# ```
function selfDocument::getAllFunctionsDocumentation() {
  local coreOnly="${1:-false}"

  if [[ ${coreOnly} == "true" ]]; then
    log::info "Generating documentation for the core functions only."
  else
    log::info "Generating documentation for all the functions."
  fi

  # get all the files in the valet.d directory
  io::listFiles "${GLOBAL_VALET_HOME}/valet.d"
  local -a filesToAnalyze=("${RETURNED_ARRAY[@]}")

  # add each file of each user library directory
  if [[ ${coreOnly} != "true" ]]; then
    local libraryDirectory
    for libraryDirectory in "${CMD_LIBRARY_DIRECTORIES[@]}"; do
      io::listFiles "${libraryDirectory}"
      filesToAnalyze+=("${RETURNED_ARRAY[@]}")
    done
  fi

  local IFS=$'\n'
  if log::isDebugEnabled; then
    log::debug "Analyzing the following files:"
    log::printFileString "${filesToAnalyze[*]}"
  fi

  unset -v RETURNED_ASSOCIATIVE_ARRAY
  declare -g -A RETURNED_ASSOCIATIVE_ARRAY=()

  # for each file to analyze
  local file
  for file in "${filesToAnalyze[@]}"; do
    local functionName functionDocumentation
    local reading=false

    # loop through lines
    # collect the documentation from comments starting with `# ##`
    local line
    while IFS= read -r line || [[ -n ${line:-} ]]; do
      if [[ ${reading} == "false" ]]; then
        if [[ ${line} == "# ##"* ]]; then
          reading=true
        else
          continue
        fi
      fi

      if [[ ${line} != "#"* ]]; then
        reading=false
        string::extractBetween "${functionDocumentation}" "## " $'\n'
        string::trim "${RETURNED_VALUE}"
        functionName="${RETURNED_VALUE}"
        log::debug "Found function: ⌜${functionName}⌝"
        RETURNED_ASSOCIATIVE_ARRAY["${functionName}"]="${functionDocumentation}"
        functionDocumentation=""
      else
        if [[ ${line} == "#" ]]; then
          functionDocumentation+="${line:1}"$'\n'
        else
          functionDocumentation+="${line:2}"$'\n'
        fi
      fi
    done <"${file}"
  done

  log::info "Found ${#RETURNED_ASSOCIATIVE_ARRAY[@]} functions with documentation."

  if log::isTraceEnabled; then
    log::trace "The functions with their documentation are:"
    local key
    for key in "${!RETURNED_ASSOCIATIVE_ARRAY[@]}"; do
      log::trace "Function: ⌜${key}⌝"
      log::printFileString "${RETURNED_ASSOCIATIVE_ARRAY[${key}]}"
    done
  fi
}

# This function writes all the functions documentation to a given file.
function selfRelease_writeAllFunctionsToMarkdown() {
  local pageFooter="${1:-}"
  local outputFile="${2:-}"

  io::createFilePathIfNeeded "${outputFile}"

  local content="# Valet functions documentation"$'\n'$'\n'"> ${pageFooter}"$'\n'$'\n'

  # append each function documentation to the file
  local key documentation
  for key in "${SORTED_FUNCTION_NAMES[@]}"; do
    documentation="RETURNED_ASSOCIATIVE_ARRAY[${key}]"
    content+="${!documentation}"$'\n'$'\n'
  done

  # add footer
  content+=$'\n'$'\n'"> ${pageFooter}"
  io::writeToFile "${outputFile}" "${content}"
}

# This function writes all the function prototypes in a file.
function selfRelease_writeAllFunctionsToPrototypeScript() {
  local pageFooter="${1:-}"
  local outputFile="${2:-}"

  io::createFilePathIfNeeded "${outputFile}"
  io::writeToFile "${outputFile}" "# Valet functions documentation"$'\n'$'\n'

  local content="#""!/usr/bin/env bash
# This script contains the documentation of all the valet library functions.
# It can be used in your editor to provide auto-completion and documentation.
#
# ${pageFooter}

"

  local key functionName documentation line
  for key in "${SORTED_FUNCTION_NAMES[@]}"; do
    functionName="${key}"
    documentation="RETURNED_ASSOCIATIVE_ARRAY[${key}]"
    # add # to each line of the documentation

    local IFS
    while IFS=$'\n' read -rd $'\n' line; do
      content+="# ${line}"$'\n'
    done <<<"${!documentation}"

    content+="function ${functionName}() { :; }"$'\n'$'\n'
  done

  io::writeToFile "${outputFile}" "${content}"
}

# This function writes all the functions to a vscode snippet file.
function selfRelease_writeAllFunctionsToCodeSnippets() {
  local pageFooter="${1:-}"
  local outputFile="${2:-}"

  io::createFilePathIfNeeded "${outputFile}"

  local content="{"$'\n'"// ${pageFooter}"$'\n'

  local key functionName documentation firstSentence body commentedDocumentation
  for key in "${SORTED_FUNCTION_NAMES[@]}"; do
    functionName="${key}"
    documentation="RETURNED_ASSOCIATIVE_ARRAY[${key}]"

    string::extractBetween "${!documentation}" $'\n' "."
    firstSentence="${RETURNED_VALUE#$'\n'}"
    firstSentence="${firstSentence//\/\\/}"
    firstSentence="${firstSentence//'"'/'\"'}"
    firstSentence="${firstSentence//$'\n'/ }"

    body="${functionName}"

    local IFS=$'\n'
    for line in ${!documentation}; do
      if [[ "${line}" =~ "- \$"([0-9@])": "([^_]+)" _as "([^_]+)"_:" ]]; then
        if [[ "${BASH_REMATCH[1]:-}" == "@" ]]; then
          body+=" \"\${99:${BASH_REMATCH[2]}}\""
        else
          body+=" \"\${${BASH_REMATCH[1]}:${BASH_REMATCH[2]}}\""
        fi
      fi
    done
    body+="\$0"

    content+="
		\"${functionName}\": {
		  \"prefix\": \"${functionName}\",
		  \"description\": \"${firstSentence}...\",
		  \"scope\": \"\",
		  \"body\": [ \"${body//\"/\\\"}\" ]
	  },"$'\n'

    commentedDocumentation=""
    while IFS=$'\n' read -rd $'\n' line; do
      commentedDocumentation+="# ${line}"$'\n'
    done <<<"${!documentation}"
    commentedDocumentation="${commentedDocumentation//\\/\\\\}"
    commentedDocumentation="${commentedDocumentation//\"/\\\"}"
    commentedDocumentation="${commentedDocumentation//$/\\\\\$}"
    commentedDocumentation="${commentedDocumentation//$'\n'/\\n}"

    content+="
		\"${functionName}#withdoc\": {
		  \"prefix\": \"${functionName}#withdoc\",
		  \"description\": \"${firstSentence}...\",
		  \"scope\": \"\",
		  \"body\": [ \"${commentedDocumentation}${body//\"/\\\"}\" ]
	  },"$'\n'
  done

  # load the existing file content
  io::readFile "${GLOBAL_VALET_HOME}/extras/base.code-snippets"
  local originalContent="${RETURNED_VALUE}"

  # remove the first line
  originalContent="${originalContent#*$'\n'}"

  io::writeToFile "${outputFile}" "${content}${originalContent}"
}