#!/usr/bin/env bash

# This function demonstrates how to test a function within your script
function testShowcaseCommand1() {
  echo "--- Testing with '-o -2 optionValue2 arg1 more1 more2' ---"
  showcaseCommand1  -o -2 optionValue2 arg1 more1 more2
  endTest "Testing the showcase command1" 0
}

# Another example that reminds you that you can override existing functions
# or variables to test your script
function testShowCaseSudo() {
  SUDO="echo"
  showCaseSudo
  endTest "Testing the showcase sudo command by replacing sudo with echo" 0
}

# This function demonstrates how to test a command by running valet
function testHelloWorld() {
  "${VALET_HOME}/valet" showcase hello-world
  endTest "Testing the hello world command" 0
}

# This demonstrates a custom test where we output what we want in the test results file
function testOnInterrupt() {
  if onInterrupt; then
    echo "onInterrupt is working"
  else
    echo "onInterrupt is not working"
  fi
  endTest "Testing the behavior of onInterrupt" 0
}

function main() {
  # make sure to source the file in which these known functions are defined
  sourceForFunction "showcaseCommand1" 2> /dev/null
  sourceForFunction "showCaseSudo" 2> /dev/null

  testShowcaseCommand1
  testShowCaseSudo
  testHelloWorld
  testOnInterrupt
}

main

# If you need to see something in the console when running the tests,
# you can redirect to the file descriptor 3 (for standard output)
# or 4 (for standard error) like this:
# echo "This is a message that I will see in the terminal when running tests" >&3