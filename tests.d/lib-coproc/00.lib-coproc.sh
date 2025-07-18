#!/usr/bin/env bash

include coproc array

function main() {
  simpleTests
  completeTest
  _OPTION_KEEP_ONLY_LAST_MESSAGE=true completeTest
}

# shellcheck disable=SC2034
function simpleTests() {
  test::title "✅ Testing coproc::run"

  function initCommand() {
    log::info "Running init command in coproc (${coprocVarName})."
  }

  function loopCommand() {
    log::info "Running loop command in coproc (${coprocVarName})."
  }

  function onMessageCommand() {
    log::info "Received message in coproc (${coprocVarName}): ${RETURNED_VALUE}"
    return 1
  }

  function endCommand() {
    log::info "Running end command in coproc (${coprocVarName})."
  }

  test::prompt coproc::run _COPROC_1 initCommand false willNotBeUsed ":"
  test::prompt coproc::wait _COPROC_1
  coproc::run _COPROC_1 initCommand false willNotBeUsed ":"
  local coproc1Pid="${RETURNED_VALUE}"
  coproc::wait _COPROC_1
  test::flush

  test::prompt coproc::run _COPROC_2 initCommand loopCommand onMessageCommand endCommand
  test::prompt coproc::isRunning _COPROC_2
  test::prompt coproc::sendMessage _COPROC_2 "Hello, coproc 2!"
  test::prompt coproc::wait _COPROC_2
  test::prompt coproc::isRunning _COPROC_2
  coproc::run _COPROC_2 initCommand loopCommand onMessageCommand endCommand
  local coproc2Pid="${RETURNED_VALUE}"
  if ! coproc::isRunning _COPROC_2; then
    test::fail "The coproc ⌜_COPROC_2⌝ is not running."
  fi
  coproc::sendMessage _COPROC_2 "Hello, coproc 2!"
  coproc::wait _COPROC_2
  if coproc::isRunning _COPROC_2; then
    test::fail "The coproc ⌜_COPROC_2⌝ is still running."
  fi
  test::flush

  test::prompt _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_3 initCommand false false true
  test::prompt coproc::wait _COPROC_3
  _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_3 initCommand false false true
  local coproc3Pid="${RETURNED_VALUE}"
  coproc::wait _COPROC_3
  test::flush

  if ! array::contains GLOBAL_BACKGROUND_PIDS coproc1Pid \
    || ! array::contains GLOBAL_BACKGROUND_PIDS coproc2Pid \
    || ! array::contains GLOBAL_BACKGROUND_PIDS coproc3Pid; then
    test::fail "The coproc PIDs are not in the GLOBAL_BACKGROUND_PIDS array."
  fi
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
    log::info "Received message in coproc (${coprocVarName}): ${RETURNED_VALUE}"
    if [[ ${RETURNED_VALUE} == "stop" ]]; then
      log::info "Stopping the coproc (${coprocVarName})."
      return 1
    fi
    return 0
  }

  test::prompt coproc::run _COPROC_4 : realisticLoop realisticOnMessage :
  coproc::run _COPROC_4 : realisticLoop realisticOnMessage :

  local -i messageSent=0
  while coproc::receiveMessage _COPROC_4 && [[ ${RETURNED_VALUE} != "stop" ]]; do
    log::info "Received message from coproc: ${RETURNED_VALUE}"
    printf "%s\0%s\0" "decoy" "message ${messageSent}" >&"${_COPROC_4[1]}"
    messageSent+=1
  done
  coproc::sendMessage _COPROC_4 "stop"

  coproc::wait _COPROC_4
  test::flush
}

main