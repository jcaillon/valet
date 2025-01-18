#!/usr/bin/env bash

function main() {
  testEventHandlers
}

function testEventHandlers() {
  test::title "✅ Testing error handling (a statement returns != 0)"
  test::exec "${GLOBAL_VALET_HOME}/valet" self mock1 error


  test::title "✅ Testing exit code (exit 5) and custom exit function"
  test::exec "${GLOBAL_VALET_HOME}/valet" self mock1 exit

  test::title "✅ Testing the core::fail function"
  test::exec "${GLOBAL_VALET_HOME}/valet" self mock1 fail

  test::title "✅ Testing the core::failWithCode function"
  test::exec "${GLOBAL_VALET_HOME}/valet" self mock1 fail2

  test::title "✅ Testing the unknown command handler"
  test::exec "${GLOBAL_VALET_HOME}/valet" self mock1 unknown-command

  # test::title "✅ Testing the kill signal handler"
  # echo "valet self mock1 wait-indefinitely &"
  # echo "kill \$!"
  # test::flushStdout "**Prompt**"
  # "${GLOBAL_VALET_HOME}/valet" self mock1 wait-indefinitely &
  # local processId=$!
  # kill -TERM ${processId}
  # wait ${processId} || :
  # test::flush
}

main
