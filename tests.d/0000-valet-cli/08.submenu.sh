#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".before-test"
fi

function testInteractiveSubMenu() {
  # test that we go into the interactive menu with no arguments
  "${VALET_HOME}/valet" self 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endTest "Testing that we go into the interactive sub menu with no arguments" $?

  # test that we can display the help of a sub menu
  "${VALET_HOME}/valet" self -h
  endTest "Testing that we can display the help of a sub menu" $?

  # test that we catch option errors
  "${VALET_HOME}/valet" self --unknown
  endTest "Testing that we catch option errors in sub menu" $?

  # test that we go into the interactive menu with no arguments
  "${VALET_HOME}/valet" self 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endTest "Testing that we go into the interactive menu with no arguments" $?
}

function main() {
  testInteractiveSubMenu
}

main

source ".after-test"