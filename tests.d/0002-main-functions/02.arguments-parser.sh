#!/usr/bin/env bash

function testParseFunctionArguments() {

  echo "→ parseFunctionArguments showcaseCommand1"
  parseFunctionArguments showcaseCommand1 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments showcaseCommand1 -o -2 optionValue2 arg1 more1 more2"
  parseFunctionArguments showcaseCommand1 -o -2 optionValue2 arg1 more1 more2 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments showcaseCommand1 -o -o2 optionValue2 arg1"
  parseFunctionArguments showcaseCommand1 -o -o2 optionValue2 arg1 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments showcaseCommand1 -unknown -what optionValue2 arg"
  parseFunctionArguments showcaseCommand1 -unknown -what optionValue2 arg && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments showcaseCommand1 arg more1 more2 -o"
  parseFunctionArguments showcaseCommand1 arg more1 more2 -o && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments showcaseCommand1 -this arg more1"
  parseFunctionArguments showcaseCommand1 -this arg more1 && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ parseFunctionArguments showcaseCommand1 --this-is-option2 --option1 arg more1"
  parseFunctionArguments showcaseCommand1 --this-is-option2 --option1 arg more1 && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing parseFunctionArguments" 0
}

function main() {
  testParseFunctionArguments
}

main
