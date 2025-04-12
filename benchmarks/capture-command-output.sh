#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark

IFS=' '

function func1() {
  ls &>"${GLOBAL_TEMPORARY_STDOUT_FILE}" || return 1
  RETURNED_VALUE=""
  IFS='' read -rd '' RETURNED_VALUE <"${GLOBAL_TEMPORARY_STDOUT_FILE}" || :
}

function func2() {
  RETURNED_VALUE=""
  IFS='' read -rd '' RETURNED_VALUE < <(ls) || :
}

function func3() {
  RETURNED_VALUE="$(ls)"
}

func1
echo "func1: ${RETURNED_VALUE}"
func2
echo "func2: ${RETURNED_VALUE}"
func3
echo "func3: ${RETURNED_VALUE}"

benchmark::run func1 func2 func3

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func1         ░ 0.052s 142µs ░ N/A
# func2         ░ 0.079s 947µs ░ +53%
# func3         ░ 0.084s 363µs ░ +61%
#
# Better output to a file and then read its content