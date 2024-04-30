#!/usr/bin/env bash

builtin source ".before-test"

function testParseAndCheckArgument() {
  # test that we correctly parse arguments and options and fail is they don't match
  echo "→ valet self mock1 non-existing-option nonNeededArg1 -derp anotherArg"
  ("${GLOBAL_VALET_HOME}/valet" self mock1 non-existing-option nonNeededArg1 -derp anotherArg) || echo "Failed as expected."
  endTest "Testing that we correctly parse arguments and options and fail if they don't match" 1
}

function testCommandWithSudo() {
  # test that a command with sudo ask for sudo privileges
  echo "→ valet self mock3"
  ("${GLOBAL_VALET_HOME}/valet" self mock3)
  endTest "Testing that a command with sudo ask for sudo privileges" $?
}

function main() {
  testParseAndCheckArgument
  testCommandWithSudo
}

main

builtin source ".after-test"