#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-interactive
source interactive

function testInteractive::createSpace() {
  echo "interactive::createSpace 5"
  interactive::createSpace 5

  test::endTest "Testing interactive::createSpace" 0
}

function testInteractive::getCursorPosition() {
  echo "printf '\e[%sR' '123;456' | interactive::getCursorPosition"
  printf '\e[%sR' '123;456' 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  interactive::getCursorPosition < "${GLOBAL_TEMPORARY_WORK_FILE}"
  echo "CURSOR_LINE: ${CURSOR_LINE}; CURSOR_COLUMN: ${CURSOR_COLUMN}"

  test::endTest "Testing interactive::getCursorPosition" 0
}

function testInteractiveGetProgressBarString() {
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

function main() {
  testInteractive::createSpace
  testInteractive::getCursorPosition
  testInteractiveGetProgressBarString
}

main
