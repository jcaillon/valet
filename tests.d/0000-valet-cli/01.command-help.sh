#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".before-test"
fi

function testHelp() {
  # testing to get help for the showcase hello-world command
  echo "→ valet help showcase hello-world"
  ("${VALET_HOME}/valet" help showcase hello-world)
  endTest "Testing help for the showcase hello-world command" $?

  # Testing to fuzzy find an help
  echo "→ valet hel s h"
  ("${VALET_HOME}/valet" hel s h)
  endTest "Testing to fuzzy find an help" $?

  # testing help options
  echo "→ valet help --columns 60 help"
  ("${VALET_HOME}/valet" help --columns 60 help)
  endTest "Testing help with columns 60" $?

  # test that we catch option errors
  echo "→ valet help --unknown -colo"
  ("${VALET_HOME}/valet" help --unknown -colo)
  endTest "Testing that we catch option errors in help" $?

  # test that no arguments show the valet help
  echo "→ valet help"
  ("${VALET_HOME}/valet" help)
  endTest "Testing that no arguments show the valet help" $?
}

function testShowHelp() {
  # test that we can display the help of a function using showHelp
  echo "→ valet self test-core --show-help"
  ("${VALET_HOME}/valet" self test-core --show-help)
  endTest "Testing that we can display the help of a function using showHelp" $?
}

function main() {
  testHelp
  testShowHelp
}

main

source ".after-test"