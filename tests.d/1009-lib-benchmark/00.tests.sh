#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-benchmark
source benchmark
# shellcheck source=../../libraries.d/lib-io
source io

function test_function_1() {
  io::sleep 0.01
}

function test_function_2() {
  io::sleep 0.05
}

function test_function_3() {
  io::sleep 0.03
}

function test_benchmark::run() {
  declare -f test_function_1 test_function_2 test_function_3

  echo
  echo "→ benchmark::run test_function_1 '' 1"
  benchmark::run test_function_1 '' 1

  echo
  echo "→ benchmark::run test_function_1 test_function_2,test_function_3 3 5"
  benchmark::run test_function_1 test_function_2,test_function_3 3 5
}


function main() {
  test_benchmark::run 2>"${GLOBAL_TEST_TEMP_FILE}"
  echoFileWithSubstitution "${GLOBAL_TEST_TEMP_FILE}"
  test::endTest "Testing benchmark::run function" 0
}

function echoFileWithSubstitution() {
  local file="${1}"
  local line
  local IFS
  while IFS=$'\n' read -rd $'\n' line || [[ -n ${line:-} ]]; do
    line="${line//[0-9]/X}"
    line="${line//⌜XX⌝/⌜X⌝}"
    echo "${line}"
  done <"${file}"
}

main
