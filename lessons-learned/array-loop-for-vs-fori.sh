#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark

MY_ARRAY=( {1..100} )

function func1() {
  local element
  for element in "${MY_ARRAY[@]}"; do
    :;
  done
}

function func2() {
  local -i index len=${#MY_ARRAY[@]}
  for (( index = 0; index < len; index++ )); do
    :;
  done
}

function func3() {
  local -i index
  for (( index = 0; index < ${#MY_ARRAY[@]}; index++ )); do
    :;
  done
}

benchmark::run func1 func2 func3

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func1         ░ 0.000s 156µs ░ N/A
# func2         ░ 0.000s 237µs ░ +52%
# func3         ░ 0.000s 309µs ░ +98%
#
# Better pre compute the length of the array
# for i loop is not faster than for each loop

log::info "# LESSONS LEARNED:

- Better pre compute the length of the array
- for i loop is not faster than for each loop
"
