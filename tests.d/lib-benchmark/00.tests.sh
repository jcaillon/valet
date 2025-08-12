#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-benchmark
source benchmark

function main() {
  test_benchmark::run
}

function test_benchmark::run() {
  test::title "✅ Testing benchmark::run"

  test::exec declare -f test_function_1 test_function_2 test_function_3
  test::exec benchmark::run test_function_1 test_function_2 test_function_3 --- baselineTimeInSeconds=3 maxRun=5
}

function test_function_1() {
  :
}

function test_function_2() {
  :
}

function test_function_3() {
  :
}

main
