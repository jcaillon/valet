#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ ! -v GLOBAL_CORE_INCLUDED ]]; then
  # shellcheck source=../libraries.d/core
  source "$(valet --source)"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-system
source system
# shellcheck source=../libraries.d/lib-array
source array
# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-time
source time

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
  command::parseArguments "$@" && eval "${REPLY}"
  command::checkParsedResults

  # default output to the user directory
  core::getExtensionsDirectory
  output="${output:-${REPLY}}"

  selfDocument::getFooter
  local pageFooter="${REPLY}"

  # export the documentation for each library
  selfDocument::getAllFunctionsDocumentation "${coreOnly}"

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
# - `REPLY` the footer for the documentation.
#
# ```bash
# selfDocument::getFooter
# echo "${REPLY}"
# ```
function selfDocument::getFooter() {
  core::getVersion
  local version="${REPLY}"

  time::getDate "%(%F)T"
  local currentDate="${REPLY}"
  REPLY="Documentation generated for the version ${version} (${currentDate})."
}

# Returns an associative array of all the function names and their documentation.
# The key is the function name and the value is the documentation.
# The documentation is the content of the comment block above the function.
# The comment block should start with a `# ##` to be considered as a documentation block.
#
# Returns:
#
# - ${REPLY_ASSOCIATIVE_ARRAY}: an associative array of all the function names and their documentation.
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

  # get all the files in the libraries.d directory
  fs::listFiles "${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d"
  local -a filesToAnalyze=("${REPLY_ARRAY[@]}")

  # add each file of each user library directory
  if [[ ${coreOnly} != "true" ]]; then
    local libraryDirectory
    for libraryDirectory in "${CMD_LIBRARY_DIRECTORIES[@]}"; do
      fs::listFiles "${libraryDirectory}"
      filesToAnalyze+=("${REPLY_ARRAY[@]}")
    done
  fi

  local IFS=$'\n'
  if log::isDebugEnabled; then
    log::debug "Analyzing the following files:"
    local file
    for file in "${filesToAnalyze[@]}"; do
      log::printString "- ${file}"
    done
  fi

  unset -v REPLY_ASSOCIATIVE_ARRAY SORTED_FUNCTION_NAMES
  declare -g -A REPLY_ASSOCIATIVE_ARRAY=()

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
        if [[ ${line} == "# ##"* && ${line} != *"(private)"*  && ${line} != *"(deprecated)"* ]]; then
          reading=true
        else
          continue
        fi
      fi

      if [[ ${line} != "#"* ]]; then
        reading=false
        string::extractBetween functionDocumentation "## " $'\n'
        string::trimEdges REPLY
        functionName="${REPLY}"
        log::trace "Found function: ⌜${functionName}⌝"
        functionDocumentation="${functionDocumentation%%"shellcheck disable="*}"
        REPLY_ASSOCIATIVE_ARRAY["${functionName}"]="${functionDocumentation}"
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

  log::info "Found ${#REPLY_ASSOCIATIVE_ARRAY[@]} functions with documentation."

  if log::isTraceEnabled; then
    log::trace "The functions with their documentation are:"
    local key
    for key in "${!REPLY_ASSOCIATIVE_ARRAY[@]}"; do
      log::trace "Function: ⌜${key}⌝"
      local _documentationString="${REPLY_ASSOCIATIVE_ARRAY[${key}]}"
      log::printFileString _documentationString
    done
  fi

  # sort the functions by name
  declare -g -a SORTED_FUNCTION_NAMES=("${!REPLY_ASSOCIATIVE_ARRAY[@]}")
  array::sort SORTED_FUNCTION_NAMES
}

# This function writes all the functions documentation to a given file.
function selfRelease_writeAllFunctionsToMarkdown() {
  local pageFooter="${1:-}"
  local outputFile="${2:-}"

  fs::createFileIfNeeded "${outputFile}"

  local content="# Valet functions documentation"$'\n'$'\n'"> ${pageFooter}"$'\n'$'\n'

  # append each function documentation to the file
  local key documentation
  for key in "${SORTED_FUNCTION_NAMES[@]}"; do
    documentation="REPLY_ASSOCIATIVE_ARRAY[${key}]"
    content+="${!documentation}"$'\n'
  done

  # add footer
  content+=$'\n'$'\n'"> ${pageFooter}"
  fs::writeToFile "${outputFile}" content
}

# This function writes all the function prototypes in a file.
function selfRelease_writeAllFunctionsToPrototypeScript() {
  local pageFooter="${1:-}"
  local outputFile="${2:-}"

  fs::createFileIfNeeded "${outputFile}"
  local _title="# Valet functions documentation"$'\n'$'\n'
  fs::writeToFile "${outputFile}" _title

  local content="#""!/usr/bin/env bash
# This script contains the documentation of all the valet library functions.
# It can be used in your editor to provide auto-completion and documentation.
#
# ${pageFooter}

"

  local key functionName documentation line
  for key in "${SORTED_FUNCTION_NAMES[@]}"; do
    functionName="${key}"
    documentation="REPLY_ASSOCIATIVE_ARRAY[${key}]"
    # add # to each line of the documentation

    local IFS
    while IFS=$'\n' read -rd $'\n' line; do
      content+="# ${line}"$'\n'
    done <<<"${!documentation}"

    content+="function ${functionName}() { :; }"$'\n'$'\n'
  done

  fs::writeToFile "${outputFile}" content
}

# This function writes all the functions to a vscode snippet file.
function selfRelease_writeAllFunctionsToCodeSnippets() {
  local pageFooter="${1:-}"
  local outputFile="${2:-}"

  fs::createFileIfNeeded "${outputFile}"

  local content="{"$'\n'"// ${pageFooter}"$'\n'

  local -i tabOrder
  local key functionName documentation body options commentedDocumentation
  for key in "${SORTED_FUNCTION_NAMES[@]}"; do
    functionName="${key}"
    documentation="REPLY_ASSOCIATIVE_ARRAY[${key}]"

    local description="${!documentation}"
    string::extractBetween description $'\n' "."
    description="${REPLY#$'\n'}"
    description="${description//\/\\/}"
    description="${description//'"'/'\"'}"
    description="${description//$'\n'/ }"

    body="${functionName}"
    options=""
    tabOrder=1

    local IFS=$'\n'
    for line in ${!documentation}; do
      if [[ "${line}" =~ "- \$"([0-9@])": "([^_]+)" _as "([^_]+)"_:" ]]; then
        body+=" \"\${${tabOrder}:${BASH_REMATCH[2]}}\""
        tabOrder+=1
      elif [[ "${line}" =~ "- \${"([[:alpha:]_]+)"} _as "([^_]+)"_:" ]]; then
        options+="${BASH_REMATCH[1]}=\${${tabOrder}} "
        tabOrder+=1
      fi
    done
    body+="\$0"

    content+="
\"${functionName}\": {
  \"prefix\": \"${functionName}\",
  \"description\": \"${description}...\",
  \"scope\": \"\",
  \"body\": [ \"${options}${body//\"/\\\"}\" ]
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
  \"description\": \"${description}...\",
  \"scope\": \"\",
  \"body\": [ \"${commentedDocumentation}${options}${body//\"/\\\"}\" ]
},"$'\n'
  done

  # load the existing file content
  fs::readFile "${GLOBAL_INSTALLATION_DIRECTORY}/extras/base.code-snippets"
  local originalContent="${REPLY}"

  # remove the first line
  originalContent="${originalContent#*$'\n'}"

  fs::writeToFile "${outputFile}" content
  fs::writeToFile "${outputFile}" originalContent true
}
