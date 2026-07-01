#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark

BOOL=true
INT1=1
declare -g -i INT2=1

function test1() {
  if ((INT1 == 1)); then
    :
  fi
}

function test1bis() {
  if ((INT2 == 1)); then
    :
  fi
}

function test2() {
  if [[ ${INT1} == 1 ]]; then
    :
  fi
}

function test3() {
  if [[ ${BOOL} == true ]]; then
    :
  fi
}

function test4() {
  if [[ ${BOOL} == "true" ]]; then
    :
  fi
}

benchmark::run test1 test2 test3 test4 test1bis

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test1         ░ 0.000s 006µs ░ N/A
# test1bis      ░ 0.000s 006µs ░ +1%
# test2         ░ 0.000s 007µs ░ +6%
# test3         ░ 0.000s 007µs ░ +7%
# test4         ░ 0.000s 007µs ░ +13%
