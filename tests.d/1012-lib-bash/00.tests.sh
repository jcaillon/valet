#!/usr/bin/env bash

function test_function_to_reexport() {
  local -i firstArg=$1
  local secondArg="${2}"
  local -A thirdArg="${3:-egez}"

  if (( firstArg == 0 )); then
    echo "cool"
  fi
  if [[ "${secondArg}" == "cool" ]]; then
    echo "${secondArg}"
  fi
  if [[ "${thirdArg[cool]}" == "cool" ]]; then
    echo "${thirdArg[cool]}"
  fi
}

function test_bash::getFunctionDefinitionWithGlobalVars() {

  declare -f test_function_to_reexport
  echo
  echo "→ bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG"
  bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG
  echo "${RETURNED_VALUE}"
  echo
  echo "→ bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name"
  bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name
  echo "${RETURNED_VALUE}"

  test::endTest "Testing bash::getFunctionDefinitionWithGlobalVars" 0
}

function test_bash::countJobs() {
  test::endTest "Testing bash::countJobs" 0
}

function main() {
  test_bash::getFunctionDefinitionWithGlobalVars
}

main
