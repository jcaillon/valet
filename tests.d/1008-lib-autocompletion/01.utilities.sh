#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-autocompletion
source autocompletion


function testAutocompletionComputeSize() {
  echo "GLOBAL_LINES=10"
  echo "GLOBAL_COLUMNS=10"
  GLOBAL_LINES=10
  GLOBAL_COLUMNS=10

  echo "autocompletionComputeSize '' '' 1 1 20 20"
  autocompletionComputeSize '' '' 1 1 20 20
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  echo "autocompletionComputeSize 2 '' 1 1 20 20"
  autocompletionComputeSize 2 '' 1 1 20 20
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  echo
  echo "autocompletionComputeSize '' '' 1 1 5 5"
  autocompletionComputeSize '' '' 1 1 5 5
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  echo
  echo "autocompletionComputeSize '' '' 5 5 6 9"
  autocompletionComputeSize '' '' 5 5 6 9
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  echo
  echo "autocompletionComputeSize '' '' 7 7 10 4"
  autocompletionComputeSize '' '' 7 7 10 4
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  echo
  echo "autocompletionComputeSize '' true 7 7 10 10"
  autocompletionComputeSize '' true 7 7 10 10
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  test::endTest "Testing autocompletionComputeSize" 0
}


function testAutocompletionGetDisplayedPromptString() {
  AUTOCOMPLETION_PROMPT_WIDTH=5
  echo "AUTOCOMPLETION_PROMPT_WIDTH=${AUTOCOMPLETION_PROMPT_WIDTH}"

  testAutocompletionGetDisplayedPromptStringFunc ""       0 "" 0
  testAutocompletionGetDisplayedPromptStringFunc "a"      1 "a" 1
  testAutocompletionGetDisplayedPromptStringFunc "ab"     2 "ab" 2
  testAutocompletionGetDisplayedPromptStringFunc "abc"    3 "abc" 3
  testAutocompletionGetDisplayedPromptStringFunc "abcd"   4 "abcd" 4
  testAutocompletionGetDisplayedPromptStringFunc "abcde"  0 "abcde" 0
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 4 "…cdef" 3
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 3 "abcd…" 3
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 1 "abcd…" 1
  #                                               012345

  testAutocompletionGetDisplayedPromptStringFunc "abcde"  5 "…cde_" 4
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 6 "…def_" 4
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 5 "…cdef" 4
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 4 "…cdef" 3
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 3 "abcd…" 3
  #                                               012345
  testAutocompletionGetDisplayedPromptStringFunc "abcdefghij" 6 "…efg…" 3
  #                                               0123456789
  #                                               012345
  test::endTest "Testing autocompletionGetDisplayedPromptString" 0
}

function testAutocompletionGetDisplayedPromptStringFunc() {
  AUTOCOMPLETION_USER_STRING="${1}"
  AUTOCOMPLETION_PROMPT_CURSOR_INDEX="${2}"
  echo "AUTOCOMPLETION_USER_STRING=${AUTOCOMPLETION_USER_STRING} AUTOCOMPLETION_PROMPT_CURSOR_INDEX=${AUTOCOMPLETION_PROMPT_CURSOR_INDEX} autocompletionGetDisplayedPromptString"
  autocompletionGetDisplayedPromptString
  # echo " ░${RETURNED_VALUE:0:${RETURNED_VALUE2}}_${RETURNED_VALUE:$((RETURNED_VALUE2 + 1))}░"
  echo " ░${RETURNED_VALUE}░ ${RETURNED_VALUE2}"
  echo "=░${3}░ ${4}"
}

function main() {
  testAutocompletionComputeSize
  testAutocompletionGetDisplayedPromptString
}

main
