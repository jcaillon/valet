#!/usr/bin/env bash

command::sourceFunction "selfDocument"

# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test::title "✅ Testing self document command"

  fs::createTempDirectory
  TEST_DIRECTORY="${REPLY}"

  # shellcheck disable=SC2317
  function test::scrubOutput() {
    GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT// [0-9][0-9][0-9] functions/ xxx functions}"
  }

  test::exec selfDocument --output "\"\${TEST_DIRECTORY}\"" --core-only

  unset -f test::scrubOutput

  test::exec fs::head "${TEST_DIRECTORY}/lib-valet.md" 10
  test::exec fs::head "${TEST_DIRECTORY}/lib-valet" 10
  test::exec fs::head "${TEST_DIRECTORY}/valet.code-snippets" 10
}

function core::getVersion() {
  REPLY="1.2.3"
}

main
