#!/usr/bin/env bash

function main() {
  test_bash::getFunctionDefinitionWithGlobalVars
  test_bash::countJobs
  test_bash::injectCodeInFunction
}

function test_bash::injectCodeInFunction() {
  test::title "✅ Testing bash::injectCodeInFunction"

  function simpleFunction() { :;}
  test::exec declare -f simpleFunction
  test::exec bash::injectCodeInFunction simpleFunction "echo 'injected at the beginning!'" true
  test::prompt "echo \${RETURNED_VALUE}; echo \${RETURNED_VALUE2};"
  echo "${RETURNED_VALUE}"
  echo "${RETURNED_VALUE2}"
  test::flush

  test::exec bash::injectCodeInFunction simpleFunction "echo 'injected at the end!'"
  test::prompt "echo \${RETURNED_VALUE}; echo \${RETURNED_VALUE2};"
  echo "${RETURNED_VALUE}"
  echo "${RETURNED_VALUE2}"
  test::flush

  test::exec bash::injectCodeInFunction newName "echo 'injected in a new function!'"
  test::prompt "echo \${RETURNED_VALUE}; echo \${RETURNED_VALUE2};"
  echo "${RETURNED_VALUE}"
  echo "${RETURNED_VALUE2}"
  test::flush
}

function test_bash::countJobs() {
  test::title "✅ Testing bash::countJobs"

  # overriding the builtin jobs command
  # shellcheck disable=SC2317
  function jobs() {
    echo "[1]   Running                 stuff &
[2]-  Running                 stuff &
[3]+  Running                 stuff &
"
  }
  test::prompt "stuff &; stuff &; stuff &"
  test::func bash::countJobs
  unset -f jobs
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
  test::exec bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG FOURTH_ARG
  test::prompt "echo \${RETURNED_VALUE}"
  echo "${RETURNED_VALUE}"
  test::flush


  test::markdown "Testing without arguments"
  test::exec bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name
  test::prompt "echo \${RETURNED_VALUE}"
  echo "${RETURNED_VALUE}"
  test::flush
}

main