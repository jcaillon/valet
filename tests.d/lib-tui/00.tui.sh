#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-tui
source tui

function main() {
  test_tui::createSpace
  test_tui::getCursorPosition
  test_tui::clearBox
  test_tui::getBestAutocompleteBox
}

function test_tui::createSpace() {
  test::title "✅ Testing tui::createSpace"

  test::exec tui::createSpace 5
}

function test_tui::getCursorPosition() {
  test::title "✅ Testing tui::getCursorPosition"

  test::prompt "printf '\e[%sR' '123;456' | tui::getCursorPosition"
  printf '\e[%sR' '123;456' 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  tui::getCursorPosition < "${GLOBAL_TEMPORARY_WORK_FILE}"
  test::printVars GLOBAL_CURSOR_LINE GLOBAL_CURSOR_COLUMN
}

function test_tui::clearBox() {
  test::title "✅ Testing tui::clearBox"

  GLOBAL_CURSOR_LINE=42
  GLOBAL_CURSOR_COLUMN=42
  test::printVars GLOBAL_CURSOR_LINE GLOBAL_CURSOR_COLUMN
  test::exec tui::clearBox 1 1 10 10
  test::exec tui::clearBox 10 10 5 5
}

function test_tui::getBestAutocompleteBox() {
  test::title "✅ Testing tui::getBestAutocompleteBox"

  GLOBAL_LINES=10
  GLOBAL_COLUMNS=10
  test::printVars GLOBAL_LINES GLOBAL_COLUMNS

  test::func tui::getBestAutocompleteBox  1 1 20 20

  test::func tui::getBestAutocompleteBox  1 1 20 20 2

  test::func tui::getBestAutocompleteBox  1 1 5 5

  test::func tui::getBestAutocompleteBox  5 5 6 9

  test::func tui::getBestAutocompleteBox  7 7 10 4

  test::func tui::getBestAutocompleteBox  7 7 10 10 \'\' true

  test::func tui::getBestAutocompleteBox  1 1 10 10 999 true true 999 5

  test::func tui::getBestAutocompleteBox  1 1 20 20 \'\' \'\' false

  test::func tui::getBestAutocompleteBox  1 1 20 20 2 \'\' false

  test::func tui::getBestAutocompleteBox  1 1 5 5 \'\' \'\' false

  test::func tui::getBestAutocompleteBox  5 5 6 9 \'\' \'\' false

  test::func tui::getBestAutocompleteBox  7 7 10 4 \'\' \'\' false

  test::func tui::getBestAutocompleteBox  7 7 4 4 \'\' \'\' false

  test::func tui::getBestAutocompleteBox  7 7 10 10 \'\' true false
}

main
