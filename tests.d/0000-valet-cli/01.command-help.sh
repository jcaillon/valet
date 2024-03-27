#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".common-utils"
fi

function testHelp() {
  # testing to get help for the showcase hello-world command
  "${VALET_HOME}/valet" help showcase hello-world
  endTest "Testing help for the showcase hello-world command" $?

  # Testing to fuzzy find command
  "${VALET_HOME}/valet" hel s h
  endTest "Testing to fuzzy find command" $?

  # testing help options
  echo "------------------------------------------------------------"
  "${VALET_HOME}/valet" help --columns 60 help
  endTest "Testing help with columns 60" $?

  # test that we catch option errors
  "${VALET_HOME}/valet" help --unknown -colo
  endTest "Testing that we catch option errors in help" $?

  # test that no arguments show the valet help
  "${VALET_HOME}/valet" help
  endTest "Testing that no arguments show the valet help" $?
}

function testShowHelp() {
  # test that we can display the help of a function using showHelp
  "${VALET_HOME}/valet" self test-core --show-help
  endTest "Testing that we can display the help of a function using showHelp" $?
}

function main() {
  testHelp
  testShowHelp
}

main

source ".cleanup"