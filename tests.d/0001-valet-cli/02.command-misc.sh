#!/usr/bin/env bash

builtin source ".before-test"

function testParseAndCheckArgument() {
  # test that we correctly parse arguments and options and fail is they don't match
  echo "→ valet self mock1 non-existing-option nonNeededArg1 -derp anotherArg"
  ("${VALET_HOME}/valet" self mock1 non-existing-option nonNeededArg1 -derp anotherArg)
  endTest "Testing that we correctly parse arguments and options and fail if they don't match" $?
}

function testCommandWithSudo() {
  # test that a command with sudo ask for sudo privileges
  echo "→ valet self mock3"
  ("${VALET_HOME}/valet" self mock3)
  endTest "Testing that a command with sudo ask for sudo privileges" $?
}

function main() {
  testParseAndCheckArgument
  testCommandWithSudo
}

main

builtin source ".after-test"