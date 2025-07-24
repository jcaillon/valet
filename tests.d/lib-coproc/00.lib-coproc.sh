#!/usr/bin/env bash

include coproc array bash

function main() {
  test_coproc::run_simpleTests
  test_coproc::run_completeTest
  _OPTION_KEEP_ONLY_LAST_MESSAGE=true test_coproc::run_completeTest
  test_coproc::run_testError
}

# shellcheck disable=SC2034
function test_coproc::run_simpleTests() {

  function initCommand() {
    log::info "Running init command in coproc (${coprocVarName})."
  }

  function loopCommand() {
    log::info "Running loop command in coproc (${coprocVarName})."
  }

  function onMessageCommand() {
    log::info "Received message in coproc (${coprocVarName}): ${REPLY}"
  }

  function endCommand() {
    log::info "Running end command in coproc (${coprocVarName})."
  }


  test::title "✅ Testing coproc::run with a simple init command"

  test::prompt _OPTION_INIT_COMMAND=initCommand coproc::run _COPROC_1
  test::prompt coproc::wait _COPROC_1
  _OPTION_INIT_COMMAND=initCommand coproc::run _COPROC_1 initCommand break willNotBeUsed ":"
  local coproc1Pid="${REPLY}"
  if (( coproc1Pid <= 0 )); then
    test::fail "The coproc ⌜_COPROC_1⌝ is not running."
  fi
  coproc::wait _COPROC_1
  test::flush


  test::title "✅ Testing coproc::sendMessage, coproc::isRunning and coproc::wait"

  test::prompt _OPTION_INIT_COMMAND=initCommand _OPTION_LOOP_COMMAND=loopCommand _OPTION_ON_MESSAGE_COMMAND="onMessageCommand;break" _OPTION_END_COMMAND=endCommand coproc::run _COPROC_2
  test::prompt coproc::isRunning _COPROC_2
  test::prompt coproc::sendMessage _COPROC_2 "Hello, coproc 2!"
  test::prompt coproc::wait _COPROC_2
  test::prompt coproc::isRunning _COPROC_2
  _OPTION_INIT_COMMAND=initCommand _OPTION_LOOP_COMMAND=loopCommand _OPTION_ON_MESSAGE_COMMAND="onMessageCommand;break" _OPTION_END_COMMAND=endCommand coproc::run _COPROC_2
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

  test::prompt _OPTION_INIT_COMMAND=initCommand _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_3
  test::prompt coproc::wait _COPROC_3
  _OPTION_INIT_COMMAND=initCommand _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_3
  local coproc3Pid="${REPLY}"
  coproc::wait _COPROC_3
  test::flush


  test::title "✅ Testing coproc::kill"

  function loopCommand() {
    bash::sleep 0
  }

  test::prompt _OPTION_INIT_COMMAND=initCommand _OPTION_LOOP_COMMAND=loopCommand _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_4
  test::prompt coproc::kill _COPROC_4
  _OPTION_INIT_COMMAND=initCommand _OPTION_LOOP_COMMAND=loopCommand _OPTION_WAIT_FOR_READINESS=true coproc::run _COPROC_4
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


function test_coproc::run_completeTest() {
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
      exit 0
    fi
    return 0
  }

  test::prompt _OPTION_LOOP_COMMAND=realisticLoop _OPTION_ON_MESSAGE_COMMAND=realisticOnMessage coproc::run _COPROC_9
  _OPTION_LOOP_COMMAND=realisticLoop _OPTION_ON_MESSAGE_COMMAND=realisticOnMessage coproc::run _COPROC_9

  local -i messageSent=0
  while coproc::receiveMessage _COPROC_9 && [[ ${REPLY} != "stop" ]]; do
    printf "%s\0%s\0" "decoy" "message ${messageSent}" >&"${_COPROC_9[1]}"
    messageSent+=1
  done
  coproc::sendMessage _COPROC_9 "stop"

  coproc::wait _COPROC_9
  test::flush
}

function test_coproc::run_testError() {
  test::title "✅ Testing coproc::run with an error in the init command"

  function onSubshellExit() {
    log::warning "Subshell exited with code $1"
  }

  function initCommand() {
  # re-enable errexit in the subshell
  set -o errexit

  # we are inside a coproc, register the correct traps
  trap::registerSubshell
    ((0/0)) # This will fail and exit the subshell
    log::info "This line will not be executed because the previous command failed."
  }

  test::setTestCallStack
  test::prompt _OPTION_INIT_COMMAND=initCommand coproc::run _COPROC_20
  _OPTION_INIT_COMMAND=initCommand coproc::run _COPROC_20
  test::unsetTestCallStack
  if coproc::wait _COPROC_20; then
    test::fail "The coproc ⌜_COPROC_20⌝ should have failed."
  else
    log::info "The coproc ⌜_COPROC_20⌝ failed as expected."
  fi
  test::flush
}

main