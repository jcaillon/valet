#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-tui
source tui

# shellcheck disable=SC2034
function main() {
  :;
  test
}

function test() {
  echo "ok"
  test::flush
  test::exec false
}

main
