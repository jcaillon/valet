#!/usr/bin/env bash

function testMain::parseFunctionArguments() {

  echo "# missing argument"
  echo "→ main::parseFunctionArguments selfMock2"
  main::parseFunctionArguments selfMock2 && echo "${RETURNED_VALUE}"
  echo

  echo "# ok"
  echo "→ main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 more1 more2"
  main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 more1 more2 && echo "${RETURNED_VALUE}"
  echo

  echo "# missing argument"
  echo "→ main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1"
  main::parseFunctionArguments selfMock2 -o -2 optionValue2 arg1 && echo "${RETURNED_VALUE}"
  echo

  echo "# unknown options"
  echo "→ main::parseFunctionArguments selfMock2 --unknown --what optionValue2 arg"
  main::parseFunctionArguments selfMock2 --unknown --what optionValue2 arg && echo "${RETURNED_VALUE}"
  echo

  echo "# ok with the option at the end"
  echo "→ main::parseFunctionArguments selfMock2 arg more1 more2 -o"
  main::parseFunctionArguments selfMock2 arg more1 more2 -o && echo "${RETURNED_VALUE}"
  echo

  echo "# fuzzy match the option --this"
  echo "→ main::parseFunctionArguments selfMock2 --this arg more1"
  main::parseFunctionArguments selfMock2 --this arg more1 && echo "${RETURNED_VALUE}"
  echo

  echo "# ok, --option1 is interpreted as the value for --this-is-option2"
  echo "→ main::parseFunctionArguments selfMock2 --this-is-option2 --option1 arg more1"
  main::parseFunctionArguments selfMock2 --this-is-option2 --option1 arg more1 && echo "${RETURNED_VALUE}"
  echo

  echo "# ok only args"
  echo "→ main::parseFunctionArguments selfMock4 arg1 arg2"
  main::parseFunctionArguments selfMock4 arg1 arg2 && echo "${RETURNED_VALUE}"
  echo

  echo "# ok with -- to separate options from args"
  echo "→ main::parseFunctionArguments selfMock2 -- --arg1-- --arg2--"
  main::parseFunctionArguments selfMock2 -- --arg1-- --arg2-- && echo "${RETURNED_VALUE}"
  echo

  echo "# missing a value for the option 2"
  echo "→ main::parseFunctionArguments selfMock2 arg1 arg2 --this-is-option2"
  main::parseFunctionArguments selfMock2 arg1 arg2 --this-is-option2 && echo "${RETURNED_VALUE}"
  echo

  echo "# ambiguous fuzzy match"
  echo "→ main::parseFunctionArguments selfMock2 arg1 arg2 --th"
  main::parseFunctionArguments selfMock2 arg1 arg2 --th && echo "${RETURNED_VALUE}"
  echo

  echo "# ok single letter options grouped together"
  echo "→ main::parseFunctionArguments selfMock2 -o3 allo1 allo2 allo3 allo4"
  main::parseFunctionArguments selfMock2 -o3 allo1 allo2 allo3 allo4 && echo "${RETURNED_VALUE}"
  echo

  echo "# ok single letter options, consume argument as option values"
  echo "→ main::parseFunctionArguments selfMock2 -o243 allo1 allo2 allo3 allo4"
  main::parseFunctionArguments selfMock2 -o243 allo1 allo2 allo3 allo4 && echo "${RETURNED_VALUE}"
  echo

  echo "# ko, single letter options, invalid one"
  echo "→ main::parseFunctionArguments selfMock2 -3ao allo1 allo2"
  main::parseFunctionArguments selfMock2 -3ao allo1 allo2 && echo "${RETURNED_VALUE}"
  echo

  echo "# ko, missing a value for the option 4"
  echo "→ main::parseFunctionArguments selfMock2 arg1 arg2 -4"
  main::parseFunctionArguments selfMock2 arg1 arg2 -4 && echo "${RETURNED_VALUE}"
  echo

  echo "# ko, missing multiple values in a group"
  echo "→ main::parseFunctionArguments selfMock2 arg1 arg2 -4444"
  main::parseFunctionArguments selfMock2 arg1 arg2 -4444 && echo "${RETURNED_VALUE}"
  echo

  test::endTest "Testing main::parseFunctionArguments" 0
}

function main() {
  testMain::parseFunctionArguments
}

main
