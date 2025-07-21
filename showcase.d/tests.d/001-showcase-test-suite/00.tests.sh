#!/usr/bin/env bash

# This function demonstrates how to test a function within your script
function main() {
  # make sure to source the file in which these known functions are defined
  command::sourceFunction "showcaseCommand1" 2>/dev/null
  command::sourceFunction "showCaseSudo" 2>/dev/null

  test::title "✅ Testing showcaseCommand1"
  test::exec showcaseCommand1 -o -2 optionValue2 arg1 more1 more2

  testShowCaseSudo
  testOnInterrupt
}

# Another example that reminds you that you can override existing functions
# or variables to test your script
function testShowCaseSudo() {
  test::title "✅ Testing showcaseSudo"
  export SUDO="echo"
  test::exec showCaseSudo
}

# This demonstrates a custom test where we output what we want in the test results file
function testOnInterrupt() {
  test::prompt "trap::onInterrupt"
  if trap::onInterrupt; then
    echo "trap::onInterrupt is working"
  else
    echo "trap::onInterrupt is not working"
  fi
  test::flush
}

main
