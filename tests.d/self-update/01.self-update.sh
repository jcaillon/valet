#!/usr/bin/env bash

command::sourceFunction "selfUpdate"

function main() {
  test::title "✅ Testing self update command"

  # shellcheck disable=SC2034
  GLOBAL_INSTALLATION_DIRECTORY="${PWD}"

  function core::getVersion() {
    REPLY="2.2.3"
  }

  test::markdown "Already updated"
  test::exec selfUpdate --unattended

  function core::getVersion() {
    REPLY="0.2.3"
  }

  test::markdown "Cancel update"
  test::setTerminalInputs n
  test::exec selfUpdate

  test::markdown "Do update"
  test::setTerminalInputs y
  test::exec selfUpdate

  test::markdown "Unattended update"
  test::exec selfUpdate --unattended

  GLOBAL_INSTALLATION_DIRECTORY="${PWD}/resources"
  mkdir -p "${GLOBAL_INSTALLATION_DIRECTORY}/.git"

  test::markdown "Should fail because we are in a git repository"
  test::exit selfUpdate
}

# shellcheck disable=SC2034
function curl::request() {
  echo "🙈 mocked curl::request ${*}" 1>&2
  REPLY_CODE=0
  REPLY='{ "upload_url": "https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets{?name,label}", "tag_name": "v1.2.3", "browser_download_url": "https:///fake" }'
  REPLY2=""
  REPLY3=200
}

# shellcheck disable=SC2034
function curl::download() {
  echo "🙈 mocked curl::download ${*}" 1>&2
  echo "echo 'This is a fake install script for testing purposes.' >&2" >"${GLOBAL_TEST_TEMP_FILE}"
  REPLY_CODE=0
  REPLY="${GLOBAL_TEST_TEMP_FILE}"
  REPLY2=""
  REPLY3=200
}

main
