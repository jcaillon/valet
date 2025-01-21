#!/usr/bin/env bash

function main() {
  test_main::getFunctionNameFromCommand
  test_main::fuzzyMatchCommandToFunctionNameOrFail
  test_main::getMaxPossibleCommandLevel
  test_main::fuzzyFindOption
  test_main::getSingleLetterOptions
  test_main::getDisplayableFilteredArray
}

function test_main::getFunctionNameFromCommand() {
  test::title "✅ Testing main::getFunctionNameFromCommand"

  test::func main::getFunctionNameFromCommand "self build"
}

function test_main::fuzzyMatchCommandToFunctionNameOrFail() {
  test::title "✅ Testing main::fuzzyMatchCommandToFunctionNameOrFail"

  test::markdown "Fuzzy match with single result:"
  test::func main::fuzzyMatchCommandToFunctionNameOrFail "se bu other stuff thing derp"

  test::markdown "Fuzzy match by strict mode is enabled so it fails:"
  test::exit VALET_CONFIG_STRICT_MATCHING=true main::fuzzyMatchCommandToFunctionNameOrFail "se bu other stuff stuff thing derp"

  test::markdown "Fuzzy match with ambiguous result:"
  test::exit main::fuzzyMatchCommandToFunctionNameOrFail "sf" "nop" "other" "stuff" "stuff thing derp"
}

function test_main::getMaxPossibleCommandLevel() {
  test::title "✅ Testing main::getMaxPossibleCommandLevel"

  test::func main::getMaxPossibleCommandLevel "1" "2" "3"
  test::func main::getMaxPossibleCommandLevel "1 2 3"
  test::func main::getMaxPossibleCommandLevel "1"
  test::func main::getMaxPossibleCommandLevel
}

function test_main::fuzzyFindOption() {
  test::title "✅ Testing main::fuzzyFindOption"

  test::markdown "single match, strict mode is enabled"
  test::func VALET_CONFIG_STRICT_MATCHING=true main::fuzzyFindOption de --opt1 --derp2 --allo3

  test::markdown "single match, strict mode is disabled"
  test::func main::fuzzyFindOption de --opt1 --derp2 --allo3

  test::markdown "multiple matches, strict mode is enabled"
  test::func VALET_CONFIG_STRICT_MATCHING=true main::fuzzyFindOption -p --opt1 --derp2 --allo3

  test::markdown "multiple matches, strict mode is disabled"
  test::func main::fuzzyFindOption -p --opt1 --derp2 --allo3

  test::markdown "no match"
  test::func main::fuzzyFindOption thing --opt1 --derp2 --allo3
}

function test_main::getSingleLetterOptions() {
  test::title "✅ Testing main::getSingleLetterOptions"

  test::func main::getSingleLetterOptions -a --opt1 --derp2 -b --allo3 -c
}

function test_main::getDisplayableFilteredArray() {
  test::title "✅ Testing main::getDisplayableFilteredArray"

  # shellcheck disable=SC2034
  ARRAY=(banana apple orange grape ananas lemon)
  test::printVars ARRAY
  test::func main::getDisplayableFilteredArray ae ARRAY
}

# shellcheck disable=SC2317
function test::transformReturnedVarsBeforePrinting() {
  unset -v RETURNED_ARRAY RETURNED_ARRAY2
  unset -v RETURNED_ARRAY RETURNED_ARRAY2
}

main
