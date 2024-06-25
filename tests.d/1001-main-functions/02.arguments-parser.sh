#!/usr/bin/env bash

function testMain::parseFunctionArguments() {

  # missing argument
  echo "→ main::parseFunctionArguments selfMock2"
  main::parseFunctionArguments selfMock2 && echo "${RETURNED_VALUE}"
  echo

  # ok
  echo "→ main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 more1 more2"
  main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 more1 more2 && echo "${RETURNED_VALUE}"
  echo

  # missing argument
  echo "→ main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1"
  main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 && echo "${RETURNED_VALUE}"
  echo

  # unknown options
  echo "→ main::parseFunctionArguments selfMock2 -unknown -what optionValue2 arg"
  main::parseFunctionArguments selfMock2 -unknown -what optionValue2 arg && echo "${RETURNED_VALUE}"
  echo

  # ok with the option at the end
  echo "→ main::parseFunctionArguments selfMock2 arg more1 more2 -o"
  main::parseFunctionArguments selfMock2 arg more1 more2 -o && echo "${RETURNED_VALUE}"
  echo

  # fuzzy match the option -this
  echo "→ main::parseFunctionArguments selfMock2 -this arg more1"
  main::parseFunctionArguments selfMock2 -this arg more1 && echo "${RETURNED_VALUE}"
  echo

  # ok, --option1 is interpreted as the value for --this-is-option2
  echo "→ main::parseFunctionArguments selfMock2 --this-is-option2 --option1 arg more1"
  main::parseFunctionArguments selfMock2 --this-is-option2 --option1 arg more1 && echo "${RETURNED_VALUE}"
  echo

  # ok only args
  echo "→ main::parseFunctionArguments selfMock4 arg1 arg2"
  main::parseFunctionArguments selfMock4 arg1 arg2 && echo "${RETURNED_VALUE}"
  echo

  # ok with -- to separate options from args
  echo "→ main::parseFunctionArguments selfMock2 -- --arg1-- --arg2--"
  main::parseFunctionArguments selfMock2 -- --arg1-- --arg2-- && echo "${RETURNED_VALUE}"
  echo
  echo

  # ambiguous fuzzy match
  echo "→ main::parseFunctionArguments selfMock2 arg1 arg2 --th"
  main::parseFunctionArguments selfMock2 arg1 arg2 --th && echo "${RETURNED_VALUE}"
  echo

  test::endTest "Testing main::parseFunctionArguments" 0
}

function main() {
  testMain::parseFunctionArguments
}

main
