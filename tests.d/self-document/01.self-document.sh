#!/usr/bin/env bash

command::sourceFunction "selfDocument"

# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test::title "✅ Testing self document command"

  fs::createTempDirectory
  TEST_DIRECTORY="${RETURNED_VALUE}"

  test::exec selfDocument --output "\"\${TEST_DIRECTORY}\"" --core-only
  test::exec fs::head "${TEST_DIRECTORY}/lib-valet.md" 10
  test::exec fs::head "${TEST_DIRECTORY}/lib-valet" 10
  test::exec fs::head "${TEST_DIRECTORY}/valet.code-snippets" 10
}

function core::getVersion() {
  RETURNED_VALUE="1.2.3"
}

main
