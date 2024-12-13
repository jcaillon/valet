#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-interactive
source interactive

function test_interactive::createSpace() {
  echo "interactive::createSpace 5"
  interactive::createSpace 5

  test::endTest "Testing interactive::createSpace" 0
}

function test_interactive::getCursorPosition() {
  echo "printf '\e[%sR' '123;456' | interactive::getCursorPosition"
  printf '\e[%sR' '123;456' 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  interactive::getCursorPosition < "${GLOBAL_TEMPORARY_WORK_FILE}"
  echo "CURSOR_LINE: ${CURSOR_LINE}; CURSOR_COLUMN: ${CURSOR_COLUMN}"

  test::endTest "Testing interactive::getCursorPosition" 0
}

function test_interactiveGetProgressBarString() {
  echo "interactiveGetProgressBarString 0 20"
  interactiveGetProgressBarString 0 20
  echo "⌜${RETURNED_VALUE}⌝"

  echo
  echo "interactiveGetProgressBarString 11 10"
  interactiveGetProgressBarString 11 10
  echo "⌜${RETURNED_VALUE}⌝"

  echo
  echo "interactiveGetProgressBarString 15 10"
  interactiveGetProgressBarString 15 10
  echo "⌜${RETURNED_VALUE}⌝"

  echo
  echo "interactiveGetProgressBarString 50 10"
  interactiveGetProgressBarString 59 10
  echo "⌜${RETURNED_VALUE}⌝"

  echo
  echo "interactiveGetProgressBarString 83 20"
  interactiveGetProgressBarString 83 20
  echo "⌜${RETURNED_VALUE}⌝"

  echo
  echo "interactiveGetProgressBarString 100 15"
  interactiveGetProgressBarString 100 15
  echo "⌜${RETURNED_VALUE}⌝"

  test::endTest "Testing interactiveGetProgressBarString" 0
}

function test_interactive::clearBox() {
  echo "interactive::clearBox 1 1 10 10"
  interactive::clearBox 1 1 10 10

  test::endTest "Testing interactive::clearBox" 0
}

function test_interactive::getBestAutocompleteBox() {
  echo "GLOBAL_LINES=10"
  echo "GLOBAL_COLUMNS=10"
  GLOBAL_LINES=10
  GLOBAL_COLUMNS=10

  echo "interactive::getBestAutocompleteBox 1 1 20 20"
  interactive::getBestAutocompleteBox 1 1 20 20
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo "interactive::getBestAutocompleteBox 1 1 20 20 2"
  interactive::getBestAutocompleteBox 1 1 20 20 2
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo "interactive::getBestAutocompleteBox 1 1 5 5"
  interactive::getBestAutocompleteBox 1 1 5 5
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo "interactive::getBestAutocompleteBox 5 5 6 9"
  interactive::getBestAutocompleteBox 5 5 6 9
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo "interactive::getBestAutocompleteBox 7 7 10 4"
  interactive::getBestAutocompleteBox 7 7 10 4
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo "interactive::getBestAutocompleteBox 7 7 10 10 '' true"
  interactive::getBestAutocompleteBox 7 7 10 10 '' true
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo "interactive::getBestAutocompleteBox 1 1 10 10 999 true true 999 5"
  interactive::getBestAutocompleteBox 1 1 10 10 999 true true 999 5
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo
  echo "interactive::getBestAutocompleteBox 1 1 20 20 '' '' false 10 10"
  interactive::getBestAutocompleteBox 1 1 20 20 '' '' false
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"
  echo

  echo "interactive::getBestAutocompleteBox 1 1 20 20 2 '' false"
  interactive::getBestAutocompleteBox 1 1 20 20 2 '' false
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo "interactive::getBestAutocompleteBox 1 1 5 5 '' '' false"
  interactive::getBestAutocompleteBox 1 1 5 5 '' '' false
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo "interactive::getBestAutocompleteBox 5 5 6 9 '' '' false"
  interactive::getBestAutocompleteBox 5 5 6 9 '' '' false
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo "interactive::getBestAutocompleteBox 7 7 10 4 '' '' false"
  interactive::getBestAutocompleteBox 7 7 10 4 '' '' false
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo "interactive::getBestAutocompleteBox 7 7 4 4 '' '' false"
  interactive::getBestAutocompleteBox 7 7 4 4 '' '' false
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  echo
  echo "interactive::getBestAutocompleteBox 7 7 10 10 '' true false"
  interactive::getBestAutocompleteBox 7 7 10 10 '' true false
  echo "at (top:left) ${RETURNED_VALUE}:${RETURNED_VALUE2}, (width x height) ${RETURNED_VALUE3} x ${RETURNED_VALUE4}"

  test::endTest "Testing interactive::getBestAutocompleteBox" 0
}

function test_interactive::showStringInScreen() {
  _PROMPT_STRING_WIDTH=5
  echo "_PROMPT_STRING_WIDTH=${_PROMPT_STRING_WIDTH}"

  test_interactive_showStringInScreen 5 ""       0 "" 0
  test_interactive_showStringInScreen 5 "a"      1 "a" 1
  test_interactive_showStringInScreen 5 "ab"     2 "ab" 2
  test_interactive_showStringInScreen 5 "abc"    3 "abc" 3
  test_interactive_showStringInScreen 5 "abcd"   4 "abcd" 4
  test_interactive_showStringInScreen 5 "abcde"  0 "abcde" 0
  test_interactive_showStringInScreen 5 "abcdef" 4 "…cdef" 3
  test_interactive_showStringInScreen 5 "abcdef" 3 "abcd…" 3
  test_interactive_showStringInScreen 5 "abcdef" 1 "abcd…" 1
  #                                               012345

  test_interactive_showStringInScreen 5 "abcde"  5 "…cde" 4
  test_interactive_showStringInScreen 5 "abcdef" 6 "…def" 4
  test_interactive_showStringInScreen 5 "abcdef" 5 "…cdef" 4
  test_interactive_showStringInScreen 5 "abcdef" 4 "…cdef" 3
  test_interactive_showStringInScreen 5 "abcdef" 3 "abcd…" 3
  #                                               012345
  test_interactive_showStringInScreen 5 "abcdefghij" 6 "…efg…" 3
  #                                               0123456789
  #                                               012345
  test_interactive_showStringInScreen 5 "abcdefghij" 3 "abcd…" 3
  test_interactive_showStringInScreen 5 "abcdefghij" 4 "…cde…" 3
  test_interactive_showStringInScreen 5 "abcdefghij" 5 "…def…" 3

  test_interactive_showStringInScreen 10 "This is a long string that will be displayed in the screen." 20 "…g string…" 8

  _PROMPT_STRING_WIDTH=4
  echo "_PROMPT_STRING_WIDTH=${_PROMPT_STRING_WIDTH}"
  test_interactive_showStringInScreen 4 "bl" 0 "bl" 0
  test::endTest "Testing interactive::showStringInScreen" 0
}

function test_interactive_showStringInScreen() {
  echo "interactive::showStringInScreen '${2}' '${3}' '${1}'"
  interactive::showStringInScreen "${2}" "${3}" "${1}"
  echo " ░${RETURNED_VALUE}░ ${RETURNED_VALUE2}"

  if [[ "░${RETURNED_VALUE}░ ${RETURNED_VALUE2}" != "░${4}░ ${5}" ]]; then
    echo "Expected: ░${4}░ ${5}"
    exit 1
  fi
}

function main() {
  test_interactive::createSpace
  test_interactive::getCursorPosition
  test_interactiveGetProgressBarString
  test_interactive::getBestAutocompleteBox
  test_interactive::showStringInScreen
}

main
