#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> command: self export
#===============================================================

: "---
command: self export
function: selfExport
hideInMenu: true
author: github.com/jcaillon
shortDescription: Returns a string that can be evaluated to have Valet functions in bash.
description: |-
  If you want to use Valet functions directly in bash, you can use this command like this:

  "'
  eval "$(valet self export)"
  '"

  This will export all the necessary functions and variables to use the Valet log library by default.

  You can optionally export all the functions if needed.
options:
- name: -a, --export-all
  description: |-
    Export all the libraries.
---"
function selfExport() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  local output

  # shellcheck disable=SC1091
  source io

  # export all the necessary variables
  io::invoke declare -p ${!VALET_CONFIG_*} ${!GLOBAL_*}
  output+="${RETURNED_VALUE//declare -? /}"$'\n'

  # export all the log functions
  exportFunctionsForLibrary log
  output+="${RETURNED_VALUE//declare -? /}"$'\n'

  # export all the log functions
  exportFunctionsForLibrary string
  output+="${RETURNED_VALUE//declare -? /}"$'\n'

  # export all libraries
  if [[ ${exportAll:-} == "true" ]]; then
    local library
    for library in "${GLOBAL_VALET_HOME}/valet.d/lib-"*; do
      local -i lineNumber=0

      # read the library file line by line
      while IFS=$'\n' read -r line|| [[ -n ${line:-} ]]; do
        if [[ ${lineNumber} -gt 1 && ${line} != "source "* ]]; then
          output+="${line}"$'\n'
        fi
        lineNumber+=1
      done < "${library}"
    done
  fi

  echo "${output}"
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
#   exportFunctionsForLibrary log
function exportFunctionsForLibrary() {
  local libraryName="${1}"

  io::invoke declare -F
  local listOfFunctions="${RETURNED_VALUE//declare -? /}"

  listOfFunctions="${listOfFunctions//$'\n'/ }"
  local -a filteredListOfFunctions=()
  for function in ${listOfFunctions}; do
    if [[ "${function}" == "${libraryName}::"* ]]; then
      filteredListOfFunctions+=("${function}")
    fi
  done

  # leave if empty
  if [[ ${#filteredListOfFunctions[@]} -eq 0 ]]; then
    return 1
  fi

  io::invoke declare -f "${filteredListOfFunctions[@]}"

  RETURNED_VALUE="${RETURNED_VALUE//declare -? /}"

  return 0
}