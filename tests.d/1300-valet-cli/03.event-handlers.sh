#!/usr/bin/env bash

builtin source ".before-test"

function testEventHandlers() {
  # testing error handling (a statement returns != 0)
  echo "→ valet self mock1 error"
  ("${_VALET_HOME}/valet" self mock1 error 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithLineNumberSubstitution 1>&2
  endTest "Testing error handling" $?

  # testing exit code (exit 5) and custom exit function
  echo "→ valet self mock1 exit"
  ("${_VALET_HOME}/valet" self mock1 exit 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithLineNumberSubstitution 1>&2
  endTest "Testing exit message and custom onExit function" $?

  # testing the fail function
  echo "→ valet self mock1 fail"
  ("${_VALET_HOME}/valet" self mock1 fail)
  endTest "Testing fail function" $?

  # testing the unknown command handler
  echo "→ valet self mock1 unknown-command"
  ("${_VALET_HOME}/valet" self mock1 unknown-command 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithLineNumberSubstitution 1>&2
  endTest "Testing unknown command handling" $?

  # testing kill
  # ("${_VALET_HOME}/valet" self mock1 wait-indefinitely &)
  # processId=$!
  # kill -TERM ${processId}
  # wait ${processId} || true
  # endTest "Testing kill" $?
}

function main() {
  testEventHandlers
}

main

builtin source ".after-test"