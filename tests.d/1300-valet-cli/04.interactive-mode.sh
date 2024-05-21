#!/usr/bin/env bash

builtin source ".before-test"

function testValetInteractiveMenu() {
  export VALET_CONFIG_LOCAL_STATE_DIRECTORY="${TEST_VALET_CONFIG_LOCAL_STATE_DIRECTORY}"

  # test that valet can be called without any arguments
  echo "→ valet"
  (main::parseMainArguments)
  test::endTest "Testing that valet can be called without any arguments and show the menu" $?
}

function main() {
  testValetInteractiveMenu
}

main

builtin source ".after-test"