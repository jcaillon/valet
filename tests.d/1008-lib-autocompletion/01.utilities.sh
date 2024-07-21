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

  testAutocompletionGetDisplayedPromptStringFunc ""       0 "_"
  testAutocompletionGetDisplayedPromptStringFunc "a"      1 "a_"
  testAutocompletionGetDisplayedPromptStringFunc "ab"     2 "ab_"
  testAutocompletionGetDisplayedPromptStringFunc "abc"    3 "abc_"
  testAutocompletionGetDisplayedPromptStringFunc "abcd"   4 "abcd_"
  testAutocompletionGetDisplayedPromptStringFunc "abcde"  0 "#bcde"
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 4 "…cd#f"
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 3 "abc#…"
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 1 "a#cd…"
  #                                               012345

  testAutocompletionGetDisplayedPromptStringFunc "abcde"  5 "…cde_"
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 6 "…def_"
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 5 "…cde#"
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 4 "…cd#f"
  testAutocompletionGetDisplayedPromptStringFunc "abcdef" 3 "…bc#…"
  #                                               012345
  testAutocompletionGetDisplayedPromptStringFunc "abcdefghij" 6 "…ef#…"
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
  echo "=░${3}░"
}

function main() {
  testAutocompletionComputeSize
  testAutocompletionGetDisplayedPromptString
}

main
