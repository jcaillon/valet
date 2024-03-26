#!/usr/bin/env bash

# we will run valet commands so we need to set the correct user directory
export VALET_USER_DIRECTORY="${VALET_HOME}/examples.d"

# setting up valet to minimize output difference between 2 runs
export VALET_NO_COLOR="true"
export VALET_NO_TIMESTAMP="true"
export VALET_NO_ICON="true"
export _COLUMNS=120

function testHelp() {
  export VALET_NO_COLORS="true"

  # testing to get help for the showcase hello-world command
  valet help showcase hello-world
  endSubTest "Testing help for the showcase hello-world command" $?

  # Testing to fuzzy find command
  valet h s h
  endSubTest "Testing to fuzzy find command" $?

  # testing help options
  echo "------------------------------------------------------------"
  valet help --columns 60 help
  endSubTest "Testing help with columns 60" $?
}

# TODO: test parser

function main() {
  testHelp
}

main
