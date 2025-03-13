#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-prompt
source prompt

function main() {
  test_prompt_getIndexDeltaToEndOfWord
  test_prompt_getIndexDeltaToBeginningOfWord
  test_prompt_getDisplayedPromptString
}

function test_prompt_getIndexDeltaToEndOfWord() {
  test::title "✅ Testing prompt_getIndexDeltaToEndOfWord"

  _PROMPT_STRING="Lorem   ipsum"
  #               _   __  _ ___
  #               0123456789
  #                        10123
  test::func _PROMPT_STRING_INDEX=0 prompt_getIndexDeltaToEndOfWord
  test::func _PROMPT_STRING_INDEX=4 prompt_getIndexDeltaToEndOfWord
  test::func _PROMPT_STRING_INDEX=5 prompt_getIndexDeltaToEndOfWord
  test::func _PROMPT_STRING_INDEX=8 prompt_getIndexDeltaToEndOfWord
  test::func _PROMPT_STRING_INDEX=10 prompt_getIndexDeltaToEndOfWord
  test::func _PROMPT_STRING_INDEX=11 prompt_getIndexDeltaToEndOfWord
  test::func _PROMPT_STRING_INDEX=12 prompt_getIndexDeltaToEndOfWord
  test::func _PROMPT_STRING_INDEX=20 prompt_getIndexDeltaToEndOfWord
}

function test_prompt_getIndexDeltaToBeginningOfWord() {
  test::title "✅ Testing prompt_getIndexDeltaToBeginningOfWord"

  _PROMPT_STRING="Lorem ipsum  "
  #               _    __  _ ___
  #               0123456789
  #                        10123
  test::func _PROMPT_STRING_INDEX=0 prompt_getIndexDeltaToBeginningOfWord
  test::func _PROMPT_STRING_INDEX=5 prompt_getIndexDeltaToBeginningOfWord
  test::func _PROMPT_STRING_INDEX=6 prompt_getIndexDeltaToBeginningOfWord
  test::func _PROMPT_STRING_INDEX=9 prompt_getIndexDeltaToBeginningOfWord
  test::func _PROMPT_STRING_INDEX=11 prompt_getIndexDeltaToBeginningOfWord
  test::func _PROMPT_STRING_INDEX=12 prompt_getIndexDeltaToBeginningOfWord
  test::func _PROMPT_STRING_INDEX=13 prompt_getIndexDeltaToBeginningOfWord
  test::func _PROMPT_STRING_INDEX=20 prompt_getIndexDeltaToBeginningOfWord
}

function test_prompt_getDisplayedPromptString() {
  test::title "✅ Testing prompt_getDisplayedPromptString"

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
}

function test_prompt_internal() {
  _PROMPT_STRING_SCREEN_WIDTH="${1}"
  _PROMPT_STRING="${2}"
  _PROMPT_STRING_INDEX="${3}"
  test::printVars _PROMPT_STRING _PROMPT_STRING_INDEX _PROMPT_STRING_SCREEN_WIDTH
  test::exec prompt_getDisplayedPromptString
  test::markdown "\`░${RETURNED_VALUE}░ ${RETURNED_VALUE2}\`"
  if [[ "░${RETURNED_VALUE}░ ${RETURNED_VALUE2}" != "░${4}░ ${5}" ]]; then
    echo "Expected: ░${4}░ ${5}"
    exit 1
  fi
}

main
