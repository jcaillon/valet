#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_LOG_LEVEL="debug"
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<pid>{04d}:<subshell>{1s}]   <colorFaded><sourceFile>{-5s}:<line>{-4s}<colorDefault>  <levelColor><level>{-4s} <colorDefault> <message>"


source "libraries.d/core"
include tui coproc

function ret1() {
  ((0/0)) # This will fail and exit the subshell
  log::info "This line will not be executed because the previous command failed."
  return 1
}

compoundCommand=ret1
set +o errexit
GLOBAL_ERROR_TRAP_TEST_MODE_ENABLED=true
eval "${compoundCommand}"
exitCode="${GLOBAL_ERROR_TRAP_LAST_ERROR_CODE}"
GLOBAL_ERROR_TRAP_TEST_MODE_ENABLED=false

log::info "ok, exitCode=${exitCode}"

exit 0

function onSubshellExit() {
  log::warning "Subshell exited with code $1"
}

function initCommand() {
  ((0/0)) # This will fail and exit the subshell
  log::info "This line will not be executed because the previous command failed."
}

_OPTION_INIT_COMMAND=initCommand coproc::run _COPROC_20
coproc::wait _COPROC_20
