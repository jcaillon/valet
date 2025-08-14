#!/usr/bin/env bash
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# shellcheck source=../libraries.d/lib-command
source command

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
  local commandArgumentsErrors help columns help
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults

  # show the program help if no commands are provided
  if [[ ${#commands[@]} -eq 0 ]]; then
    command::printHelp function "this" "${columns:-}"
    return 0
  fi

  local functionName exactCommand
  command::fuzzyMatchCommandToFunctionNameOrFail "${commands[@]}"
  functionName="${REPLY:-}"
  exactCommand="${REPLY3:-}"

  if [[ ${functionName} == "_menu" ]]; then
    command::printHelp menu "${exactCommand}" "${columns:-}"
  else
    command::printHelp function "${functionName}" "${columns:-}"
  fi
}