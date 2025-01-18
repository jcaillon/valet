#!/usr/bin/env bash

function main() {
  test_bash::getFunctionDefinitionWithGlobalVars
}

function test_function_to_reexport() {
  local -i firstArg=$1
  local secondArg="${2}"
  local -A thirdArg="${3:-egez}"
  local -a fourth="${4?"The function ⌜${FUNCNAME:-?}⌝ requires more arguments."}"

  if (( firstArg == 0 )); then
    echo "cool"
  fi
  if [[ "${secondArg}" == "cool" ]]; then
    echo "${secondArg}"
  fi
  if [[ "${thirdArg[cool]}" == "cool" ]]; then
    echo "${thirdArg[cool]}"
  fi
  if [[ "${fourth[cool]}" == "cool" ]]; then
    echo "${fourth[cool]}"
  fi
}

function test_bash::getFunctionDefinitionWithGlobalVars() {

  test::title "✅ Testing bash::getFunctionDefinitionWithGlobalVars"
  test::exec declare -f test_function_to_reexport
  test::func bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG FOURTH_ARG


  test::title "✅ Testing bash::getFunctionDefinitionWithGlobalVars without arguments"
  test::func bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name
}

main