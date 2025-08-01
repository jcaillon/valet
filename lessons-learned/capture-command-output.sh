#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark

IFS=' '

function func1() {
  ls &>"${GLOBAL_TEMPORARY_STDOUT_FILE}" || return 1
  REPLY=""
  IFS='' read -rd '' REPLY <"${GLOBAL_TEMPORARY_STDOUT_FILE}" || :
}

function func2() {
  REPLY=""
  IFS='' read -rd '' REPLY < <(ls) || :
}

function func3() {
  REPLY="$(ls)"
}

func1
echo "func1: ${REPLY}"
func2
echo "func2: ${REPLY}"
func3
echo "func3: ${REPLY}"

benchmark::run func1 func2 func3

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func1         ░ 0.052s 142µs ░ N/A
# func2         ░ 0.079s 947µs ░ +53%
# func3         ░ 0.084s 363µs ░ +61%
#
# Better output to a file and then read its content