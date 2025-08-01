#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-command
source command
# shellcheck source=../../libraries.d/lib-string
source string

function main() {
  test_helpCommand
}

function test_helpCommand() {
  test::title "✅ Get help for self mock3 using fuzzy matching"
  test::exec command::parseProgramArguments hel sel mo3


  test::title "✅ Testing help with columns 48"
  test::exec command::parseProgramArguments help --columns 48 help


  test::title "✅ Testing that no arguments show the valet help"
  test::exec command::parseProgramArguments help


  test::title "✅ Testing that we can display the help of a function using command::showHelp"
  export VALET_CONFIG_ENABLE_COLORS=true
  export VALET_CONFIG_DISABLE_ESC_CODES=false
  export VALET_CONFIG_DISABLE_TEXT_ATTRIBUTES=false
  test::exit "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1 show-help
}

# shellcheck disable=SC2317
function test::scrubOutput() {
  if [[ ${GLOBAL_TEST_OUTPUT_CONTENT} != *$'\n'* ]]; then
    return 0
  fi
  string::head GLOBAL_TEST_OUTPUT_CONTENT 10
  GLOBAL_TEST_OUTPUT_CONTENT="${REPLY}"
}

main
