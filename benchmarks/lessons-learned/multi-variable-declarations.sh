#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark

function func1() {
  local VAR1="${1:-default1}"
  local VAR2="${2:-default2}"
  local VAR3="${3:-default3}"
  local VAR4="${4:-default4}"
  local VAR5="${5:-default5}"
  local VAR6="${6:-default6}"
  local VAR7="${7:-default7}"
  local VAR8="${8:-default8}"
  local VAR9="${9:-default9}"
  local VAR10="${10:-default10}"
}

function func2() {
  local VAR1 VAR2 VAR3 VAR4 VAR5 VAR6 VAR7 VAR8 VAR9 VAR10
  : "${VAR1:=default1}" "${VAR2:=default2}" "${VAR3:=default3}" "${VAR4:=default4}" \
    "${VAR5:=default5}" "${VAR6:=default6}" "${VAR7:=default7}" \
    "${VAR8:=default8}" "${VAR9:=default9}" "${VAR10:=default10}"
}

function func3() {
  local VAR1 VAR2 VAR3 VAR4 VAR5 VAR6 VAR7 VAR8 VAR9 VAR10
  VAR1="${1:-default1}"
  VAR2="${2:-default2}"
  VAR3="${3:-default3}"
  VAR4="${4:-default4}"
  VAR5="${5:-default5}"
  VAR6="${6:-default6}"
  VAR7="${7:-default7}"
  VAR8="${8:-default8}"
  VAR9="${9:-default9}"
  VAR10="${10:-default10}"
}

benchmark::run func1 func2 func3

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func2         ░ 0.000s 032µs ░ N/A
# func3         ░ 0.000s 038µs ░ +16%
# func1         ░ 0.000s 042µs ░ +29%

# It is faster to declare all variables at once and assign them in the same statement.