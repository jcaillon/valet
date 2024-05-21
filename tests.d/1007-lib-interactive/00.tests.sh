#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-interactive
source interactive

function testInteractive::promptYesNo() {
  echo "echo y | interactive::promptYesNo 'Do you see this message?'"
  echo y 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  interactive::promptYesNo 'Do you see this message?' <"${GLOBAL_TEMPORARY_WORK_FILE}"

  test::endTest "test interactive::promptYesNo with yes" 0

  echo
  echo "echo n | interactive::promptYesNo 'Do you see this message?'"
  echo n 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  interactive::promptYesNo 'Do you see this message?' <"${GLOBAL_TEMPORARY_WORK_FILE}" || :

  test::endTest "Testing interactive::promptYesNo" 1
}

function testInteractive::askForConfirmation() {
  echo "echo y | interactive::askForConfirmation 'Please press OK.'"
  interactive::askForConfirmation 'Please press OK.' <"${GLOBAL_TEMPORARY_WORK_FILE}"

  test::endTest "test interactive::askForConfirmation with yes" 0
}

function main() {
  testInteractive::promptYesNo
  testInteractive::askForConfirmation
}

main
