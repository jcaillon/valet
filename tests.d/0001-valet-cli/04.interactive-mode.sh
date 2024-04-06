#!/usr/bin/env bash

builtin source ".before-test"

function testValetInteractiveMenu() {
  # test that valet can be called without any arguments
  echo "→ valet"
  ("${VALET_HOME}/valet")
  endTest "Testing that valet can be called without any arguments and show the menu" $?
}

function main() {
  testValetInteractiveMenu
}

main

builtin source ".after-test"