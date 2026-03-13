#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-windows
source windows
# shellcheck source=../../libraries.d/lib-system
source system
# shellcheck source=../../libraries.d/lib-fs
source fs
# shellcheck source=../lib-fs/test-fs-link
source ../lib-fs/test-fs-link

# cancel the test suite if not running on windows
if ! system::isWindows || [[ ${MSYS:-} != "winsymlinks:nativestrict" ]]; then
  test::skipTestSuite "This test suite is only applicable on Windows with developer mode enabled, skipping it."
fi

function main() {
  # test_windows::setEnvVar
  # test_windows::getEnvVar
  # test_windows::addToPath

  # second test, use powershell to create links
  MSYS=""
  windows::startPs1Batch
  test_fs::Link
  MSYS="winsymlinks:nativestrict"
}

main
