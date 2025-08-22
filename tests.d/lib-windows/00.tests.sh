#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-windows
source windows

function main() {
  USERNAME="user"
  LOCALAPPDATA="tmp"

  test_windows::getWindowsPathFromUnixPath
  test_windows::getUnixPathFromWindowsPath
  test_windows::setEnvVar
  test_windows::getEnvVar
  test_windows::addToPath
  test_windows::createLink

  rm -Rf tmp
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
  function test::scrubOutput() { GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT//\/mnt}"; }
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

function test_windows::createLink() {
  test::title "✅ Testing windows::createLink"

  mkdir -p resources/gitignored
  :> resources/gitignored/file

  MSYS="winsymlinks:nativestrict"
  test::exec windows::createLink 'resources/gitignored/file' 'resources/gitignored/try/file2' hardlink=true
  test::flush

  MSYS=""
  test::exec windows::createLink 'resources/gitignored/file' 'resources/gitignored/try/file2' hardlink=true
  test::flush

  test::exec windows::createLink 'resources/gitignored/try' 'resources/gitignored/new'
  test::flush
}

function powershell() {
  local text="🙈 mocking powershell: $*"
  text="${text//"-FilePath "*"-Encoding utf8;"/"-FilePath 'tmp' -Encoding utf8;"}"
  text="${text//"\"-File\","*") -Wait"/"\"-File\",'tmp') -Wait"}"
  echo "${text}";
}

function fs::createLink() {
  echo "🙈 mocking fs::createLink: $*"
}

# override cygpath for the test to work on linux as well
function cygpath() {
  echo 'C:\Users\TEMP\'"${2##*/}";
}

main