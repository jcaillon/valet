#!/usr/bin/env bash

core::sourceFunction "selfExport"
# shellcheck disable=SC1091
source io

function testSelfExport() {
  echo "→ valet self export"
  bash -c 'eval "$("'"${GLOBAL_VALET_HOME}"'/valet" self export)"'
  test::endTest "Testing self export" 0

  echo "→ valet self export -a"
  bash -c 'eval "$("'"${GLOBAL_VALET_HOME}"'/valet" self export -a)"'
  test::endTest "Testing self export with library functions only" 0
}

function main() {
  testSelfExport
}

main