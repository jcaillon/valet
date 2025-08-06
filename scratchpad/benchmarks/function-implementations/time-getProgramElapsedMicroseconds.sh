#!/usr/bin/env bash
# shellcheck source=../../../libraries.d/main
source "$(valet --source)"
include benchmark

function func1() {
  REPLY=$(((${EPOCHREALTIME%%[.,]*} - GLOBAL_PROGRAM_STARTED_AT_SECOND) * 1000000 + (10#${EPOCHREALTIME##*[.,]} - 10#${GLOBAL_PROGRAM_STARTED_AT_MICROSECOND})))
}

function func2() {
  eval "REPLY=\$(((${EPOCHREALTIME%%[.,]*} - GLOBAL_PROGRAM_STARTED_AT_SECOND) * 1000000 + (10#${EPOCHREALTIME##*[.,]} - 10#${GLOBAL_PROGRAM_STARTED_AT_MICROSECOND})))"
}

function func3() {
  local \
    currentSeconds="${EPOCHREALTIME%%[.,]*}" \
    currentMicroseconds="${EPOCHREALTIME##*[.,]}"
  REPLY=$(((currentSeconds - GLOBAL_PROGRAM_STARTED_AT_SECOND) * 1000000 + (10#${currentMicroseconds} - 10#${GLOBAL_PROGRAM_STARTED_AT_MICROSECOND})))
}

benchmark::run func1 func2 func3

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func1         ░ 0.000s 016µs ░ N/A
# func2         ░ 0.000s 022µs ░ +35%
# func3         ░ 0.000s 024µs ░ +47%