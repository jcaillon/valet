#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-prompt
source prompt


function testPrompt_computeAutocompletionBoxSize() {
  echo "GLOBAL_LINES=10"
  echo "GLOBAL_COLUMNS=10"
  GLOBAL_LINES=10
  GLOBAL_COLUMNS=10

  echo "prompt_getAutocompletionBoxSize '' '' 1 1 20 20"
  prompt_getAutocompletionBoxSize '' '' 1 1 20 20
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo "prompt_getAutocompletionBoxSize 2 '' 1 1 20 20"
  prompt_getAutocompletionBoxSize 2 '' 1 1 20 20
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo
  echo "prompt_getAutocompletionBoxSize '' '' 1 1 5 5"
  prompt_getAutocompletionBoxSize '' '' 1 1 5 5
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo
  echo "prompt_getAutocompletionBoxSize '' '' 5 5 6 9"
  prompt_getAutocompletionBoxSize '' '' 5 5 6 9
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo
  echo "prompt_getAutocompletionBoxSize '' '' 7 7 10 4"
  prompt_getAutocompletionBoxSize '' '' 7 7 10 4
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo
  echo "prompt_getAutocompletionBoxSize '' true 7 7 10 10"
  prompt_getAutocompletionBoxSize '' true 7 7 10 10
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo
  echo
  echo "prompt_getAutocompletionBoxSize '' '' 1 1 20 20" false
  prompt_getAutocompletionBoxSize '' '' 1 1 20 20 false
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"
  echo

  echo "prompt_getAutocompletionBoxSize 2 '' 1 1 20 20" false
  prompt_getAutocompletionBoxSize 2 '' 1 1 20 20 false
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo
  echo "prompt_getAutocompletionBoxSize '' '' 1 1 5 5" false
  prompt_getAutocompletionBoxSize '' '' 1 1 5 5 false
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo
  echo "prompt_getAutocompletionBoxSize '' '' 5 5 6 9" false
  prompt_getAutocompletionBoxSize '' '' 5 5 6 9 false
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo
  echo "prompt_getAutocompletionBoxSize '' '' 7 7 10 4" false
  prompt_getAutocompletionBoxSize '' '' 7 7 10 4 false
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo
  echo "prompt_getAutocompletionBoxSize '' '' 7 7 4 4" false
  prompt_getAutocompletionBoxSize '' '' 7 7 4 4 false
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"

  echo
  echo "prompt_getAutocompletionBoxSize '' true 7 7 10 10" false
  prompt_getAutocompletionBoxSize '' true 7 7 10 10 false
  echo "${_PROMPT_AUTOCOMPLETION_BOX_WIDTH} x ${_PROMPT_AUTOCOMPLETION_BOX_HEIGHT} at ${_PROMPT_AUTOCOMPLETION_BOX_LEFT}:${_PROMPT_AUTOCOMPLETION_BOX_TOP}"
  test::endTest "Testing prompt_getAutocompletionBoxSize" 0
}


function testPrompt_getDisplayedPromptString() {
  _PROMPT_STRING_WIDTH=5
  echo "_PROMPT_STRING_WIDTH=${_PROMPT_STRING_WIDTH}"

  testPrompt_getDisplayedPromptStringFunc ""       0 "" 0
  testPrompt_getDisplayedPromptStringFunc "a"      1 "a" 1
  testPrompt_getDisplayedPromptStringFunc "ab"     2 "ab" 2
  testPrompt_getDisplayedPromptStringFunc "abc"    3 "abc" 3
  testPrompt_getDisplayedPromptStringFunc "abcd"   4 "abcd" 4
  testPrompt_getDisplayedPromptStringFunc "abcde"  0 "abcde" 0
  testPrompt_getDisplayedPromptStringFunc "abcdef" 4 "…cdef" 3
  testPrompt_getDisplayedPromptStringFunc "abcdef" 3 "abcd…" 3
  testPrompt_getDisplayedPromptStringFunc "abcdef" 1 "abcd…" 1
  #                                               012345

  testPrompt_getDisplayedPromptStringFunc "abcde"  5 "…cde" 4
  testPrompt_getDisplayedPromptStringFunc "abcdef" 6 "…def" 4
  testPrompt_getDisplayedPromptStringFunc "abcdef" 5 "…cdef" 4
  testPrompt_getDisplayedPromptStringFunc "abcdef" 4 "…cdef" 3
  testPrompt_getDisplayedPromptStringFunc "abcdef" 3 "abcd…" 3
  #                                               012345
  testPrompt_getDisplayedPromptStringFunc "abcdefghij" 6 "…efg…" 3
  #                                               0123456789
  #                                               012345
  testPrompt_getDisplayedPromptStringFunc "abcdefghij" 3 "abcd…" 3
  testPrompt_getDisplayedPromptStringFunc "abcdefghij" 4 "…cde…" 3
  testPrompt_getDisplayedPromptStringFunc "abcdefghij" 5 "…def…" 3

  _PROMPT_STRING_WIDTH=4
  echo "_PROMPT_STRING_WIDTH=${_PROMPT_STRING_WIDTH}"
  testPrompt_getDisplayedPromptStringFunc "bl" 0 "bl" 0
  test::endTest "Testing prompt_getDisplayedPromptString" 0
}

function testPrompt_getDisplayedPromptStringFunc() {
  _PROMPT_STRING="${1}"
  _PROMPT_STRING_INDEX="${2}"
  echo "_PROMPT_STRING=${_PROMPT_STRING} _PROMPT_STRING_INDEX=${_PROMPT_STRING_INDEX} prompt_getDisplayedPromptString"
  prompt_getDisplayedPromptString
  # echo " ░${RETURNED_VALUE:0:${RETURNED_VALUE2}}_${RETURNED_VALUE:$((RETURNED_VALUE2 + 1))}░"
  echo " ░${RETURNED_VALUE}░ ${RETURNED_VALUE2}"
  echo "=░${3}░ ${4}"
}

function main() {
  testPrompt_computeAutocompletionBoxSize
  testPrompt_getDisplayedPromptString
}

main
