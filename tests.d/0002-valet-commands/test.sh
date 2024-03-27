#!/usr/bin/env bash

# we will run "${VALET_HOME}/valet" commands so we need to set the correct user directory
export VALET_USER_DIRECTORY="${VALET_HOME}/examples.d"

# setting up "${VALET_HOME}/valet" to minimize output difference between 2 runs
export VALET_NO_COLOR="true"
export VALET_NO_TIMESTAMP="true"
export VALET_NO_ICON="true"
export VALET_NO_WRAP="true"
export _COLUMNS=120

function testHelp() {
  # testing to get help for the showcase hello-world command
  "${VALET_HOME}/valet" help showcase hello-world
  endTest "Testing help for the showcase hello-world command" $?

  # Testing to fuzzy find command
  "${VALET_HOME}/valet" h s h
  endTest "Testing to fuzzy find command" $?

  # testing help options
  echo "------------------------------------------------------------"
  "${VALET_HOME}/valet" help --columns 60 help
  endTest "Testing help with columns 60" $?

  # test that we catch option errors
  "${VALET_HOME}/valet" help --unknown -colo
  endTest "Testing that we catch option errors" $?

  # test that no arguments show the valet help
  "${VALET_HOME}/valet" help
  endTest "Testing that no arguments show the valet help" $?
}

function testSubMenu() {
  # test that we can display the help of a sub menu
  "${VALET_HOME}/valet" self -h
  endTest "Testing that we can display the help of a sub menu" $?
}

function testShowHelp() {
  # test that we can display the help of a function using showHelp
  "${VALET_HOME}/valet" self test-core --show-help
  endTest "Testing that we can display the help of a function using showHelp" $?
}

function testParseAndCheckArgument() {
  # test that we correctly parse arguments and options and fail is they don't match
  "${VALET_HOME}/valet" self test-core --non-existing-option nonNeededArg1 -derp anotherArg
  endTest "Testing that we correctly parse arguments and options and fail is they don't match" $?
}

# TODO: test parser

function main() {
  testHelp
  testSubMenu
  testShowHelp
  testParseAndCheckArgument
}

main
