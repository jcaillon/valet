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

function main() {
  testInteractive::createSpace
  testInteractive::getCursorPosition
}

main
