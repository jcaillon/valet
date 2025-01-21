#!/usr/bin/env bash

function main() {
  test_main::sortCommands
}

# shellcheck disable=SC2034
function test_main::sortCommands() {
  test::title "✅ Testing main::sortCommands"

  # overriding core::getLocalStateDirectory to return a temporary directory
  io::createTempDirectory
  VALET_CONFIG_LOCAL_STATE_DIRECTORY="${RETURNED_VALUE}"
  VALET_CONFIG_REMEMBER_LAST_CHOICES=5


  local -a commands=("cm1  This is command 1"
"cm2  This is command 2"
"sub cmd1  This is sub command 1"
"sub cmd2  This is sub command 2"
"another3  This is another command 3")
  declare -a -g COMMANDS=("${commands[@]}")

  test::printVars VALET_CONFIG_LOCAL_STATE_DIRECTORY VALET_CONFIG_REMEMBER_LAST_CHOICES COMMANDS

  local IFS=$'\n'

  test::markdown "testing commands sort and that without prior choices, the order of commands is kept"
  test::exec main::sortCommands "my-id1" COMMANDS
  test::printVars COMMANDS

  test::markdown "testing commands sort after choosing another3 then cm2"
  test::exec main::addLastChoice "my-id1" "another3"
  test::exec main::addLastChoice "my-id1" "cm2"
  COMMANDS=("${commands[@]}")
  test::exec main::sortCommands "my-id1" COMMANDS
  test::printVars COMMANDS

  test::markdown "testing with VALET_CONFIG_REMEMBER_LAST_CHOICES=0"
  COMMANDS=("${commands[@]}")
  test::exec VALET_CONFIG_REMEMBER_LAST_CHOICES=0 main::sortCommands "my-id1" COMMANDS
  test::printVars COMMANDS

  VALET_CONFIG_REMEMBER_LAST_CHOICES=5

  test::markdown "testing commands sort for another id, the order of commands should be the initial one"
  COMMANDS=("${commands[@]}")
  test::exec main::sortCommands "my-id2" COMMANDS
  test::printVars COMMANDS

  test::markdown "testing that after adding more than x commands, we only keep the last x"
  VALET_CONFIG_REMEMBER_LAST_CHOICES=2
  test::printVars VALET_CONFIG_REMEMBER_LAST_CHOICES
  local -i i
  for i in {1..4}; do
    test::exec main::addLastChoice "my-id1" "cm${i}"
  done
  test::exec io::cat "${VALET_CONFIG_LOCAL_STATE_DIRECTORY}/last-choices-my-id1"

  test::markdown "testing commands that adding the same command multiple times only keeps the last one"
  test::exec main::addLastChoice "my-id1" "another3"
  test::exec main::addLastChoice "my-id1" "another3"
  test::exec main::addLastChoice "my-id1" "another3"
  test::exec io::cat "${VALET_CONFIG_LOCAL_STATE_DIRECTORY}/last-choices-my-id1"
}

main
