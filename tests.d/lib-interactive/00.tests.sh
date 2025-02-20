#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-interactive
source interactive

function main() {
  test_interactive::promptYesNo
  test_interactive::askForConfirmation
  test_interactive::displayDialogBox
}

function test_interactive::displayDialogBox() {
  test::title "✅ Testing interactive::displayDialogBox"

  test::exec interactive::displayDialogBox system "Do you want to run the tests?"$'\n'$'\n'"cause it is super cool awesome you one know and stuff (y/n)" 15

  test::exec interactive::displayDialogBox user "Do you want to run the tests?"$'\n'$'\n'"cause it is super cool awesome you one know and stuff (y/n)" 10
}

function test_interactive::promptYesNo() {
  test::title "✅ Testing interactive::promptYesNo"

  test::prompt "echo y | interactive::promptYesNo 'Do you see this message?'"
  echo y 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  interactive::promptYesNo 'Do you see this message?' <"${GLOBAL_TEMPORARY_WORK_FILE}"
  test::flush

  test::prompt echo "echo n | interactive::promptYesNo 'Do you see this message?'"
  echo n 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  interactive::promptYesNo 'Do you see this message?' <"${GLOBAL_TEMPORARY_WORK_FILE}" && test::fail "Expected exit code 1, got 0"
  test::markdown "Exited with code: \`1\`"
  test::flush
}

function test_interactive::askForConfirmation() {
  test::title "✅ Testing interactive::askForConfirmation"

  test::prompt "echo y | interactive::askForConfirmation 'Please press OK.'"
  echo y 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  interactive::askForConfirmation 'Please press OK.' <"${GLOBAL_TEMPORARY_WORK_FILE}"
  test::flush
}

main
