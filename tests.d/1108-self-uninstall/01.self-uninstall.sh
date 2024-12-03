#!/usr/bin/env bash

core::sourceFunction "selfUninstall"
# shellcheck disable=SC1091
source io

function testSelfUninstall() {
  echo "→ selfUninstall"
  selfUninstall

  echo
  echo "→ selfUninstall --script"
  io::invoke selfUninstall --script
  if [[ ${RETURNED_VALUE} == *"Valet has been uninstalled."* ]]; then
    echo "ok"
  fi

  test::endTest "Testing selfUninstall" 0
}


function main() {
  testSelfUninstall
}

main
