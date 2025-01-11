#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../libraries.d/core
  source "$(dirname -- "$(command -v valet)")/libraries.d/core"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> command: self export
#===============================================================

##<<VALET_COMMAND
# command: self export
# function: selfExport
# hideInMenu: true
# author: github.com/jcaillon
# shortDescription: Returns a string that can be evaluated to have Valet functions in bash.
# description: |-
#   If you want to use Valet functions directly in bash, you can use this command like this:
#
#   ```bash
#   eval "$(valet self export)"
#   ```
#
#   This will source valet to be able to use its functions as if you were in a command script.
#
#   You can optionally export all the functions if needed.
# options:
# - name: -a, --source-all-functions
#   description: |-
#     Will immediately source all the libraries functions.
# - name: -E, --no-exit
#   description: |-
#     Override the ⌜core::fail⌝ and ⌜core::failWithCode⌝ functions to not exit the script.
# examples:
# - name: !eval "$(valet self export)"
#   description: |-
#     Source valet functions in your bash script or bash prompt.
#     You can then can then use valet function as if you were in a command script.
##VALET_COMMAND
function selfExport() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  local output=""

  # source valet core library, disable some traps
  output+="source \"${GLOBAL_VALET_HOME}/libraries.d/core\""$'\n'
  output+="trap SIGINT; trap SIGQUIT; trap SIGHUP; trap SIGTERM;"$'\n'

  if [[ ${sourceAllFunctions:-} == "true" ]]; then
    # source all libraries
    local library
    for library in "${GLOBAL_VALET_HOME}/libraries.d/lib-"*; do
      local libraryName="${library##*lib-}"
      libraryName="${libraryName%lib-}"
      log::debug "Exporting library: ⌜${libraryName}⌝."
      output+="source ${libraryName}"$'\n'
    done
  fi

  if [[ ${noExit:-} == "true" ]]; then
    output+="function core::fail() { log::error \"\$@\"; }"$'\n'
    output+="function core::failWithCode() { local exitCode=\"\${1}\"; shift; log::error \"\$@\"; log::error \"Exit code: \$exitCode\"; }"$'\n'
    output+="set +o errexit"
  fi

  echo "${output}"
}

# Adds all the core function definitions and variables to the output variable.
# Optionally adds all the library functions as well.
function selfExport_declareFunctions() {
# shellcheck disable=SC1091
  source io

  # export all self sufficient functions from the core library
  io::invoke declare -f \
    core::fail \
    core::failWithCode \
    io::createTempFile \
    io::createTempDirectory \
    io::cleanupTempFiles \
    core::reExportFuncToUseGlobalVars \
    source
  output+="${RETURNED_VALUE//declare -? /}"$'\n'
  selfExport_functionsForLibrary log && output+="${RETURNED_VALUE}"$'\n'
  selfExport_functionsForLibrary string && output+="${RETURNED_VALUE}"$'\n'
  selfExport_functionsForLibrary array && output+="${RETURNED_VALUE}"$'\n'

  # export all libraries
  local library
  if [[ ${declareAllFunctions:-} == "true" ]]; then
    for library in "${GLOBAL_VALET_HOME}/libraries.d/lib-"*; do
      local -i lineNumber=0
      log::debug "Exporting library: ⌜${library}⌝."

      # read the library file line by line
      local IFS
      while IFS=$'\n' read -r -d $'\n' line|| [[ -n ${line:-} ]]; do
        if [[ ${lineNumber} -gt 1 && ${line} != "source "* ]]; then
          output+="${line}"$'\n'
        fi
        lineNumber+=1
      done < "${library}"
    done

    # add important shell options for interactive functions
    output+=$'\n'"set +o monitor +o notify"$'\n'
  fi

  # replace all source * calls
  for library in "${GLOBAL_VALET_HOME}/libraries.d/lib-"*; do
    output="${output//source ${library}/:}"
  done

  # export all the necessary variables
  # shellcheck disable=SC2086
  io::invoke declare -p ${!VALET_CONFIG_*} ${!GLOBAL_*}
  output+="${RETURNED_VALUE//declare -? /}"$'\n'
}

# Export all the functions for a library.
#
# $1: the name of the library to export the functions for.
#
# Returns:
#   Returns 0 if the library has been found and functions have been exported.
#   The string to evaluate in the global variable RETURNED_VALUE.
#   Returns 1 no functions were found.
#
# Usage:
#   selfExport_functionsForLibrary log
function selfExport_functionsForLibrary() {
  local libraryName="${1}"

  log::debug "Exporting functions for library: ⌜${libraryName}⌝."

  io::invoke compgen -A 'function' "${libraryName}::"
  local filteredListOfFunctions="${RETURNED_VALUE//$'\n'/ }"

  # leave if empty
  if [[ -z ${filteredListOfFunctions} ]]; then
    return 1
  fi

  local IFS=' '
  # shellcheck disable=SC2086
  io::invoke declare -f ${filteredListOfFunctions}

  RETURNED_VALUE="${RETURNED_VALUE//declare -? /}"

  return 0
}