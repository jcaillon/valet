#!/usr/bin/env bash

builtin source ".before-test"

function testHelp() {
  # testing to get help for the self mock2 command
  echo "→ valet help self mock2"
  ("${VALET_HOME}/valet" help self mock2)
  endTest "Testing help for the self mock2 command" $?

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

function testCoreShowHelp() {
  # test that we can display the help of a function using core::showHelp
  echo "→ valet self mock1 show-help"
  ("${VALET_HOME}/valet" self mock1 show-help)
  endTest "Testing that we can display the help of a function using core::showHelp" $?
}

function main() {
  testHelp
  testCoreShowHelp
}

main

builtin source ".after-test"