#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-interactive
source interactive

function main() {
  test_interactive::createSpace
  test_interactive::getCursorPosition
  test_interactive_getProgressBarString
  test_interactive::clearBox
  test_interactive::getBestAutocompleteBox
}

function test_interactive::createSpace() {
  test::title "✅ Testing interactive::createSpace"

  test::exec interactive::createSpace 5
}

function test_interactive::getCursorPosition() {
  test::title "✅ Testing interactive::getCursorPosition"

  test::prompt "printf '\e[%sR' '123;456' | interactive::getCursorPosition"
  printf '\e[%sR' '123;456' 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  interactive::getCursorPosition < "${GLOBAL_TEMPORARY_WORK_FILE}"
  test::printVars GLOBAL_CURSOR_LINE GLOBAL_CURSOR_COLUMN
}

function test_interactive_getProgressBarString() {
  test::title "✅ Testing interactive_getProgressBarString"

  test::func interactive_getProgressBarString 0 1
  test::func interactive_getProgressBarString 10 1
  test::func interactive_getProgressBarString 50 1
  test::func interactive_getProgressBarString 90 1
  test::func interactive_getProgressBarString 100 1
  test::func interactive_getProgressBarString 22 10
  test::func interactive_getProgressBarString 50 15
  test::func interactive_getProgressBarString 83 30
}

function test_interactive::clearBox() {
  test::title "✅ Testing interactive::clearBox"

  GLOBAL_CURSOR_LINE=42
  GLOBAL_CURSOR_COLUMN=42
  test::printVars GLOBAL_CURSOR_LINE GLOBAL_CURSOR_COLUMN
  test::exec interactive::clearBox 1 1 10 10
  test::exec interactive::clearBox 10 10 5 5
}

function test_interactive::getBestAutocompleteBox() {
  test::title "✅ Testing interactive::getBestAutocompleteBox"

  GLOBAL_LINES=10
  GLOBAL_COLUMNS=10
  test::printVars GLOBAL_LINES GLOBAL_COLUMNS

  test::func interactive::getBestAutocompleteBox  1 1 20 20

  test::func interactive::getBestAutocompleteBox  1 1 20 20 2

  test::func interactive::getBestAutocompleteBox  1 1 5 5

  test::func interactive::getBestAutocompleteBox  5 5 6 9

  test::func interactive::getBestAutocompleteBox  7 7 10 4

  test::func interactive::getBestAutocompleteBox  7 7 10 10 \'\' true

  test::func interactive::getBestAutocompleteBox  1 1 10 10 999 true true 999 5

  test::func interactive::getBestAutocompleteBox  1 1 20 20 \'\' \'\' false

  test::func interactive::getBestAutocompleteBox  1 1 20 20 2 \'\' false

  test::func interactive::getBestAutocompleteBox  1 1 5 5 \'\' \'\' false

  test::func interactive::getBestAutocompleteBox  5 5 6 9 \'\' \'\' false

  test::func interactive::getBestAutocompleteBox  7 7 10 4 \'\' \'\' false

  test::func interactive::getBestAutocompleteBox  7 7 4 4 \'\' \'\' false

  test::func interactive::getBestAutocompleteBox  7 7 10 10 \'\' true false
}

main
