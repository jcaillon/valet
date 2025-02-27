#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-interactive
source interactive

# shellcheck disable=SC2034
function main() {
  # to test the interactive functions we reactive all escape characters and styles
  VALET_CONFIG_ENABLE_COLORS=true
  VALET_CONFIG_ENABLE_NERDFONT_ICONS=true
  VALET_CONFIG_STYLE_SQUARED_BOXES=false
  VALET_CONFIG_DISABLE_TEXT_ATTRIBUTES=false
  VALET_CONFIG_DISABLE_ESC_CODES=false
  styles::init

  test_interactive::displayDialogBox
  test_interactive::promptYesNo
  test_interactive::askForConfirmation
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
  test::func interactive::promptYesNo 'Do you see this message?' <"${GLOBAL_TEMPORARY_WORK_FILE}"

  test::prompt "echo n | interactive::promptYesNo 'Do you see this message?'"
  echo n 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  test::func interactive::promptYesNo 'Do you see this message?' <"${GLOBAL_TEMPORARY_WORK_FILE}"
}

function test_interactive::askForConfirmation() {
  test::title "✅ Testing interactive::askForConfirmation"

  test::prompt "echo o | interactive::askForConfirmation 'Please press OK.'"
  echo o 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  test::exec interactive::askForConfirmation 'Please press OK.' <"${GLOBAL_TEMPORARY_WORK_FILE}"

  test::prompt "echo n | interactive::askForConfirmation 'Please press OK.'"
  echo n 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  test::exec interactive::askForConfirmation 'Please press OK.' <"${GLOBAL_TEMPORARY_WORK_FILE}"
}

main
