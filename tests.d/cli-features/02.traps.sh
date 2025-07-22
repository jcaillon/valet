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

  # test::title "✅ Testing the kill signal handler"
  # echo "valet self mock1 wait-indefinitely &"
  # echo "kill \$!"
  # test::flushStdout "**Prompt**"
  # "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1 wait-indefinitely &
  # local processId=$!
  # kill -9 ${processId}
  # wait -f ${processId} || :
  # test::flush
}

# shellcheck disable=SC2317
function test::scrubOutput() {
  local line text=""
  local IFS=$'\n'
  for line in ${GLOBAL_TEST_OUTPUT_CONTENT}; do
    line="${line//core:[0-9]*/core:xxx}"
    text+="${line//main:[0-9]*/main:xxx}"$'\n'
  done
  GLOBAL_TEST_OUTPUT_CONTENT="${text%$'\n'}"
}

main
