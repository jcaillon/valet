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

function main() {
  test_interactive::createSpace
  test_interactive::getCursorPosition
  test_interactiveGetProgressBarString
  test_interactive::getBestAutocompleteBox
}

main
