#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".common-utils"
fi

function testShowInteractiveCommandsMenu() {
  local commands="cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3"

  export VALET_HOME="${ORIGINAL_VALET_HOME}"

  # testing showInteractiveCommandsMenu, should return the last line of the input stream
  showInteractiveCommandsMenu "ReturnLast My header"$'\n'"2 lines" "${commands}" && echo "${LAST_RETURNED_VALUE}" 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endTest "Testing showInteractiveCommandsMenu, should return the last line of the input stream" $?
}

function testValetInteractiveMenu() {
  # test that valet can be called without any arguments
  "${VALET_HOME}/valet" 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endTest "Testing that valet can be called without any arguments and show the menu" $?
}

function main() {
  testShowInteractiveCommandsMenu
  testValetInteractiveMenu
}

main

source ".cleanup"