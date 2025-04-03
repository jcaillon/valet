#!/usr/bin/env bash
set -Eeu -o pipefail

#===============================================================
# >>> Source main functions
#===============================================================
# shellcheck source=libraries.d/core
source "libraries.d/core"

source benchmark

#===============================================================
# >>> Run the main function
#===============================================================

_PROMPT_STRING="Lorem ipsum   dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum   dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum   dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum   dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

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

benchmark::run func1 func2
