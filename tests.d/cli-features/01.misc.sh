#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-command
source command

function main() {
  test::title "✅ Testing exit cleanup"
  test::exec command::parseProgramArguments self mock1 create-temp-files
  log::setLevel info true

  test::title "✅ Testing the bad config"
  core::getConfigurationDirectory
  echo "fu=\$((1/0))" >"${REPLY}/config"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1
  rm -f "${REPLY}/config"

  test::title "✅ Testing the bad startup"
  core::getConfigurationDirectory
  echo "fu=\$((1/0))" >"${REPLY}/startup"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1
  rm -f "${REPLY}/startup"

  test::title "✅ Testing the bad .env"
  echo "zeoifuhizefuhzeh" >".env"
  export VALET_CONFIG_DOT_ENV_SCRIPT=".env"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1
  rm -f ".env"

  test::title "✅ Testing the bad commands"
  fs::createTempDirectory
  export VALET_CONFIG_USER_DATA_DIRECTORY="${REPLY}"
  echo "fu=\$((1/0))" >"${VALET_CONFIG_USER_DATA_DIRECTORY}/commands"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1
  rm -f "${VALET_CONFIG_USER_DATA_DIRECTORY}/commands"

  test::title "✅ Testing empty user directory rebuilding the commands"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" self mock1
}

# shellcheck disable=SC2317
function test::scrubOutput() {
  local line text=""
  local IFS=$'\n'
  for line in ${GLOBAL_TEST_OUTPUT_CONTENT}; do
    line="${line//core:[0-9]*/core:xxx}"
    line="${line//lib-command:[0-9]*/lib-command:xxx}"
    text+="${line//main:[0-9]*/main:xxx}"$'\n'
  done
  GLOBAL_TEST_OUTPUT_CONTENT="${text%$'\n'}"
}

main
