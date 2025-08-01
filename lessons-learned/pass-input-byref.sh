#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark

# test to pass input by ref versus by value
_PROMPT_STRING="Lorem ipsum   dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum   dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum   dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum   dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

function subFunction1() {
  local -n text="${1}"
  local length="${#text}"
}

function subFunction2() {
  local text="${1}"
  local length="${#text}"
}

function func1() {
  subFunction1 _PROMPT_STRING
}

function func2() {
  subFunction2 "${_PROMPT_STRING}"
}

benchmark::run func1 func2

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func1         ░ 0.000s 015µs ░ N/A
# func2         ░ 0.000s 026µs ░ +74%
#
# Better pass large string by reference