#!/usr/bin/env bash

builtin source ".before-test"

function testInteractiveSubMenu() {
  export VALET_CONFIG_LOCAL_STATE_DIRECTORY="${TEST_VALET_CONFIG_LOCAL_STATE_DIRECTORY}"

  # test that we go into the interactive menu with no arguments
  echo "→ valet self"
  (main::parseMainArguments self)
  test::endTest "Testing that we go into the interactive sub menu with no arguments" $?

  # test that we can display the help of a sub menu
  echo "→ valet self -h"
  ("${GLOBAL_VALET_HOME}/valet" self -h)
  test::endTest "Testing that we can display the help of a sub menu" $?

  # test that we catch option errors
  echo "→ valet self --unknown"
  ("${GLOBAL_VALET_HOME}/valet" self --unknown) || echo "Failed as expected."
  test::endTest "Testing that we catch option errors in sub menu" 1
}

function main() {
  testInteractiveSubMenu
}

main

builtin source ".after-test"