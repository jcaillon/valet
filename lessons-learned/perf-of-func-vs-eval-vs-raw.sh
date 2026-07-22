#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark

function function_call() {
  :
}

FUNC1="function_call"
FUNC2=:

function test1() {
  : "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}"
}

function test2() {
  ${FUNC2} "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}"
}

function test3() {
  ${FUNC1} "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}"
}

function test4() {
  eval ": ${FUNC1} ${FUNC1} ${FUNC1} ${FUNC1} ${FUNC1} ${FUNC1} ${FUNC1} ${FUNC1}"
}

function test5() {
  if declare -F non-existing >/dev/null; then
    : "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}" "${FUNC1}"
  fi
}

benchmark::run test1 test2 test3 test4 test5

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test1         ░ 0.000s 013µs ░ N/A
# test2         ░ 0.000s 014µs ░ +5%
# test3         ░ 0.000s 016µs ░ +24%
# test5         ░ 0.000s 016µs ░ +25%
# test4         ░ 0.000s 020µs ░ +51%

# Lesson learned:
# If you have to optionally call a function, use a variable and make it default to ":" instead of checking
# if the function exists.
