#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_LOG_LEVEL="debug"
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<pid>{04d}:<subshell>{1s}] <colorFaded><sourceFile>{-5s}:<line>{-4s}<colorDefault>  <levelColor><level>{-4s} <colorDefault> <message>"

# shellcheck source=../libraries.d/main
source "$(valet --source)"
include tui coproc fs bash terminal exe

# ========================================

function functionWithFiniteArgs() {
  local \
    arg1="${1}" \
    arg2="${2}" \
    myOption="1" \
    myOption2="2" \
    IFS=$' '
  shift 2
  eval "local a= ${*@Q}"

  echo "local a= ${*@Q}"
  local
}

function functionWithInfiniteArgs() {
  local \
    arg1="${1}" \
    arg2="${2}" \
    myOption="1" \
    myOption2="2"
  shift 2
  core::parseShellParameters "${@}"
  eval "${REPLY}"

  echo "${REPLY}"
  local
  echo "remaining arguments: '${*}'"
}

functionWithFiniteArgs 1 2 --- 111