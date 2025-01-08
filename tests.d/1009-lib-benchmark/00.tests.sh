#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-benchmark
source benchmark
# shellcheck source=../../libraries.d/lib-io
source io

function test_function_1() {
  :
}

function test_function_2() {
  :
}

function test_function_3() {
  :
}

function test_benchmark::run() {
  declare -f test_function_1 test_function_2 test_function_3

  echo
  echo "→ benchmark::run test_function_1 test_function_2,test_function_3 3 5"
  benchmark::run test_function_1 test_function_2,test_function_3 3 5
}

function echoFileWithSubstitution() {
  local file="${1}"
  local line
  local IFS
  while IFS=$'\n' read -rd $'\n' line || [[ -n ${line:-} ]]; do
    line="${line//[0-9]/X}"
    line="${line//XXX/X}"
    line="${line//XX/X}"
    echo "${line}"
  done <"${file}"
}

function main() {
  test_benchmark::run 2>"${GLOBAL_TEST_TEMP_FILE}"
  echoFileWithSubstitution "${GLOBAL_TEST_TEMP_FILE}"
  test::endTest "Testing benchmark::run function" 0
}

main
