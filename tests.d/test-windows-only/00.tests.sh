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

  # first test, use "normal" ln command
  MSYS="winsymlinks:nativestrict"
  test_fs::Link
}

function test_windows::getWindowsPathFromUnixPath() {
  test::title "✅ Testing windows::getWindowsPathFromUnixPath"

  test::func windows::getWindowsPathFromUnixPath '/tmp/file'
  test::func windows::getWindowsPathFromUnixPath '/mnt/d/Users/username'
  test::func windows::getWindowsPathFromUnixPath '/c/data/file'
  test::func windows::getWindowsPathFromUnixPath 'C:\Users\username'
}

function test_windows::getUnixPathFromWindowsPath() {
  test::title "✅ Testing windows::getUnixPathFromWindowsPath"

  # shellcheck disable=SC2317
  function test::scrubOutput() { GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT//\/mnt/}"; }
  test::func windows::getUnixPathFromWindowsPath 'C:\Users\username'
  test::func windows::getUnixPathFromWindowsPath 'D:\data\file'
  test::func windows::getUnixPathFromWindowsPath '/c/Users/username'
  unset -f test::scrubOutput
}

function test_windows::setEnvVar() {
  test::title "✅ Testing windows::setEnvVar"

  test::exec windows::setEnvVar VAR VALUE
  test::exec windows::setEnvVar VAR ''
}

function test_windows::getEnvVar() {
  test::title "✅ Testing windows::getEnvVar"

  test::exec windows::getEnvVar VAR
}

function test_windows::addToPath() {
  test::title "✅ Testing windows::addToPath"

  test::exec windows::addToPath /coucou

  test::exec windows::addToPath /coucou prepend=true
}

main
