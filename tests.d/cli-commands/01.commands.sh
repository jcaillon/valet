#!/usr/bin/env bash

function main() {

  test::title "✅ Testing that we correctly parse arguments and options and fail if they don't match"
  test::exit main::parseMainArguments self mock1 non-existing-option nonNeededArg1 -derp anotherArg


  test::title "✅ Testing that a command with sudo ask for sudo privileges"
  test::exec main::parseMainArguments self mock3


  test::title "✅ Testing that valet can be called without any arguments and show the menu"
    # override the local state and config directories to return temp directories
  fs::createTempDirectory
  export VALET_CONFIG_USER_DATA_DIRECTORY="${REPLY}"
  test::exec main::parseMainArguments


  test::title "✅ Testing that we go into the interactive sub menu with no arguments"
  test::exec main::parseMainArguments self


  test::title "✅ Testing that we can display the help of a sub menu"
  # shellcheck disable=SC2317
  function test::scrubOutput() { string::head _TEST_OUTPUT 10; _TEST_OUTPUT="${REPLY}"; }
  test::exec main::parseMainArguments self -h
  unset -f test::scrubOutput


  test::title "✅ Testing that we catch option errors of a sub menu"
  test::exit main::parseMainArguments self --unknown
}

# override sudo to be able to test a command with sudo
function sudo() {
  echo "🙈 mocking sudo $*" 1>&2
}
export -f sudo

# shellcheck disable=SC2317
function main::showInteractiveCommandsMenu() {
  menuHeader="${1}"
  local -n array="${2}"

  echo "🙈 mocking main::showInteractiveCommandsMenu:" 1>&2
  declare -p menuHeader array 1>&2

  REPLY=""
}

main