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

  test::title "✅ Testing the bad startup"
  core::getConfigurationDirectory
  echo "fu=\$((1/0))" >"${RETURNED_VALUE}/startup"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1
  rm -f "${RETURNED_VALUE}/startup"

  test::title "✅ Testing the bad .env"
  echo "zeoifuhizefuhzeh" >".env"
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

# shellcheck disable=SC2317
function test::transformTextBeforeFlushing() {
  local line text=""
  local IFS=$'\n'
  for line in ${_TEST_OUTPUT}; do
    line="${line//core:[0-9]*/core:xxx}"
    text+="${line//main:[0-9]*/main:xxx}"$'\n'
  done
  _TEST_OUTPUT="${text%$'\n'}"
}

main
