#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_LOG_LEVEL="debug"
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<pid>{04d}:<subshell>{1s}]   <colorFaded><sourceFile>{-5s}:<line>{-4s}<colorDefault>  <levelColor><level>{-4s} <colorDefault> <message>"

source "libraries.d/core"
include tui coproc


function initCommand() {
  log::info "Running init command in coproc (${coprocVarName})."
}

function loopCommand() {
  log::info "Running loop command in coproc (${coprocVarName})."
}

function onMessageCommand() {
  log::info "Received message in coproc (${coprocVarName}): ${_COPROC_MESSAGE}"
  return 1
}

coproc::run _COPROC_2 initCommand loopCommand onMessageCommand
coproc::sendMessage _COPROC_2 "Hello, coproc 2!"
coproc::wait _COPROC_2


# log::info "Before rerouting Logs"
# terminal::rerouteLogs
# log::info "After rerouting Logs"
# log::warning "This is a warning"
# terminal::restoreLogs
# log::info "end"

# tui::startMainLoop
