#!/usr/bin/env bash

function testString::wrapText() {
  local shortText

  shortText="You don't get better on the days when you feel like going. You get better on the days when you don't want to go, but you go anyway. If you can overcome the negative energy coming from your tired body or unmotivated mind, you will grow and become better. It won't be the best workout you have, you won't accomplish as much as what you usually do when you actually feel good, but that doesn't matter. Growth is a long term game, and the crappy days are more important.

As long as I focus on what I feel and don't worry about where I'm going, it works out. Having no expectations but being open to everything is what makes wonderful things happen. If I don't worry, there's no obstruction and life flows easily. It sounds impractical, but 'Expect nothing; be open to everything' is really all it is.


There were 2 new lines before this."

  echo "→ string::wrapText \"\${shortText}\" 30"
  echo "------------------------------"
  string::wrapText "${shortText}" 30 && echo "${RETURNED_VALUE}"
  test::endTest "Wrapping text at column 30 with no padding" 0

  echo "→ string::wrapText \"\${shortText}\" 90 4 false"
  echo "------------------------------------------------------------------------------------------"
  string::wrapText "${shortText}" 90 4 false && echo "${RETURNED_VALUE}"
  test::endTest "Wrapping text at column 90 with padding of 4 on new lines" 0

  echo "→ string::wrapText \"\${shortText}\" 90 2 true"
  echo "------------------------------------------------------------------------------------------"
  string::wrapText "${shortText}" 90 2 true && echo "${RETURNED_VALUE}"
  test::endTest "Wrapping text at column 90 with padding of 2 on all lines" 0
}

function testArray::fuzzyFilter() {
  lines=("this is a word"
    "very unbelievable"
    "unbelievable"
    "self mock1"
    "self mock2"
    "ublievable")

  declare -p lines

  echo
  echo "→ array::fuzzyFilter evle lines"
  array::fuzzyFilter "evle" lines
  declare -p RETURNED_ARRAY RETURNED_ARRAY2 RETURNED_ARRAY3

  echo
  echo "→ array::fuzzyFilter SC2 lines"
  array::fuzzyFilter "SC2" lines
  declare -p RETURNED_ARRAY RETURNED_ARRAY2 RETURNED_ARRAY3

  echo
  echo "→ array::fuzzyFilter u lines"
  array::fuzzyFilter "u" lines
  declare -p RETURNED_ARRAY RETURNED_ARRAY2 RETURNED_ARRAY3

  echo
  echo "→ array::fuzzyFilter seLf lines"
  array::fuzzyFilter "seLf" lines
  declare -p RETURNED_ARRAY RETURNED_ARRAY2 RETURNED_ARRAY3

  echo
  echo "→ array::fuzzyFilter nomatch lines"
  array::fuzzyFilter "nomatch" lines
  declare -p RETURNED_ARRAY RETURNED_ARRAY2 RETURNED_ARRAY3

  unset lines

  test::endTest "Testing array::fuzzyFilter" 0
}

function testString::wrapCharacters() {
  local shortText

  shortText="You don't get better on the days when you feel like going. You get better on the days when you don't want to go, but you go anyway. If you can overcome the negative energy coming from your tired body or unmotivated mind, you will grow and become better. It won't be the best workout you have, you won't accomplish as much as what you usually do when you actually feel good, but that doesn't matter. Growth is a long term game, and the crappy days are more important."

  echo "→ string::wrapCharacters \"\${shortText}\" 30 \"  \"" 28
  echo "------------------------------"
  string::wrapCharacters "${shortText}" 30 "  " 28 && echo "${RETURNED_VALUE}"
  test::endTest "Wrapping characters at column 30 with new line prefix" 0

  echo "→ string::wrapCharacters \"\${shortText}\" 20"
  echo "--------------------"
  string::wrapCharacters "${shortText}" 20 && echo "${RETURNED_VALUE}"
  test::endTest "Wrapping characters at 20, no other options" 0


}

function test_core::reExportFuncToUseGlobalVars() {
  # shellcheck disable=SC2317
  function eval() { echo "$*"; }

  # shellcheck disable=SC2317
  function test_function_to_reexport() {
    local -i firstArg=$1
    local secondArg="${2}"
    local -A thirdArg="${3:-egez}"

    if (( firstArg == 0 )); then
      echo "cool"
    fi
    if [[ "${secondArg}" == "cool" ]]; then
      echo "${secondArg}"
    fi
    if [[ "${thirdArg[cool]}" == "cool" ]]; then
      echo "${thirdArg[cool]}"
    fi
  }

  echo "core::reExportFuncToUseGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG"
  core::reExportFuncToUseGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG

  unset -f eval test_function_to_reexport
  test::endTest "Testing core::reExportFuncToUseGlobalVars" 0
}

function main() {
  testString::wrapText
  testArray::fuzzyFilter
  testString::wrapCharacters
  test_core::reExportFuncToUseGlobalVars
}

main
