#!/usr/bin/env bash

builtin source ".before-test"

function testInteractiveSubMenu() {
  # test that we go into the interactive menu with no arguments
  echo "→ valet self"
  ("${_VALET_HOME}/valet" self)
  endTest "Testing that we go into the interactive sub menu with no arguments" $?

  # test that we can display the help of a sub menu
  echo "→ valet self -h"
  ("${_VALET_HOME}/valet" self -h)
  endTest "Testing that we can display the help of a sub menu" $?

  # test that we catch option errors
  echo "→ valet self --unknown"
  ("${_VALET_HOME}/valet" self --unknown)
  endTest "Testing that we catch option errors in sub menu" $?
}

function main() {
  testInteractiveSubMenu
}

main

builtin source ".after-test"