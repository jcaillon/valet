#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-command
source command

function main() {
  test_command::listCommands
  test_command_getFunctionNameFromCommand
  test_command::fuzzyMatchCommandToFunctionNameOrFail
  test_command_getMaxPossibleCommandLevel
  test_command_fuzzyFindOption
  test_command_getSingleLetterOptions
  test_command_getDisplayableFilteredArray
}

function test_command::listCommands() {
  test::title "✅ Testing command::listCommands"

  test::func command::listCommands true
  test::func command::listCommands false
}

function test_command_getFunctionNameFromCommand() {
  test::title "✅ Testing command_getFunctionNameFromCommand"

  test::func command_getFunctionNameFromCommand "self build"
}

function test_command::fuzzyMatchCommandToFunctionNameOrFail() {
  test::title "✅ Testing command::fuzzyMatchCommandToFunctionNameOrFail"

  test::markdown "Fuzzy match with single result:"
  test::func command::fuzzyMatchCommandToFunctionNameOrFail "se bu other stuff thing derp"

  test::markdown "Fuzzy match by strict mode is enabled so it fails:"
  test::exit VALET_CONFIG_STRICT_MATCHING=true command::fuzzyMatchCommandToFunctionNameOrFail "se bu other stuff stuff thing derp"

  test::markdown "Fuzzy match with ambiguous result:"
  test::exit command::fuzzyMatchCommandToFunctionNameOrFail "sf" "nop" "other" "stuff" "stuff thing derp"
}

function test_command_getMaxPossibleCommandLevel() {
  test::title "✅ Testing command_getMaxPossibleCommandLevel"

  test::func command_getMaxPossibleCommandLevel "1" "2" "3"
  test::func command_getMaxPossibleCommandLevel "1 2 3"
  test::func command_getMaxPossibleCommandLevel "1"
  test::func command_getMaxPossibleCommandLevel
}

function test_command_fuzzyFindOption() {
  test::title "✅ Testing command_fuzzyFindOption"

  test::markdown "single match, strict mode is enabled"
  test::func VALET_CONFIG_STRICT_MATCHING=true command_fuzzyFindOption de --opt1 --derp2 --allo3

  test::markdown "single match, strict mode is disabled"
  test::func command_fuzzyFindOption de --opt1 --derp2 --allo3

  test::markdown "multiple matches, strict mode is enabled"
  test::func VALET_CONFIG_STRICT_MATCHING=true command_fuzzyFindOption -p --opt1 --derp2 --allo3

  test::markdown "multiple matches, strict mode is disabled"
  test::func command_fuzzyFindOption -p --opt1 --derp2 --allo3

  test::markdown "no match"
  test::func command_fuzzyFindOption thing --opt1 --derp2 --allo3
}

function test_command_getSingleLetterOptions() {
  test::title "✅ Testing command_getSingleLetterOptions"

  test::func command_getSingleLetterOptions -a --opt1 --derp2 -b --allo3 -c
}

function test_command_getDisplayableFilteredArray() {
  test::title "✅ Testing command_getDisplayableFilteredArray"

  # shellcheck disable=SC2034
  ARRAY=(banana apple orange grape ananas lemon)
  test::printVars ARRAY
  test::func MY_CHARS=ae command_getDisplayableFilteredArray ARRAY MY_CHARS
}



main
