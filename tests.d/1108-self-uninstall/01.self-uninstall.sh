#!/usr/bin/env bash

core::sourceFunction "selfUninstall"
# shellcheck disable=SC1091
source io

function testSelfUninstall() {
  echo "→ selfUninstall"
  selfUninstall

  echo
  echo "→ selfUninstall --script"
  selfUninstall --script

  test::endTest "Testing selfUninstall" 0
}


function main() {
  testSelfUninstall
}

main
