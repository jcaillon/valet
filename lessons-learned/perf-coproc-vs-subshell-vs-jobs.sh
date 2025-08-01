#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark bash coproc

declare -i NB=0

function func1() {
  _OPTION_INIT_COMMAND=":" coproc::run du$((NB++))
}

function func2() {
  bash::runInSubshell :
}

function func3() {
  { coproc _PROGRESS_COPROC_PIPES { :; }  } 2>/dev/null
}

function func4() {
  { :; } &
}

benchmark::run func1 func2 func3 func4

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func3         ░ 0.034s 431µs ░ N/A
# func1         ░ 0.034s 436µs ░ +0%
# func4         ░ 0.035s 001µs ░ +1%
# func2         ░ 0.040s 610µs ░ +17%

# coproc and jobs are equally fast to spawn
# using coproc::run does not cost more than using bash::runInSubshell
# using our own functions do not cost significantly more than using the shell's built-in job control or vanilla coproc
#
# -> basically we can use coproc::run everywhere...