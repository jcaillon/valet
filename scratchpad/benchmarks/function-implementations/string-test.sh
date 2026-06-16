#!/usr/bin/env bash
# shellcheck source=../../../libraries.d/main
source "$(valet --source)"
include benchmark

STRING="- array yg uyguyg ygguygiuyg uguygug uyguyguyg"
FUNC=":"

function test1() {
  if [[ ${STRING:0:2} == '- ' ]]; then
    :
  fi
}

function test2() {
  if [[ ${STRING} == '- '* ]]; then
    :
  fi
}

benchmark::run test1 test2
