#!/usr/bin/env bash

include coproc array bash

function main() {
  test_coproc::run_simpleTests
  test_coproc::run_completeTest
  keepOnlyLastMessage=true test_coproc::run_completeTest
  test_coproc::run_testError
}

function test_coproc::run_simpleTests() {

  # shellcheck disable=SC2317
  function initCommand() {
    log::info "Running init command in coproc (${coprocVarName})."
  }

  # shellcheck disable=SC2317
  function loopCommand() {
    log::info "Running loop command in coproc (${coprocVarName})."
  }

  # shellcheck disable=SC2317
  function onMessageCommand() {
    log::info "Received message in coproc (${coprocVarName}): ${REPLY}"
  }

  # shellcheck disable=SC2317
  function endCommand() {
    log::info "Running end command in coproc (${coprocVarName})."
  }


  test::title "✅ Testing coproc::run with a simple init command"

  test::prompt coproc::run _COPROC_1 initCommand=initCommand
  test::prompt coproc::wait _COPROC_1
  coproc::run _COPROC_1 initCommand=initCommand
  local coproc1Pid="${REPLY}"
  if (( coproc1Pid <= 0 )); then
    test::fail "The coproc ⌜_COPROC_1⌝ is not running."
  fi
  coproc::wait _COPROC_1
  test::flush


  test::title "✅ Testing coproc::sendMessage, coproc::isRunning and coproc::wait"

  test::prompt coproc::run _COPROC_2 initCommand=initCommand loopCommand=loopCommand onMessageCommand="onMessageCommand;break" endCommand=endCommand
  test::prompt coproc::isRunning _COPROC_2
  test::prompt coproc::sendMessage _COPROC_2 "Hello, coproc 2!"
  test::prompt coproc::wait _COPROC_2
  test::prompt coproc::isRunning _COPROC_2
  coproc::run _COPROC_2 initCommand=initCommand loopCommand=loopCommand onMessageCommand="onMessageCommand;break" endCommand=endCommand
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

  test::prompt coproc::run _COPROC_3 initCommand=initCommand waitForReadiness=true
  test::prompt coproc::wait _COPROC_3
  coproc::run _COPROC_3 initCommand=initCommand waitForReadiness=true
  coproc::wait _COPROC_3
  test::flush


  test::title "✅ Testing coproc::kill"

  # shellcheck disable=SC2317
  function loopCommand() {
    bash::sleep 0
  }

  test::prompt coproc::run _COPROC_4 initCommand=initCommand loopCommand=loopCommand waitForReadiness=true
  test::prompt coproc::kill _COPROC_4
  coproc::run _COPROC_4 initCommand=initCommand loopCommand=loopCommand waitForReadiness=true
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
  if [[ ${keepOnlyLastMessage:-} == "true" ]]; then
    test::title "✅ Testing coproc::run with a realistic usage and keeping only the last message"
  else
    test::title "✅ Testing coproc::run with a realistic usage"
  fi

  # shellcheck disable=SC2317
  function realisticLoop() {
    _LOOP_NUMBER=$(( ${_LOOP_NUMBER:-0} + 1 ))
    if (( _LOOP_NUMBER > 2 )); then
      printf "%s\0" "stop"
      return 0
    fi
    log::info "Running loop command in coproc (${coprocVarName}), loop number: ${_LOOP_NUMBER}."
    printf "%s\0" "continue ${_LOOP_NUMBER}"
  }

  # shellcheck disable=SC2317
  function realisticOnMessage() {
    log::info "Received message in coproc (${coprocVarName}): ${REPLY}"
    if [[ ${REPLY} == "stop" ]]; then
      log::info "Stopping the coproc (${coprocVarName})."
      exit 0
    fi
    return 0
  }

  test::prompt coproc::run _COPROC_9 loopCommand=realisticLoop onMessageCommand=realisticOnMessage
  coproc::run _COPROC_9 loopCommand=realisticLoop onMessageCommand=realisticOnMessage

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

  bash::injectCodeInFunction trap::onSubshellExitInternal 'log::warning "Subshell exited with code $1"'
  eval "${REPLY}"
  local originalFunction="${REPLY2}"

  function initCommand() {
    ((0/0)) # This will fail and exit the subshell
    log::info "This line will not be executed because the previous command failed."
  }

  test::setTestCallStack
  test::prompt coproc::run _COPROC_20 initCommand=initCommand
  coproc::run _COPROC_20 initCommand=initCommand
  test::unsetTestCallStack

  if coproc::wait _COPROC_20; then
    test::fail "The coproc ⌜_COPROC_20⌝ should have failed."
  else
    log::info "The coproc ⌜_COPROC_20⌝ failed as expected."
  fi
  test::flush

  eval "${originalFunction}"
}

main