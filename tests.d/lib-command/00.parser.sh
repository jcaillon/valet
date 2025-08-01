#!/usr/bin/env bash

function main() {
  test_command_parseFunctionArguments
}

function test_command_parseFunctionArguments() {
  test::title "✅ Testing command_parseFunctionArguments"

  test::markdown "Missing argument:"
  test::func command_parseFunctionArguments selfMock2

  test::markdown "ok"
  test::func command_parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 more1 more2

  test::markdown "missing argument"
  test::func command_parseFunctionArguments selfMock2 -o -2 optionValue2 arg1

  test::markdown "unknown options"
  test::func command_parseFunctionArguments selfMock2 --unknown --what optionValue2 arg

  test::markdown "ok with the option at the end"
  test::func command_parseFunctionArguments selfMock2 arg more1 more2 -o

  test::markdown "fuzzy match the option --this"
  test::func command_parseFunctionArguments selfMock2 --this arg more1

  test::markdown "ok, --option1 is interpreted as the value for --this-is-option2"
  test::func command_parseFunctionArguments selfMock2 --this-is-option2 --option1 arg more1

  test::markdown "ok only args"
  test::func command_parseFunctionArguments selfMock4 arg1 arg2

  test::markdown "ok with -- to separate options from args"
  test::func command_parseFunctionArguments selfMock2 -- --arg1-- --arg2--

  test::markdown "missing a value for the option 2"
  test::func command_parseFunctionArguments selfMock2 arg1 arg2 --this-is-option2

  test::markdown "ambiguous fuzzy match"
  test::func command_parseFunctionArguments selfMock2 arg1 arg2 --th

  test::markdown "ok single letter options grouped together"
  test::func command_parseFunctionArguments selfMock2 -o3 allo1 allo2 allo3 allo4

  test::markdown "ok single letter options, consume argument as option values"
  test::func command_parseFunctionArguments selfMock2 -o243 allo1 allo2 allo3 allo4

  test::markdown "ko, single letter options, invalid one"
  test::func command_parseFunctionArguments selfMock2 -3ao allo1 allo2

  test::markdown "ko, missing a value for the option 4"
  test::func command_parseFunctionArguments selfMock2 arg1 arg2 -4

  test::markdown "ko, missing multiple values in a group"
  test::func command_parseFunctionArguments selfMock2 arg1 arg2 -4444
}

function test::scrubReplyVars() {
  unset -v REPLY2 REPLY_ARRAY REPLY_ARRAY2
  unset -v REPLY2 REPLY_ARRAY REPLY_ARRAY2
}

main
