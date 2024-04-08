#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet)
if [[ -z "${_CORE_INCLUDED:-}" ]]; then
  VALETD_DIR="${BASH_SOURCE[0]}"
  if [[ "${VALETD_DIR}" != /* ]]; then
    if pushd "${VALETD_DIR%/*}" &>/dev/null; then
      VALETD_DIR="${PWD}"
      popd &>/dev/null || true
    else VALETD_DIR="${PWD}"; fi
  else VALETD_DIR="${VALETD_DIR%/*}"; fi
  # shellcheck source=../core
  source "${VALETD_DIR%/*}/core"
fi
# --- END OF COMMAND COMMON PART

: "---
command: help
function: showCommandHelp
shortDescription: Show the help this program or of a specific command.
description: |-
  Show the help this program or of the help of a specific command.

  You can show the help with or without colors and set the maximum columns for the help text.
arguments:
- name: commands?...
  description: |-
    The name of the command to show the help for.
    If not provided, show the help for the program.
options:
- name: -n, --no-colors
  description: |-
    Do not use any colors in the output
- name: -c, --columns <number>
  description: |-
    Set the maximum columns for the help text
examples:
- name: help cmd
  description: |-
    Shows the help for the command ⌜cmd⌝
- name: help cmd subCmd
  description: |-
    Shows the help for the sub command ⌜subCmd⌝ of the command ⌜cmd⌝
- name: help --no-colors --columns 50
  description: |-
    Shows the help for the program without any color and with a maximum of 50 columns
---"
# show the help of the given command (can be blank to show the root help)
# e.g. showCommandHelp "cmd1 subcmd2"
function showCommandHelp() {
  local -a commands
  local parsingErrors help columns noColors help
  main::parseFunctionArguments "${FUNCNAME[0]}" "$@"
  eval "${LAST_RETURNED_VALUE}"

  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  # show the program help if no commands are provided
  if [[ ${#commands[@]} -eq 0 ]]; then
    main::printHelp function "this" "${noColors:-}" "${columns:-}"
    return 0
  fi

  local functionName exactCommand
  main::fuzzyMatchCommandtoFunctionName "${commands[@]}"
  functionName="${LAST_RETURNED_VALUE:-}"
  exactCommand="${LAST_RETURNED_VALUE3:-}"
  if [[ -z "${functionName}" ]]; then
    core::fail "Could not show the help because the command ⌜${commands[*]}⌝ does not exist."
  fi

  if [[ ${functionName} == "_menu" ]]; then
    main::printHelp menu "${exactCommand}" "${noColors:-}" "${columns:-}"
  else
    main::printHelp function "${functionName}" "${noColors:-}" "${columns:-}"
  fi
}