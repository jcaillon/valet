#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-tui
source tui

# shellcheck disable=SC2034
function main() {
  :;
  # test
  test_bash::runInSubshell

  # test::fail "This test should fail."
  # ((0/0))
  # exit 2
  # test::exec exit 2
}

function test() {
  echo "ok"
  test::flush
  test::exec test2
}

function test2() {
  return 2
}

function test_bash::runInSubshell() {
  test::title "✅ Testing bash::runInSubshell"

  test::func bash::getBuiltinOutput false

}

main
