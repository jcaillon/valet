#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".before-test"
fi

function testShowInteractiveCommandsMenu() {
  local commands="cm1  	This is command 1
cm2  	This is command 2
sub cmd1  	This is sub command 1
sub cmd2  	This is sub command 2
another3  	This is another command 3"

  # testing showInteractiveCommandsMenu, should return the last line of the input stream
  echo "→ showInteractiveCommandsMenu \"ReturnLast My header"$'\n'"2 lines\" \"${commands}\""
  showInteractiveCommandsMenu "test-menu" "ReturnLast My header"$'\n'"2 lines" "${commands}" && echo "${LAST_RETURNED_VALUE}"
  endTest "Testing showInteractiveCommandsMenu, should return the last line of the input stream" $?
}

function testValetInteractiveMenu() {
  # test that valet can be called without any arguments
  echo "→ valet"
  ("${VALET_HOME}/valet")
  endTest "Testing that valet can be called without any arguments and show the menu" $?
}

function main() {
  testShowInteractiveCommandsMenu
  testValetInteractiveMenu
}

main

source ".after-test"