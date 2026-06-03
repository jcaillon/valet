#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-command
source command

function main() {

  test::title "✅ Testing that we correctly parse arguments and options and fail if they don't match"
  test::exit command::parseProgramArguments self mock1 non-existing-option nonNeededArg1 -derp anotherArg

  test::title "✅ Testing that a command with sudo ask for sudo privileges"
  test::exec command::parseProgramArguments self mock3

  test::title "✅ Testing that valet can be called without any arguments and show the menu"
  # override the local state and config directories to return temp directories
  fs::createTempDirectory
  export VALET_CONFIG_USER_DATA_DIRECTORY="${REPLY}"
  test::exec command::parseProgramArguments

  test::title "✅ Testing that we go into the interactive sub menu with no arguments"
  test::exec command::parseProgramArguments self

  test::title "✅ Testing that we can display the help of a sub menu"
  test::addOutputScrubber head10
  test::exec command::parseProgramArguments self -h
  test::clearOutputScrubbers

  test::title "✅ Testing that we catch option errors of a sub menu"
  test::exit command::parseProgramArguments self --unknown
}

# override sudo to be able to test a command with sudo
function sudo() {
  echo "🙈 mocking sudo $*" 1>&2
}
export -f sudo

# shellcheck disable=SC2317
function command_showInteractiveCommandsMenu() {
  menuHeader="${1}"
  local -n array="${2}"

  echo "🙈 mocking command_showInteractiveCommandsMenu:" 1>&2
  declare -p menuHeader array 1>&2

  REPLY=""
}

function head10() {
  local REPLY
  string::head GLOBAL_TEST_OUTPUT_CONTENT 10
  # shellcheck disable=SC2034
  GLOBAL_TEST_OUTPUT_CONTENT="${REPLY}"
}

main
