#!/usr/bin/env bash

function testGetFunctionNameFromCommand() {
  echo "→ main::getFunctionNameFromCommand 'self build'"
  main::getFunctionNameFromCommand "self build" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing main::getFunctionNameFromCommand" $?
}

function testFuzzyMatchCommandtoFunctionName() {

  echo "→ main::fuzzyMatchCommandtoFunctionName 'se bu other stuff dont care'"
  main::fuzzyMatchCommandtoFunctionName "se bu other stuff dont care"
  echo "${LAST_RETURNED_VALUE}"
  echo "${LAST_RETURNED_VALUE2}"
  echo "${LAST_RETURNED_VALUE3}"

  echo
  echo "→ main::fuzzyMatchCommandtoFunctionName 'sf' 'nop' 'other' 'stuff' 'dont care'"
  main::fuzzyMatchCommandtoFunctionName "sf" "nop" "other" "stuff" "dont care"
  echo "${LAST_RETURNED_VALUE}"
  echo "${LAST_RETURNED_VALUE2}"
  echo "${LAST_RETURNED_VALUE3}"

  endTest "Testing main::fuzzyMatchCommandtoFunctionName" 0
}

function testGetMaxPossibleCommandLevel() {

  echo "→ main::getMaxPossibleCommandLevel '1' '2' '3'"
  main::getMaxPossibleCommandLevel "1" "2" "3" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ main::getMaxPossibleCommandLevel '1 2 3'"
  main::getMaxPossibleCommandLevel "1 2 3" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ main::getMaxPossibleCommandLevel '1'"
  main::getMaxPossibleCommandLevel "1" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ main::getMaxPossibleCommandLevel"
  main::getMaxPossibleCommandLevel && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing main::getMaxPossibleCommandLevel" 0
}

function testFuzzyFindOption() {

  echo "→ main::fuzzyFindOption '--opt1 --derp2 --allo3' 'de'"
  main::fuzzyFindOption "--opt1 --derp2 --allo3" "de" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ main::fuzzyFindOption '--opt1 --derp2 --allo3' '-a'"
  main::fuzzyFindOption "--opt1 --derp2 --allo3" "-a" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ main::fuzzyFindOption '--opt1 --derp2 --allo3' 'thing'"
  main::fuzzyFindOption "--opt1 --derp2 --allo3" "thing" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing main::fuzzyFindOption" 0
}

function main() {
  testGetFunctionNameFromCommand
  testFuzzyMatchCommandtoFunctionName
  testGetMaxPossibleCommandLevel
  testFuzzyFindOption
}

main
