#!/usr/bin/env bash

builtin source ".before-test"

function testHelp() {
  # Get help for self mock3 using fuzzy matching
  echo "→ valet hel sel mo3"
  (main::parseMainArguments hel sel mo3) && echo "Exiting with code 0."
  test::endTest "Get help for self mock3 using fuzzy matching" $?

  # testing help options
  echo "→ valet help --columns 48 help"
  "${GLOBAL_VALET_HOME}/valet" help --columns 48 help
  test::endTest "Testing help with columns 48" $?

  # test that we catch option errors
  echo "→ valet help --unknown -colo"
  ("${GLOBAL_VALET_HOME}/valet" help --unknown --colo) || echo "Failed as expected."
  test::endTest "Testing that we catch option errors in help" 1

  # test that no arguments show the valet help
  echo "→ valet help"
  local output
  output="$("${GLOBAL_VALET_HOME}/valet" help 2>&1)"
  if [[ ${output} == *"valet [global options] [command]"* ]]; then
    echo "OK, we got the valet help."
  else
    echo "KO, we did not get the valet help."
  fi
  test::endTest "Testing that no arguments show the valet help" $?
}

function testCoreShowHelp() {
  # test that we can display the help of a function using core::showHelp
  echo "→ valet self mock1 show-help"
  ("${GLOBAL_VALET_HOME}/valet" self mock1 show-help)
  test::endTest "Testing that we can display the help of a function using core::showHelp" $?
}

function main() {
  testHelp
  testCoreShowHelp
}

main

builtin source ".after-test"