#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<subshell>{1s}] <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"
# export VALET_CONFIG_LOG_FD=tmp/log

source "libraries.d/core"
include bash

function onSubshellExit() {
  log::warning "Subshell exited with code $1"
}

log::info "Running in main program with PID: ${BASHPID}"
bash::runInSubshell log::info "Running in a subshell with PID:" "" "" "new line"

function subshellThatFails() {
  log::info "Running in a subshell that fails with PID: ${BASHPID}"
  ((0/0)) # This will fail and exit the subshell
  log::info "This line will not be executed because the previous command failed."
}

sleep 2

bash::runInSubshell subshellThatFails

log::info "This line will be executed because the main program has exited."