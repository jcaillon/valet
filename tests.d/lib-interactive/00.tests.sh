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
  test_interactive::confirm
  test_interactive::continue
}

function test_interactive::displayDialogBox() {
  test::title "✅ Testing interactive::displayDialogBox"

  test::exec interactive::displayQuestion "Do you want to run the tests?"$'\n'$'\n'"cause it is super cool awesome you one know and stuff (y/n)" width=15

  test::exec interactive::displayAnswer "Do you want to run the tests?"$'\n'$'\n'"cause it is super cool awesome you one know and stuff (y/n)" width=10
}

function test_interactive::confirm() {
  test::title "✅ Testing interactive::confirm"

  test::prompt "echo y | interactive::confirm 'Do you see this message?'"
  test::setTerminalInputs y
  test::func interactive::confirm 'Do you see this message?'

  test::prompt "echo n | interactive::confirm 'Do you see this message?'"
  test::setTerminalInputs n
  test::func interactive::confirm 'Do you see this message?'
}

function test_interactive::continue() {
  test::title "✅ Testing interactive::continue"

  test::prompt "echo o | interactive::continue 'Please press OK.'"
  test::setTerminalInputs o
  test::exec interactive::continue 'Please press OK.'

  test::prompt "echo n | interactive::continue 'Please press OK.'"
  test::setTerminalInputs n
  test::exec interactive::continue 'Please press OK.'
}

main
