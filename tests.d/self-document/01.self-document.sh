#!/usr/bin/env bash

command::sourceFunction "selfDocument"

# shellcheck disable=SC1091
source io

function main() {
  test::title "✅ Testing self document command"

  io::createTempDirectory
  TEST_DIRECTORY="${RETURNED_VALUE}"

  test::exec selfDocument --output "\"\${TEST_DIRECTORY}\"" --core-only
  test::exec io::head "${TEST_DIRECTORY}/lib-valet.md" 10
  test::exec io::head "${TEST_DIRECTORY}/lib-valet" 10
  test::exec io::head "${TEST_DIRECTORY}/valet.code-snippets" 10
}

function core::getVersion() {
  RETURNED_VALUE="1.2.3"
}

main
