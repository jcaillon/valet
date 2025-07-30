#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:pid>{04s}:<subshell>{1s}](<pid>{05d}) <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"
export VALET_LOG_LEVEL="debug"

# shellcheck disable=SC1090
source "$(valet --source)"
include benchmark progress coproc bash

#################################


function realisticLoop() {
  _LOOP_NUMBER=$(( ${_LOOP_NUMBER:-0} + 1 ))
  if (( _LOOP_NUMBER > 2 )); then
    printf "%s\0" "stop"
    return 0
  fi
  log::info "Running loop command in coproc (${coprocVarName}), loop number: ${_LOOP_NUMBER}."
  printf "%s\0" "continue ${_LOOP_NUMBER}"
}

function realisticOnMessage() {
  log::info "Received message in coproc (${coprocVarName}): ${REPLY}"
  if [[ ${REPLY} == "stop" ]]; then
    log::info "Stopping the coproc (${coprocVarName})."
    exit 0
  fi
  return 0
}

_OPTION_LOOP_COMMAND=realisticLoop _OPTION_ON_MESSAGE_COMMAND=realisticOnMessage coproc::run _COPROC_9

declare -i messageSent=0
while coproc::receiveMessage _COPROC_9 && [[ ${REPLY} != "stop" ]]; do
  printf "%s\0%s\0" "decoy" "message ${messageSent}" >&"${_COPROC_9[1]}"
  messageSent+=1
done
coproc::sendMessage _COPROC_9 "stop"

coproc::wait _COPROC_9
