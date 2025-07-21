#!/usr/bin/env bash

function main() {
  test_globalOptions
  unset -f test::scrubOutput
}

function test_globalOptions() {
  test::title "✅ Testing unknown option"
  test::exit main::parseMainArguments --logging-leeeevel


  test::title "✅ Testing unknown single letter"
  test::exit main::parseMainArguments -prof


  test::title "✅ Testing option --version corrected with fuzzy match"
  test::exit main::parseMainArguments --versin


  test::title "✅ Testing group of single letter options"
  test::exit main::parseMainArguments -vwvw --versin
}

# shellcheck disable=SC2317
function test::scrubOutput() {
  _TEST_OUTPUT="${_TEST_OUTPUT/#[0-9]*/1.42.69}"
}

main
