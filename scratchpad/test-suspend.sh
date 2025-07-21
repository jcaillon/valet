#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_LOG_LEVEL="debug"
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<pid>{04d}:<subshell>{1s}]   <colorFaded><sourceFile>{-5s}:<line>{-4s}<colorDefault>  <levelColor><level>{-4s} <colorDefault> <message>"

source "libraries.d/core"
include tui coproc

log::info "Starting"

bash::sleep 1
log::info "next 1"
bash::sleep 1
log::info "next 2"
bash::sleep 1
log::info "next 3"
bash::sleep 1
log::info "next 4"
bash::sleep 1
log::info "next 5"
bash::sleep 1
log::info "next 6"
bash::sleep 1
log::info "next 7"
bash::sleep 1
log::info "next 8"
bash::sleep 1
log::info "next 9"
bash::sleep 1
log::info "next 10"

log::info "Ending"

# tui::test
