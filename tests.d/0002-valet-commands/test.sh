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
  export VALET_NO_COLORS="true"

  # testing to get help for the showcase hello-world command
  "${VALET_HOME}/valet" help showcase hello-world
  endSubTest "Testing help for the showcase hello-world command" $?

  # Testing to fuzzy find command
  "${VALET_HOME}/valet" h s h
  endSubTest "Testing to fuzzy find command" $?

  # testing help options
  echo "------------------------------------------------------------"
  "${VALET_HOME}/valet" help --columns 60 help
  endSubTest "Testing help with columns 60" $?

  # test that we catch option errors
  "${VALET_HOME}/valet" help --unknown -colo
  endSubTest "Testing that we catch option errors" $?

  # test that no arguments show the valet help
  "${VALET_HOME}/valet" help
  endSubTest "Testing that no arguments show the valet help" $?
}

# TODO: test parser

function main() {
  testHelp
}

main
