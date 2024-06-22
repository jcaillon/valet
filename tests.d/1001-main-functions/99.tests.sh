#!/usr/bin/env bash

function testGetFunctionNameFromCommand() {
  echo "→ main::getFunctionNameFromCommand 'self build'"
  main::getFunctionNameFromCommand "self build" && echo "${RETURNED_VALUE}"

  test::endTest "Testing main::getFunctionNameFromCommand" $?
}

function testFuzzyMatchCommandtoFunctionName() {

  # fuzzy match with single result
  echo "→ main::fuzzyMatchCommandtoFunctionNameOrFail 'se bu other stuff dont care'"
  main::fuzzyMatchCommandtoFunctionNameOrFail "se bu other stuff dont care"
  echo "${RETURNED_VALUE}"
  echo "${RETURNED_VALUE2}"
  echo "${RETURNED_VALUE3}"

  # fuzzy match with ambiguous result
  echo
  echo "→ main::fuzzyMatchCommandtoFunctionNameOrFail 'sf' 'nop' 'other' 'stuff' 'dont care'"
  (main::fuzzyMatchCommandtoFunctionNameOrFail "sf" "nop" "other" "stuff" "dont care") || echo "Failed as expected on ambiguous result"

  test::endTest "Testing main::fuzzyMatchCommandtoFunctionNameOrFail" 0
}

function testGetMaxPossibleCommandLevel() {

  echo "→ main::getMaxPossibleCommandLevel '1' '2' '3'"
  main::getMaxPossibleCommandLevel "1" "2" "3" && echo "${RETURNED_VALUE}"

  echo
  echo "→ main::getMaxPossibleCommandLevel '1 2 3'"
  main::getMaxPossibleCommandLevel "1 2 3" && echo "${RETURNED_VALUE}"

  echo
  echo "→ main::getMaxPossibleCommandLevel '1'"
  main::getMaxPossibleCommandLevel "1" && echo "${RETURNED_VALUE}"

  echo
  echo "→ main::getMaxPossibleCommandLevel"
  main::getMaxPossibleCommandLevel && echo "${RETURNED_VALUE}"

  test::endTest "Testing main::getMaxPossibleCommandLevel" 0
}

function testFuzzyFindOption() {

  echo "→ main::fuzzyFindOption '--opt1 --derp2 --allo3' 'de'"
  main::fuzzyFindOption de --opt1 --derp2 --allo3 && echo "${RETURNED_VALUE}"

  echo
  echo "→ main::fuzzyFindOption '--opt1 --derp2 --allo3' '-a'"
  main::fuzzyFindOption -a --opt1 --derp2 --allo3 && echo "${RETURNED_VALUE}"

  echo
  echo "→ main::fuzzyFindOption '--opt1 --derp2 --allo3' 'thing'"
  main::fuzzyFindOption thing --opt1 --derp2 --allo3 && echo "${RETURNED_VALUE}"

  test::endTest "Testing main::fuzzyFindOption" 0
}

function main() {
  testGetFunctionNameFromCommand
  testFuzzyMatchCommandtoFunctionName
  testGetMaxPossibleCommandLevel
  testFuzzyFindOption
}

main
