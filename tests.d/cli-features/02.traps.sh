#!/usr/bin/env bash

function main() {
  test_traps
}

function test_traps() {
  test::title "✅ Testing error handling (a statement returns != 0)"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1 error

  test::title "✅ Testing exit code (exit 5) and custom exit function"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1 exit

  test::title "✅ Testing the core::fail function"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1 fail

  test::title "✅ Testing the core::fail function with an error code"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1 fail2

  test::title "✅ Testing the unknown command handler"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1 unknown-command

  test::title "✅ Testing custom exit function and ok"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1 ok

  test_trappedSignals "term"
  test_trappedSignals "hup" --cancel

  test_trappedSignals "tstp"
  test_trappedSignals "tstp" --cancel
  test_trappedSignals "cont"

  # can't test winch/interrupt because they are not sent to background processes
}

function test_trappedSignals() {
  local signal="${1}"
  shift 1
  test::title "✅ Testing the ${signal} signal handler"

  test::prompt "valet self mock4 &"
  test::prompt "kill -${signal^^} \$!"

  rm -f "${GLOBAL_TEST_TEMP_FILE}"
  "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock4 "${GLOBAL_TEST_TEMP_FILE}" "${@}" &
  local processId=$!
  while [[ ! -f "${GLOBAL_TEST_TEMP_FILE}" ]]; do
    bash::sleep 0.01
  done
  rm -f "${GLOBAL_TEST_TEMP_FILE}"
  kill "-${signal^^}" "${processId}"
  while [[ ! -f "${GLOBAL_TEST_TEMP_FILE}" ]]; do
    bash::sleep 0.01
  done
  kill -KILL "${processId}" &>/dev/null || :
  wait -n ${processId} &>/dev/null || :
  test::flush
}

# shellcheck disable=SC2317
function scrubLineNumbers() {
  GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT//:[0-9][0-9][0-9]/":xxx"}"
  GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT//:[0-9][0-9]/":xxx"}"
  GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT//:[0-9]/":xxx"}"
}

test::addOutputScrubber scrubLineNumbers
main
test::clearOutputScrubbers
