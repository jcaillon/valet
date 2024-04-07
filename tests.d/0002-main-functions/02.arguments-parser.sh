#!/usr/bin/env bash

function testMain::parseFunctionArguments() {

  echo "→ main::parseFunctionArguments selfTestCore2"
  main::parseFunctionArguments selfTestCore2 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ main::parseFunctionArguments selfTestCore2 -o -2 optionValue2 arg1 more1 more2"
  main::parseFunctionArguments selfTestCore2 -o -2 optionValue2 arg1 more1 more2 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ main::parseFunctionArguments selfTestCore2 -o -2 optionValue2 arg1"
  main::parseFunctionArguments selfTestCore2 -o -2 optionValue2 arg1 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ main::parseFunctionArguments selfTestCore2 -unknown -what optionValue2 arg"
  main::parseFunctionArguments selfTestCore2 -unknown -what optionValue2 arg && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ main::parseFunctionArguments selfTestCore2 arg more1 more2 -o"
  main::parseFunctionArguments selfTestCore2 arg more1 more2 -o && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ main::parseFunctionArguments selfTestCore2 -this arg more1"
  main::parseFunctionArguments selfTestCore2 -this arg more1 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ main::parseFunctionArguments selfTestCore2 --this-is-option2 --option1 arg more1"
  main::parseFunctionArguments selfTestCore2 --this-is-option2 --option1 arg more1 && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing main::parseFunctionArguments" 0
}

function main() {
  testMain::parseFunctionArguments
}

main
