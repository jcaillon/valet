#!/usr/bin/env bash

function main() {

  test::title "✅ Testing exit cleanup"
  test::exec main::parseMainArguments self mock1 create-temp-files


  test::title "✅ Testing empty user directory rebuilding the commands"
  # testing with a non existing user directory
  fs::createTempDirectory
  export VALET_USER_DIRECTORY="${RETURNED_VALUE}/non-existing"
  test::exec VALET_LOG_LEVEL=warning "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1 logging-level

  log::setLevel info true
}

main
