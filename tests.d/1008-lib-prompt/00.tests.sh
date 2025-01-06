#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-prompt
source prompt

function test_prompt_getDisplayedPromptString() {
  test_prompt_internal 5 ""       0 "" 0
  test_prompt_internal 5 "a"      1 "a" 1
  test_prompt_internal 5 "ab"     2 "ab" 2
  test_prompt_internal 5 "abc"    3 "abc" 3
  test_prompt_internal 5 "abcd"   4 "abcd" 4
  test_prompt_internal 5 "abcde"  0 "abcde" 0
  test_prompt_internal 5 "abcdef" 4 "…cdef" 3
  test_prompt_internal 5 "abcdef" 3 "abcd…" 3
  test_prompt_internal 5 "abcdef" 1 "abcd…" 1
  #                                               012345

  test_prompt_internal 5 "abcde"  5 "…cde" 4
  test_prompt_internal 5 "abcdef" 6 "…def" 4
  test_prompt_internal 5 "abcdef" 5 "…cdef" 4
  test_prompt_internal 5 "abcdef" 4 "…cdef" 3
  test_prompt_internal 5 "abcdef" 3 "abcd…" 3
  #                                               012345
  test_prompt_internal 5 "abcdefghij" 6 "…efg…" 3
  #                                               0123456789
  #                                               012345
  test_prompt_internal 5 "abcdefghij" 3 "abcd…" 3
  test_prompt_internal 5 "abcdefghij" 4 "…cde…" 3
  test_prompt_internal 5 "abcdefghij" 5 "…def…" 3

  test_prompt_internal 10 "This is a long string that will be displayed in the screen." 20 "…g string…" 8

  test_prompt_internal 4 "bl" 0 "bl" 0

  test::endTest "Testing prompt_getDisplayedPromptString" 0
}

function test_prompt_internal() {
  _PROMPT_STRING_SCREEN_WIDTH="${1}"
  _PROMPT_STRING="${2}"
  _PROMPT_STRING_INDEX="${3}"
  echo
  declare -p _PROMPT_STRING _PROMPT_STRING_INDEX _PROMPT_STRING_SCREEN_WIDTH
  echo "→ prompt_getDisplayedPromptString"
  prompt_getDisplayedPromptString
  echo " ░${RETURNED_VALUE}░ ${RETURNED_VALUE2}"
  if [[ "░${RETURNED_VALUE}░ ${RETURNED_VALUE2}" != "░${4}░ ${5}" ]]; then
    echo "Expected: ░${4}░ ${5}"
    exit 1
  fi
}

function test_prompt::getItemDisplayedString() {
  local FG_CYAN=$'\033[36m'
  local FG_RESET=$'\033[0m'

  _PROMPT_COLOR_LETTER_HIGHLIGHT=">"
  _PROMPT_COLOR_LETTER_HIGHLIGHT_RESET="<"
  _PROMPT_ITEMS_BOX_ITEM_WIDTH=5
  _PROMPT_ITEMS_BOX_FILTER_STRING="elor"
  _PROMPT_ITEMS_BOX_ITEM_DISPLAYED="Hello world"
  declare -p _PROMPT_ITEMS_BOX_ITEM_DISPLAYED _PROMPT_ITEMS_BOX_ITEM_WIDTH _PROMPT_ITEMS_BOX_FILTER_STRING
  echo "→ prompt::getItemDisplayedString"
  prompt::getItemDisplayedString
  echo "${_PROMPT_ITEMS_BOX_ITEM_DISPLAYED}"

  echo
  _PROMPT_ITEMS_BOX_ITEM_DISPLAYED="${FG_CYAN}Hello${FG_RESET} world"
  _PROMPT_ITEMS_BOX_ITEM_WIDTH=10
  declare -p _PROMPT_ITEMS_BOX_ITEM_DISPLAYED _PROMPT_ITEMS_BOX_ITEM_WIDTH _PROMPT_ITEMS_BOX_FILTER_STRING
  echo "→ prompt::getItemDisplayedString"
  prompt::getItemDisplayedString
  echo "${_PROMPT_ITEMS_BOX_ITEM_DISPLAYED}"

  echo
  _PROMPT_ITEMS_BOX_ITEM_DISPLAYED="${FG_CYAN}Hello${FG_RESET} world"
  _PROMPT_ITEMS_BOX_ITEM_WIDTH=11
  declare -p _PROMPT_ITEMS_BOX_ITEM_DISPLAYED _PROMPT_ITEMS_BOX_ITEM_WIDTH _PROMPT_ITEMS_BOX_FILTER_STRING
  echo "→ prompt::getItemDisplayedString"
  prompt::getItemDisplayedString
  echo "${_PROMPT_ITEMS_BOX_ITEM_DISPLAYED}"

  echo
  # shellcheck disable=SC2089
  _PROMPT_COLOR_LETTER_HIGHLIGHT=$'\033[4m'
  _PROMPT_COLOR_LETTER_HIGHLIGHT_RESET=$'\033[24m'
  _PROMPT_ITEMS_BOX_ITEM_DISPLAYED='[7m[35md[27m[39m[7m[35mi[27m[39msable the [93mmonitor mode to avoid[39m the "Terminated" message with exit code once the spinner is stopped'
  _PROMPT_ITEMS_BOX_FILTER_STRING="abomamwesspp"
  _PROMPT_ITEMS_BOX_ITEM_WIDTH=71
  # shellcheck disable=SC2090
  declare -p _PROMPT_ITEMS_BOX_ITEM_DISPLAYED _PROMPT_ITEMS_BOX_ITEM_WIDTH _PROMPT_ITEMS_BOX_FILTER_STRING
  echo "→ prompt::getItemDisplayedString"
  prompt::getItemDisplayedString
  echo "${_PROMPT_ITEMS_BOX_ITEM_DISPLAYED}"

  test::endTest "Testing prompt::getItemDisplayedString" 0
}

function main() {
  test_prompt_getDisplayedPromptString
  test_prompt::getItemDisplayedString
}

main
