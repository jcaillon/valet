#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-terminal
source terminal

# shellcheck disable=SC2034
function main() {
  # to test the interactive functions we reactive all escape characters and styles
  VALET_CONFIG_ENABLE_COLORS=true
  VALET_CONFIG_ENABLE_NERDFONT_ICONS=true
  VALET_CONFIG_STYLE_SQUARED_BOXES=false
  VALET_CONFIG_DISABLE_TEXT_ATTRIBUTES=false
  VALET_CONFIG_DISABLE_ESC_CODES=false
  styles::init

  test_terminal::createSpace
  test_terminal::getCursorPosition
  test_terminal::clearBox
  test_terminal::getBestAutocompleteBox
  test_terminal::switchToFullScreen
  test_terminal::setRawMode
  test_terminal::rerouteLogs
}

function test_terminal::createSpace() {
  test::title "✅ Testing terminal::createSpace"

  GLOBAL_LINES=10
  test::exec terminal::createSpace 1

  test::exec terminal::createSpace 20

  test::exec terminal::createSpace 5
}

function test_terminal::getCursorPosition() {
  test::title "✅ Testing terminal::getCursorPosition"

  test::prompt "printf '\e[%sR' '123;456' | terminal::getCursorPosition"
  printf '\e[%sR' '123;456' 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  test::exec terminal::getCursorPosition <"${GLOBAL_TEMPORARY_WORK_FILE}"
  test::printVars GLOBAL_CURSOR_LINE GLOBAL_CURSOR_COLUMN
}

function test_terminal::clearBox() {
  test::title "✅ Testing terminal::clearBox"

  GLOBAL_CURSOR_LINE=42
  GLOBAL_CURSOR_COLUMN=42
  test::printVars GLOBAL_CURSOR_LINE GLOBAL_CURSOR_COLUMN
  test::exec terminal::clearBox top=1 left=1 width=10 height=10
  test::exec terminal::clearBox top=10 left=10 width=5 height=5
}

function test_terminal::getBestAutocompleteBox() {
  test::title "✅ Testing terminal::getBestAutocompleteBox"

  GLOBAL_LINES=10
  GLOBAL_COLUMNS=10
  test::printVars GLOBAL_LINES GLOBAL_COLUMNS

  test::func terminal::getBestAutocompleteBox  top=1 left=1 desiredHeight=20 desiredWidth=20

  test::func terminal::getBestAutocompleteBox  top=1 left=1 desiredHeight=20 desiredWidth=20 maxHeight=2

  test::func terminal::getBestAutocompleteBox  top=1 left=1 desiredHeight=5 desiredWidth=5

  test::func terminal::getBestAutocompleteBox  top=5 left=5 desiredHeight=6 desiredWidth=9

  test::func terminal::getBestAutocompleteBox  top=7 left=7 desiredHeight=10 desiredWidth=4

  test::func terminal::getBestAutocompleteBox  top=7 left=7 desiredHeight=10 desiredWidth=10 forceBelow=true

  test::func terminal::getBestAutocompleteBox  top=1 left=1 desiredHeight=10 desiredWidth=10 maxHeight=999 forceBelow=true notOnCurrentLine=true terminalWidth=999 terminalHeight=5

  test::func terminal::getBestAutocompleteBox  top=1 left=1 desiredHeight=20 desiredWidth=20 notOnCurrentLine=false

  test::func terminal::getBestAutocompleteBox  top=1 left=1 desiredHeight=20 desiredWidth=20 maxHeight=2 notOnCurrentLine=false

  test::func terminal::getBestAutocompleteBox  top=1 left=1 desiredHeight=5 desiredWidth=5 notOnCurrentLine=false

  test::func terminal::getBestAutocompleteBox  top=5 left=5 desiredHeight=6 desiredWidth=9 notOnCurrentLine=false

  test::func terminal::getBestAutocompleteBox  top=7 left=7 desiredHeight=10 desiredWidth=4 notOnCurrentLine=false

  test::func terminal::getBestAutocompleteBox  top=7 left=7 desiredHeight=4 desiredWidth=4 notOnCurrentLine=false

  test::func terminal::getBestAutocompleteBox  top=7 left=7 desiredHeight=10 desiredWidth=10 forceBelow=true notOnCurrentLine=false
}

function test_terminal::switchToFullScreen() {
  test::title "✅ Testing terminal::switchToFullScreen"

  test::exec terminal::switchBackFromFullScreen
  test::exec terminal::switchToFullScreen
  test::exec terminal::switchBackFromFullScreen
}

function test_terminal::setRawMode() {
  test::title "✅ Testing terminal::setRawMode"

  GLOBAL_TEST_FORCE_FD_OPEN=true

  unset -v GLOBAL_STTY_SAVED_CONFIG GLOBAL_TERMINAL_RAW_MODE_ENABLED

  # shellcheck disable=SC2317
  function stty() {
    _stty_args=("$@")
    if [[ ${1:-} == "-g" ]]; then
      echo "original config"
      return 0
    fi
  }

  test::exec terminal::restoreSettings
  test::exec terminal::setRawMode
  test::markdown 'stty called with `'"${_stty_args[*]}"'`'
  test::exec BASH_SUBSHELL=0 terminal::restoreSettings
  test::markdown 'stty called with `'"${_stty_args[*]}"'`'

  unset -f stty
}

function test_terminal::rerouteLogs() {
  test::title "✅ Testing terminal::rerouteLogs"

  test::exec terminal::restoreLogs

  log::info "Before rerouting Logs"
  test::flush

  test::prompt terminal::rerouteLogs
  terminal::rerouteLogs

  log::info "After rerouting Logs"

  test::prompt terminal::restoreLogs
  terminal::restoreLogs
  test::flush
}

main
