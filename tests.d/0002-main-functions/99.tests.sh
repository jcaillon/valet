#!/usr/bin/env bash

function testGetFunctionNameFromCommand() {
  echo "→ getFunctionNameFromCommand 'self build'"
  getFunctionNameFromCommand "self build" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing getFunctionNameFromCommand" $?
}

function testFuzzyMatchCommandtoFunctionName() {

  echo "→ fuzzyMatchCommandtoFunctionName 'se bu other stuff dont care'"
  fuzzyMatchCommandtoFunctionName "se bu other stuff dont care"
  echo "${LAST_RETURNED_VALUE}"
  echo "${LAST_RETURNED_VALUE2}"
  echo "${LAST_RETURNED_VALUE3}"

  echo
  echo "→ fuzzyMatchCommandtoFunctionName 'sf' 'nop' 'other' 'stuff' 'dont care'"
  fuzzyMatchCommandtoFunctionName "sf" "nop" "other" "stuff" "dont care"
  echo "${LAST_RETURNED_VALUE}"
  echo "${LAST_RETURNED_VALUE2}"
  echo "${LAST_RETURNED_VALUE3}"

  endTest "Testing fuzzyMatchCommandtoFunctionName" 0
}

function testGetMaxPossibleCommandLevel() {

  echo "→ getMaxPossibleCommandLevel '1' '2' '3'"
  getMaxPossibleCommandLevel "1" "2" "3" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ getMaxPossibleCommandLevel '1 2 3'"
  getMaxPossibleCommandLevel "1 2 3" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ getMaxPossibleCommandLevel '1'"
  getMaxPossibleCommandLevel "1" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ getMaxPossibleCommandLevel"
  getMaxPossibleCommandLevel && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing getMaxPossibleCommandLevel" 0
}

function testFuzzyFindOption() {

  echo "→ fuzzyFindOption '--opt1 --derp2 --allo3' 'de'"
  fuzzyFindOption "--opt1 --derp2 --allo3" "de" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ fuzzyFindOption '--opt1 --derp2 --allo3' '-a'"
  fuzzyFindOption "--opt1 --derp2 --allo3" "-a" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ fuzzyFindOption '--opt1 --derp2 --allo3' 'thing'"
  fuzzyFindOption "--opt1 --derp2 --allo3" "thing" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing fuzzyFindOption" 0
}

function main() {
  testGetFunctionNameFromCommand
  testFuzzyMatchCommandtoFunctionName
  testGetMaxPossibleCommandLevel
  testFuzzyFindOption
}

main
