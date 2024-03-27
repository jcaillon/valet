#!/usr/bin/env bash

function testGetFunctionNameFromCommand() {
  echo "--- Testing with 'self build' ---"
  getFunctionNameFromCommand "self build" && echo "${LAST_RETURNED_VALUE}"
  endTest "Testing getFunctionNameFromCommand" $?
}

function testFuzzyMatchCommandtoFunctionName() {
  echo "--- Testing with 'e bu other stuff dont care' ---"
  fuzzyMatchCommandtoFunctionName "se bu other stuff dont care" && echo "${LAST_RETURNED_VALUE}"
  echo "--- Testing with 'sf nop other stuff dont care' ---"
  fuzzyMatchCommandtoFunctionName "sf nop other stuff dont care" && echo "${LAST_RETURNED_VALUE}"
  endTest "Testing fuzzyMatchCommandtoFunctionName" $?
}

function testGetMaxPossibleCommandLevel() {
  echo "--- Testing with '1' '2' '3' ---"
  getMaxPossibleCommandLevel "1" "2" "3" && echo "${LAST_RETURNED_VALUE}"
  echo "--- Testing with '1 2 3' ---"
  getMaxPossibleCommandLevel "1 2 3" && echo "${LAST_RETURNED_VALUE}"
  echo "--- Testing with '1' ---"
  getMaxPossibleCommandLevel "1" && echo "${LAST_RETURNED_VALUE}"
  echo "--- Testing with '' ---"
  getMaxPossibleCommandLevel && echo "${LAST_RETURNED_VALUE}"
  endTest "Testing getMaxPossibleCommandLevel" 0
}

function testFuzzyFindOption() {
  echo "--- Testing with '--opt1 --derp2 --allo3' 'de' ---"
  fuzzyFindOption "--opt1 --derp2 --allo3" "de" && echo "${LAST_RETURNED_VALUE}"
  echo "--- Testing with '--opt1 --derp2 --allo3' '-a' ---"
  fuzzyFindOption "--opt1 --derp2 --allo3" "-a" && echo "${LAST_RETURNED_VALUE}"
  echo "--- Testing with '--opt1 --derp2 --allo3' 'thing' ---"
  fuzzyFindOption "--opt1 --derp2 --allo3" "-a" && echo "${LAST_RETURNED_VALUE}"
  endTest "Testing getMaxPossibleCommandLevel" 0
}

function main() {
  testGetFunctionNameFromCommand
  testFuzzyMatchCommandtoFunctionName
  testGetMaxPossibleCommandLevel
  testFuzzyFindOption
}

main
