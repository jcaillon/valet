#!/usr/bin/env bash

command::sourceFunction "selfUninstall"
# shellcheck disable=SC1091
source exe


function main() {
  test::title "✅ Testing self uninstall command"

  test::exec selfUninstall

  test::exec exe::invoke selfUninstall --script
  if [[ ${RETURNED_VALUE} == *"Valet has been uninstalled."* ]]; then
    test::markdown "The uninstallation script contains 'Valet has been uninstalled'."
  fi
}

main
