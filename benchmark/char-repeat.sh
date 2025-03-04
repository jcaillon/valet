#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark

# test terminal ESC code for char repeat versus printf

function ffunc1() {
  local text="${1}"
  local length="${#text}"
}

function ffunc2() {
  local -n text="${1}"
  local length="${#text}"
}

function func1() {
  ffunc1 "${_PROMPT_STRING}"
}

function func2() {
  ffunc2 _PROMPT_STRING
}

benchmark::run func1 func2 3
