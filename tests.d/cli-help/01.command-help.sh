#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-string
source string

function main() {
  test_helpCommand
}

function test_helpCommand() {
  test::title "✅ Get help for self mock3 using fuzzy matching"
  test::exec main::parseMainArguments hel sel mo3


  test::title "✅ Testing help with columns 48"
  test::exec main::parseMainArguments help --columns 48 help


  test::title "✅ Testing that no arguments show the valet help"
  test::exec main::parseMainArguments help


  test::title "✅ Testing that we can display the help of a function using command::showHelp"
  export VALET_CONFIG_ENABLE_COLORS=true
  export VALET_CONFIG_DISABLE_ESC_CODES=false
  export VALET_CONFIG_DISABLE_TEXT_ATTRIBUTES=false
  test::exit "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1 show-help
}

# shellcheck disable=SC2317
function test::scrubOutput() {
  if [[ ${_TEST_OUTPUT} != *$'\n'* ]]; then
    return 0
  fi
  string::head _TEST_OUTPUT 10
  _TEST_OUTPUT="${REPLY}"
}

main
