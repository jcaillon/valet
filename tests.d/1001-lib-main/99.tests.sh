#!/usr/bin/env bash

function test_main::getFunctionNameFromCommand() {
  echo "→ main::getFunctionNameFromCommand 'self build'"
  main::getFunctionNameFromCommand "self build" && echo "${RETURNED_VALUE}"

  test::endTest "Testing main::getFunctionNameFromCommand" $?
}

function test_main::fuzzyMatchCommandToFunctionNameOrFail() {

  # fuzzy match with single result
  echo "→ main::fuzzyMatchCommandToFunctionNameOrFail 'se bu other stuff dont care'"
  main::fuzzyMatchCommandToFunctionNameOrFail "se bu other stuff dont care"
  echo "${RETURNED_VALUE}"
  echo "${RETURNED_VALUE2}"
  echo "${RETURNED_VALUE3}"

  # fuzzy match by strict mode is enabled so it fails
  echo
  echo "→ VALET_CONFIG_STRICT_MATCHING=true main::fuzzyMatchCommandToFunctionNameOrFail 'se bu other stuff dont care'"
  (VALET_CONFIG_STRICT_MATCHING=true main::fuzzyMatchCommandToFunctionNameOrFail "se bu other stuff dont care") || echo "Failed as expected because strict mode is activated"

  # fuzzy match with ambiguous result
  echo
  echo "→ main::fuzzyMatchCommandToFunctionNameOrFail 'sf' 'nop' 'other' 'stuff' 'dont care'"
  (main::fuzzyMatchCommandToFunctionNameOrFail "sf" "nop" "other" "stuff" "dont care") || echo "Failed as expected on ambiguous result"

  test::endTest "Testing main::fuzzyMatchCommandToFunctionNameOrFail" 0
}

function test_main::getMaxPossibleCommandLevel() {

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

function test_main::fuzzyFindOption() {

  # single match, strict mode is enabled
  echo "→ VALET_CONFIG_STRICT_MATCHING=true main::fuzzyFindOption de --opt1 --derp2 --allo3"

  VALET_CONFIG_STRICT_MATCHING=true main::fuzzyFindOption de --opt1 --derp2 --allo3 && echo "${RETURNED_VALUE}" && echo "${RETURNED_VALUE2}"
  unset VALET_CONFIG_STRICT_MATCHING

  # single match, strict mode is disabled
  echo
  echo "→ main::fuzzyFindOption de --opt1 --derp2 --allo3"
  main::fuzzyFindOption de --opt1 --derp2 --allo3 && echo "${RETURNED_VALUE}" && echo "${RETURNED_VALUE2}"

  # multiple matches, strict mode is enabled
  echo
  echo "→ VALET_CONFIG_STRICT_MATCHING=true main::fuzzyFindOption -a --opt1 --derp2 --allo3"
  VALET_CONFIG_STRICT_MATCHING=true main::fuzzyFindOption -p --opt1 --derp2 --allo3 && echo "${RETURNED_VALUE}" && echo "${RETURNED_VALUE2}"

  # multiple matches, strict mode is disabled
  echo
  echo "→ main::fuzzyFindOption -a --opt1 --derp2 --allo3"
  main::fuzzyFindOption -p --opt1 --derp2 --allo3 && echo "${RETURNED_VALUE}" && echo "${RETURNED_VALUE2}"

  # no match
  echo
  echo "→ main::fuzzyFindOption thing --opt1 --derp2 --allo3"
  main::fuzzyFindOption thing --opt1 --derp2 --allo3 && echo "${RETURNED_VALUE}" && echo "${RETURNED_VALUE2}"

  test::endTest "Testing main::fuzzyFindOption" 0
}

function test_main::getSingleLetterOptions() {
  echo "→ main::getSingleLetterOptions -a --opt1 --derp2 -b --allo3 -c"
  main::getSingleLetterOptions -a --opt1 --derp2 -b --allo3 -c && echo "${RETURNED_VALUE}"

  test::endTest "Testing main::getSingleLetterOptions" 0
}

function test_main::getDisplayableFilteredArray() {
  ARRAY=(banana apple orange grape ananas lemon)
  echo "→ main::getDisplayableFilteredArray ae ARRAY"
  main::getDisplayableFilteredArray ae ARRAY && echo "${RETURNED_VALUE}"

  test::endTest "Testing main::getDisplayableFilteredArray" 0
}

function main() {
  test_main::getFunctionNameFromCommand
  test_main::fuzzyMatchCommandToFunctionNameOrFail
  test_main::getMaxPossibleCommandLevel
  test_main::fuzzyFindOption
  test_main::getSingleLetterOptions
  test_main::getDisplayableFilteredArray
}

main
