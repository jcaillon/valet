#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-command
source command

function main() {
  test_globalOptions
  unset -f test::scrubOutput
}

function test_globalOptions() {
  test::title "✅ Testing unknown option"
  test::exit command::parseProgramArguments --logging-leeeevel


  test::title "✅ Testing unknown single letter"
  test::exit command::parseProgramArguments -prof


  test::title "✅ Testing option --version corrected with fuzzy match"
  test::exit command::parseProgramArguments --versin


  test::title "✅ Testing group of single letter options"
  test::setTestCallStack
  test::exit command::parseProgramArguments -vvv --versin
  test::unsetTestCallStack

  test::title "✅ Testing invalid single letter options"
  test::setTestCallStack
  test::exit command::parseProgramArguments -w --versin
  test::unsetTestCallStack

  test::title "✅ Testing invalid letter options"
  test::setTestCallStack
  test::exit command::parseProgramArguments -vvw --versin
  test::unsetTestCallStack
}

# shellcheck disable=SC2317
function test::scrubOutput() {
  GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT/#[0-9]*/1.42.69}"
}

main
