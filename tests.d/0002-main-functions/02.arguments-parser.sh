#!/usr/bin/env bash

function testParseFunctionArguments() {

  echo "→ parseFunctionArguments selfTestCore2"
  parseFunctionArguments selfTestCore2 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments selfTestCore2 -o -2 optionValue2 arg1 more1 more2"
  parseFunctionArguments selfTestCore2 -o -2 optionValue2 arg1 more1 more2 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments selfTestCore2 -o -2 optionValue2 arg1"
  parseFunctionArguments selfTestCore2 -o -2 optionValue2 arg1 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments selfTestCore2 -unknown -what optionValue2 arg"
  parseFunctionArguments selfTestCore2 -unknown -what optionValue2 arg && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments selfTestCore2 arg more1 more2 -o"
  parseFunctionArguments selfTestCore2 arg more1 more2 -o && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments selfTestCore2 -this arg more1"
  parseFunctionArguments selfTestCore2 -this arg more1 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments selfTestCore2 --this-is-option2 --option1 arg more1"
  parseFunctionArguments selfTestCore2 --this-is-option2 --option1 arg more1 && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing parseFunctionArguments" 0
}

function main() {
  testParseFunctionArguments
}

main
