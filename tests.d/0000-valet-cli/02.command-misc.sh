#!/usr/bin/env bash

source ".before-test"

function testParseAndCheckArgument() {
  # test that we correctly parse arguments and options and fail is they don't match
  echo "→ valet self test-core --non-existing-option nonNeededArg1 -derp anotherArg"
  ("${VALET_HOME}/valet" self test-core --non-existing-option nonNeededArg1 -derp anotherArg)
  endTest "Testing that we correctly parse arguments and options and fail if they don't match" $?
}

function testCommandWithSudo() {
  # test that a command with sudo ask for sudo privileges
  echo "→ valet showcase sudo-command"
  ("${VALET_HOME}/valet" showcase sudo-command)
  endTest "Testing that a command with sudo ask for sudo privileges" $?
}

function main() {
  testParseAndCheckArgument
  testCommandWithSudo
}

main

source ".after-test"