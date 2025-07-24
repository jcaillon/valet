#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_LOG_LEVEL="debug"
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<pid>{04d}:<subshell>{1s}]   <colorFaded><sourceFile>{-5s}:<line>{-4s}<colorDefault>  <levelColor><level>{-4s} <colorDefault> <message>"


source "libraries.d/core"
include tui coproc

function onSubshellExit() {
  log::warning "Subshell exited with code $1"
}

function initCommand() {
# # re-enable errexit in the subshell
# set -o errexit

# # we are inside a coproc, register the correct traps
# trap::registerSubshell

  ((0/0)) # This will fail and exit the subshell
  log::info "This line will not be executed because the previous command failed."
}

coproc::run _COPROC_20 initCommand false willNotBeUsed ":"
coproc::wait _COPROC_20