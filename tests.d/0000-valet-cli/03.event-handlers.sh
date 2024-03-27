#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".common-utils"
fi

function testEventHandlers() {
  # testing error handling (a statement returns != 0)
  "${VALET_HOME}/valet" self test-core --error 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endTest "Testing error handling" $?

  # testing exit code (exit 5) and custom exit function
  "${VALET_HOME}/valet" self test-core --exit
  endTest "Testing exit message and custom onExit function" $?

  # testing the fail function
  "${VALET_HOME}/valet" self test-core --fail
  endTest "Testing fail function" $?

  # testing the unknown command handler
  "${VALET_HOME}/valet" self test-core --unknown-command 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endTest "Testing unknown command handling" $?

  # testing kill
  # "${VALET_HOME}/valet" self test-core --wait-indefinitely &
  # processId=$!
  # kill -TERM ${processId}
  # wait ${processId} || true
  # endTest "Testing kill" $?
}

function main() {
  testEventHandlers
}

main

source ".cleanup"