#!/usr/bin/env bash

function main() {

  test::title "✅ Testing exit cleanup"
  test::exec main::parseMainArguments self mock1 create-temp-files
  log::setLevel info true

  test::title "✅ Testing the bad config"
  core::getConfigurationDirectory
  echo "fu=\$((1/0))" >"${RETURNED_VALUE}/config"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1
  rm -f "${RETURNED_VALUE}/config"

  test::title "✅ Testing the bad .env"
  echo "fu=\$((1/0))" >".env"
  export VALET_CONFIG_DOT_ENV_SCRIPT=".env"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1
  rm -f ".env"

  test::title "✅ Testing the bad commands"
  fs::createTempDirectory
  export VALET_CONFIG_USER_DATA_DIRECTORY="${RETURNED_VALUE}"
  echo "fu=\$((1/0))" >"${VALET_CONFIG_USER_DATA_DIRECTORY}/commands"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1
  rm -f "${VALET_CONFIG_USER_DATA_DIRECTORY}/commands"

  test::title "✅ Testing empty user directory rebuilding the commands"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1
}

main
