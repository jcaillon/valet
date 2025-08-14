#!/usr/bin/env bash

# This function demonstrates how to test a function within your script
function main() {
  # make sure to source the file in which that function is defined
  command::sourceFunction "showcaseCommand1" 2>/dev/null

  test_showcaseCommand1
  test_trap::onCleanUp
}

# Another example that reminds you that you can override existing functions
# or variables to test your script
function test_showcaseCommand1() {
  test::title "✅ Testing showcaseCommand1"
  VALET_OPTION1="my opt 1"
  test::exec showcaseCommand1 arg1 arg2

  test::title "✅ Testing showcaseCommand1"
  test::exec showcaseCommand1 -o -2 optionValue2 arg1 more1 more2
}

# This demonstrates a custom test where we output what we want in the test results file
function test_trap::onCleanUp() {
  test::prompt "trap::onCleanUp"
  if trap::onCleanUp; then
    echo "trap::onCleanUp is working"
  else
    echo "trap::onCleanUp is not working"
  fi
  test::flush
}

main
