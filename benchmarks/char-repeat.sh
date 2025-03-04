#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark

# test terminal ESC code for char repeat versus printf

function func1() {
  printf "%s" "#${ESC__REPEAT__}49${__ESC__LAST_CHAR}"
}

printf -v fu "%50s" ""
fu="${fu// /#}"
function func2() {
  printf "%s" "${fu}"
}

func1
echo
func2
benchmark::run func1 func2 3
