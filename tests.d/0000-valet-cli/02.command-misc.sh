#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".common-utils"
fi

function testParseAndCheckArgument() {
  # test that we correctly parse arguments and options and fail is they don't match
  "${VALET_HOME}/valet" self test-core --non-existing-option nonNeededArg1 -derp anotherArg
  endTest "Testing that we correctly parse arguments and options and fail is they don't match" $?
}

function testCommandWithSudo() {
  # test that a command with sudo ask for sudo privileges
  "${VALET_HOME}/valet" showcase sudo-command
  endTest "Testing that a command with sudo ask for sudo privileges" $?
}

function main() {
  testParseAndCheckArgument
  testCommandWithSudo
}

main

source ".cleanup"