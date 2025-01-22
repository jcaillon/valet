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

: "---
command: help
function: showCommandHelp
shortDescription: Show the help of this program or of a specific command.
description: |-
  Show the help of this program or of the help of a specific command.

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
  command::parseFunctionArguments "${FUNCNAME[0]:-}" "$@"
  eval "${RETURNED_VALUE}"

  command::checkParsedResults

  # show the program help if no commands are provided
  if [[ ${#commands[@]} -eq 0 ]]; then
    main::printHelp function "this" "${noColors:-}" "${columns:-}"
    return 0
  fi

  local functionName exactCommand
  main::fuzzyMatchCommandToFunctionNameOrFail "${commands[@]}"
  functionName="${RETURNED_VALUE:-}"
  exactCommand="${RETURNED_VALUE3:-}"

  if [[ ${functionName} == "_menu" ]]; then
    main::printHelp menu "${exactCommand}" "${noColors:-}" "${columns:-}"
  else
    main::printHelp function "${functionName}" "${noColors:-}" "${columns:-}"
  fi
}