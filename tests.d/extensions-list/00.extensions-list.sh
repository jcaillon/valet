#!/usr/bin/env bash

command::sourceFunction extensionsList

function main() {
  # override git for the tests
  local testDirectory="${PWD}"
  chmod +x "${testDirectory}/git"
  export PATH="${testDirectory}:${PATH}"

  export VALET_CONFIG_EXTENSIONS_DIRECTORY="${testDirectory}/extensions"

  mkdir -p "${testDirectory}/extensions/first/.git" "${testDirectory}/extensions/second/.git" "${testDirectory}/extensions/third/.git"
  echo "1.2.3" >"${testDirectory}/extensions/first/.git/.valet-setup-executed"
  echo "abcdefg" >"${testDirectory}/extensions/second/.git/.valet-setup-executed"
  echo "hello" >"${testDirectory}/extensions/third/.git/.valet-setup-executed"

  test::title "✅ Testing extensions list"
  test::exec extensionsList

  rm -rf "${testDirectory}/extensions/first/.git" "${testDirectory}/extensions/second/.git" "${testDirectory}/extensions/third/.git"
}

main
