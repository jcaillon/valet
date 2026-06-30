#!/usr/bin/env bash
# shellcheck source=../../../libraries.d/main
source "$(valet --source)"
include benchmark

STRING="- array yg uyguyg ygguygiuyg uguygug uyguyguyg"
SUBSTRING="${STRING%%yg*}"

# shellcheck disable=SC2317
function test1() {
  if [[ ${STRING:0:2} == '- ' ]]; then
    :
  fi
}

# shellcheck disable=SC2317
function test2() {
  if [[ ${STRING} == '- '* ]]; then
    :
  fi
}

benchmark::run test1 test2
# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test2         ░ 0.000s 007µs ░ N/A
# test1         ░ 0.000s 007µs ░ +9%

# it is slightly faster to use the glob pattern than to use substring extraction

function test1() {
  STR="${STRING:${#SUBSTRING}}"
}

function test2() {
  STR="${STRING#"${SUBSTRING}"}"
}

benchmark::run test1 test2

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test1         ░ 0.000s 007µs ░ N/A
# test2         ░ 0.000s 008µs ░ +14%

# it is slightly faster to use substring extraction than to use parameter expansion with a prefix pattern
