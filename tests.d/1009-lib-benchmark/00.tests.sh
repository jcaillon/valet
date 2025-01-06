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

  test::endTest "Testing benchmark::run function" 0

}


function main() {
  test_benchmark::run
}

main
