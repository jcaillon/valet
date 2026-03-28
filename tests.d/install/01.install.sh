#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-fs
source fs

# cancel the test suite if not running on windows
if ! command -v docker &>/dev/null; then
  test::skipTestSuite "This test suite is only runnable on systems with Docker installed, skipping it."
fi

function main() {
  :
}

main
