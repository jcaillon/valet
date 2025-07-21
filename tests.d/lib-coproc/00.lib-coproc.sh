#!/usr/bin/env bash

include coproc array bash

function main() {
  simpleTests
  completeTest
  _OPTION_KEEP_ONLY_LAST_MESSAGE=true completeTest
}

# shellcheck disable=SC2034
function simpleTests() {

  function initCommand() {
    log::info "Running init command in coproc (${coprocVarName})."
  }

  function loopCommand() {
    log::info "Running loop command in coproc (${coprocVarName})."
  }

  function onMessageCommand() {
    log::info "Received message in coproc (${coprocVarName}): ${REPLY}"
    return 1
  }

  function endCommand() {
    log::info "Running end command in coproc (${coprocVarName})."
  }


  test::title "✅ Testing coproc::run with a simple init command"

  test::prompt coproc::run _COPROC_1 initCommand false willNotBeUsed ":"
  test::prompt coproc::wait _COPROC_1
  coproc::run _COPROC_1 initCommand false willNotBeUsed ":"
  local coproc1Pid="${REPLY}"
  if (( coproc1Pid <= 0 )); then
    test::fail "The coproc ⌜_COPROC_1⌝ is not running."
  fi
  coproc::wait _COPROC_1
  test::flush


  test::title "✅ Testing coproc::sendMessage, coproc::isRunning and coproc::wait"

  test::prompt coproc::run _COPROC_2 initCommand loopCommand onMessageCommand endCommand
  test::prompt coproc::isRunning _COPROC_2
  test::prompt coproc::sendMessage _COPROC_2 "Hello, coproc 2!"
  test::prompt coproc::wait _COPROC_2
  test::prompt coproc::isRunning _COPROC_2
  coproc::run _COPROC_2 initCommand loopCommand onMessageCommand endCommand
  local coproc2Pid="${REPLY}"
  if ! coproc::isRunning _COPROC_2; then
    test::fail "The coproc ⌜_COPROC_2⌝ is not running."
  fi
  coproc::sendMessage _COPROC_2 "Hello, coproc 2!"
  coproc::wait _COPROC_2
  if coproc::isRunning _COPROC_2; then
    test::fail "The coproc ⌜_COPROC_2⌝ is still running."
  fi
  test::flush


  test::title "✅ Testing coproc::run with wait for readiness"

  test::prompt _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_3 initCommand false false true
  test::prompt coproc::wait _COPROC_3
  _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_3 initCommand false false true
  local coproc3Pid="${REPLY}"
  coproc::wait _COPROC_3
  test::flush
  

  test::title "✅ Testing coproc::kill"

  function loopCommand() {
    bash::sleep 0
  }

  test::prompt _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_4 initCommand loopCommand : :
  test::prompt coproc::kill _COPROC_4
  _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_4 initCommand loopCommand : :
  local coproc4Pid="${REPLY}"
  local IFS=" "
  if [[ ${GLOBAL_BACKGROUND_PIDS[*]} != *"${coproc4Pid}"* ]]; then
    test::fail "The coproc ⌜_COPROC_4⌝ is not in the GLOBAL_BACKGROUND_PIDS array."
  fi
  coproc::kill _COPROC_4
  if [[ ${GLOBAL_BACKGROUND_PIDS[*]} == *"${coproc4Pid}"* ]]; then
    test::fail "The coproc ⌜_COPROC_4⌝ is still in the GLOBAL_BACKGROUND_PIDS array."
  fi
  test::flush
}


function completeTest() {
  if [[ ${_OPTION_KEEP_ONLY_LAST_MESSAGE:-} == "true" ]]; then
    test::title "✅ Testing coproc::run with a realistic usage and keeping only the last message"
  else
    test::title "✅ Testing coproc::run with a realistic usage"
  fi

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
      return 1
    fi
    return 0
  }

  test::prompt coproc::run _COPROC_9 : realisticLoop realisticOnMessage :
  coproc::run _COPROC_9 : realisticLoop realisticOnMessage :

  local -i messageSent=0
  while coproc::receiveMessage _COPROC_9 && [[ ${REPLY} != "stop" ]]; do
    printf "%s\0%s\0" "decoy" "message ${messageSent}" >&"${_COPROC_9[1]}"
    messageSent+=1
  done
  coproc::sendMessage _COPROC_9 "stop"

  coproc::wait _COPROC_9
  test::flush
}

main