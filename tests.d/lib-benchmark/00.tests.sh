#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-benchmark
source benchmark

function main() {
  test_benchmark::run
}

function test_benchmark::run() {
  test::title "✅ Testing benchmark::run"

  test::exec declare -f test_function_1 test_function_2 test_function_3
  test::exec benchmark::run test_function_1 test_function_2,test_function_3 3 5
}

# override time::getProgramElapsedMicroseconds to return a fake incremental time
function time::getProgramElapsedMicroseconds() {
  if [[ -z ${_FAKE_TIME:-} ]]; then
    _FAKE_TIME=0
    _TIME_FACTOR=1
  fi
  ((_FAKE_TIME=_FAKE_TIME+ 1000000 * _TIME_FACTOR, _TIME_FACTOR++))
  RETURNED_VALUE="${_FAKE_TIME}"
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
