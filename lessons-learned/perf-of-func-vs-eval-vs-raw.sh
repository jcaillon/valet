#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark

function function_call() {
  :
}

FUNC1="function_call"
FUNC2=:

function test1() {
  :
}

function test2() {
  ${FUNC2}
}

function test3() {
  ${FUNC1}
}

function test4() {
  eval ":"
}

benchmark::run test1 test2 test3 test4

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test1         ░ 0.000s 005µs ░ N/A
# test2         ░ 0.000s 006µs ░ +11%
# test3         ░ 0.000s 008µs ░ +51%
# test4         ░ 0.000s 008µs ░ +55%
