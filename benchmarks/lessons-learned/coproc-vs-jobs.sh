#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark

function func1() {
  { coproc _PROGRESS_COPROC_PIPES { :; }  } 2>/dev/null
}

function func2() {
  { :; } &
}

benchmark::run func1 func2

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func2         ░ 0.027s 656µs ░ N/A
# func1         ░ 0.028s 172µs ░ +1%

# coproc and jobs are equally fast to spawn