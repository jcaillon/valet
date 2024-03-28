#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".before-test"
fi

function testEventHandlers() {
  # testing error handling (a statement returns != 0)
  echo "→ valet self test-core --error"
  "${VALET_HOME}/valet" self test-core --error 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithLineNumberSubstitution 1>&2
  endTest "Testing error handling" $?

  # testing exit code (exit 5) and custom exit function
  echo "→ valet self test-core --exit"
  "${VALET_HOME}/valet" self test-core --exit
  endTest "Testing exit message and custom onExit function" $?

  # testing the fail function
  echo "→ valet self test-core --fail"
  "${VALET_HOME}/valet" self test-core --fail
  endTest "Testing fail function" $?

  # testing the unknown command handler
  echo "→ valet self test-core --unknown-command"
  "${VALET_HOME}/valet" self test-core --unknown-command 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithLineNumberSubstitution 1>&2
  endTest "Testing unknown command handling" $?

  # testing kill
  # ("${VALET_HOME}/valet" self test-core --wait-indefinitely &)
  # processId=$!
  # kill -TERM ${processId}
  # wait ${processId} || true
  # endTest "Testing kill" $?
}

function main() {
  testEventHandlers
}

main

source ".after-test"