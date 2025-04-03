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
  local -i index
  for (( index = 0; index < ${#MY_ARRAY[@]}; index++ )); do
    :;
  done
}

benchmark::run func1 func2
