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

function test_core::reExportFuncToUseGlobalVars() {

  declare -f test_function_to_reexport
  echo
  echo "→ core::reExportFuncToUseGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG"
  core::reExportFuncToUseGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG
  echo "${RETURNED_VALUE}"

  test::endTest "Testing core::reExportFuncToUseGlobalVars" 0
}

function main() {
  test_core::reExportFuncToUseGlobalVars
}

main
