#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-prompt
source prompt



function test_string::fitStringInScreen() {
  _PROMPT_STRING_WIDTH=5
  echo "_PROMPT_STRING_WIDTH=${_PROMPT_STRING_WIDTH}"

  test_string_fitStringInScreen 5 ""       0 "" 0
  test_string_fitStringInScreen 5 "a"      1 "a" 1
  test_string_fitStringInScreen 5 "ab"     2 "ab" 2
  test_string_fitStringInScreen 5 "abc"    3 "abc" 3
  test_string_fitStringInScreen 5 "abcd"   4 "abcd" 4
  test_string_fitStringInScreen 5 "abcde"  0 "abcde" 0
  test_string_fitStringInScreen 5 "abcdef" 4 "…cdef" 3
  test_string_fitStringInScreen 5 "abcdef" 3 "abcd…" 3
  test_string_fitStringInScreen 5 "abcdef" 1 "abcd…" 1
  #                                               012345

  test_string_fitStringInScreen 5 "abcde"  5 "…cde" 4
  test_string_fitStringInScreen 5 "abcdef" 6 "…def" 4
  test_string_fitStringInScreen 5 "abcdef" 5 "…cdef" 4
  test_string_fitStringInScreen 5 "abcdef" 4 "…cdef" 3
  test_string_fitStringInScreen 5 "abcdef" 3 "abcd…" 3
  #                                               012345
  test_string_fitStringInScreen 5 "abcdefghij" 6 "…efg…" 3
  #                                               0123456789
  #                                               012345
  test_string_fitStringInScreen 5 "abcdefghij" 3 "abcd…" 3
  test_string_fitStringInScreen 5 "abcdefghij" 4 "…cde…" 3
  test_string_fitStringInScreen 5 "abcdefghij" 5 "…def…" 3

  test_string_fitStringInScreen 10 "This is a long string that will be displayed in the screen." 20 "…g string…" 8

  _PROMPT_STRING_WIDTH=4
  echo "_PROMPT_STRING_WIDTH=${_PROMPT_STRING_WIDTH}"
  test_string_fitStringInScreen 4 "bl" 0 "bl" 0
  test::endTest "Testing string::fitStringInScreen" 0
}

function test_string_fitStringInScreen() {
  echo "string::fitStringInScreen '${2}' '${3}' '${1}'"
  string::fitStringInScreen "${2}" "${3}" "${1}"
  echo " ░${RETURNED_VALUE}░ ${RETURNED_VALUE2}"

  if [[ "░${RETURNED_VALUE}░ ${RETURNED_VALUE2}" != "░${4}░ ${5}" ]]; then
    echo "Expected: ░${4}░ ${5}"
    exit 1
  fi
}

function test_string::truncateVisibleCharacters() {
  local FG_CYAN=$'\033[36m'
  local FG_RESET=$'\033[0m'

  echo "string::truncateVisibleCharacters '\${AC__FG_CYAN}Hello\${AC__FG_RESET}world' 5"
  string::truncateVisibleCharacters "${FG_CYAN}Hello${FG_RESET} world" 5
  echo "${RETURNED_VALUE}"
  echo
  echo "string::truncateVisibleCharacters '\${AC__FG_CYAN}Hello\${AC__FG_RESET}world' 10"
  string::truncateVisibleCharacters "${FG_CYAN}Hello${FG_RESET} world" 10
  echo "${RETURNED_VALUE}"
  echo
  echo "string::truncateVisibleCharacters '\${AC__FG_CYAN}Hello\${AC__FG_RESET}world' 11"
  string::truncateVisibleCharacters "${FG_CYAN}Hello${FG_RESET} world" 11
  echo "${RETURNED_VALUE}"
  echo
  echo "string::truncateVisibleCharacters '\${AC__FG_CYAN}Hello\${AC__FG_RESET}world' 12"
  string::truncateVisibleCharacters "${FG_CYAN}Hello${FG_RESET} world" 12
  echo "${RETURNED_VALUE}"
  echo
  echo "string::truncateVisibleCharacters '[7m[35md[27m[39m[7m[35mi[27m[39msable the [93mmonitor mode to avoid[39m the \"Terminated\" message with exit code once the spinner is stopped' 71"
  string::truncateVisibleCharacters '[7m[35md[27m[39m[7m[35mi[27m[39msable the [93mmonitor mode to avoid[39m the "Terminated" message with exit code once the spinner is stopped' 71
  echo "${RETURNED_VALUE}"
  echo

  test::endTest "Testing string::truncateVisibleCharacters" 0
}

function main() {
  test_prompt::fuzzyFilterSort
}

main
