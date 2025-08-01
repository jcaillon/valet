#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark

# test terminal ESC code for char repeat versus printf

printf -v fu "%50s" ""
fu="${fu// /#}"

function func1() {
  printf "%s" "${fu}"
}

function func2() {
  printf "%s" "#${ESC__REPEAT__}49${__ESC__LAST_CHAR}"
}

benchmark::run func1 func2

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func1         ░ 0.000s 130µs ░ N/A
# func2         ░ 0.000s 179µs ░ +37%