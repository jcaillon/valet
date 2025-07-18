#!/usr/bin/env bash

include coproc

function main() {
  test::title "✅ Testing coproc::run"

  test::exec coproc::run _COPROC_1 initCommand false ""
  test::exec coproc::wait _COPROC_1
  
  test::exec coproc::run _COPROC_2 initCommand loopCommand onMessageCommand
  test::prompt coproc::sendMessage _COPROC_2 "Hello, coproc 2!"
  coproc::sendMessage _COPROC_2 "Hello, coproc 2!"
  test::exec coproc::wait _COPROC_2
}

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

# main