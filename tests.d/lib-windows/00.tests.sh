#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-windows
source windows

function main() {
  test_windows::convertPathFromUnix
  test_windows::convertPathToUnix
  test_windows::setEnvVar
  test_windows::getEnvVar
  test_windows::addToPath
  test_windows::createLink
}

function test_windows::convertPathFromUnix() {
  test::title "✅ Testing windows::convertPathFromUnix"

  test::func windows::convertPathFromUnix '/tmp/file'
  test::func windows::convertPathFromUnix '/mnt/d/Users/username'
  test::func windows::convertPathFromUnix '/c/data/file'
}

function test_windows::convertPathToUnix() {
  test::title "✅ Testing windows::convertPathToUnix"

  # shellcheck disable=SC2317
  function test::transformTextBeforeFlushing() { _TEST_OUTPUT="${_TEST_OUTPUT//\/mnt}"; }
  test::func windows::convertPathToUnix 'C:\Users\username'
  test::func windows::convertPathToUnix 'D:\data\file'
  unset -f test::transformTextBeforeFlushing
}

function test_windows::setEnvVar() {
  test::title "✅ Testing windows::setEnvVar"

  test::exec OSTYPE=msys windows::setEnvVar VAR VALUE
  test::exec OSTYPE=msys windows::setEnvVar VAR ''
}

function test_windows::getEnvVar() {
  test::title "✅ Testing windows::getEnvVar"

  test::exec OSTYPE=msys windows::getEnvVar VAR
}

function test_windows::addToPath() {
  test::title "✅ Testing windows::addToPath"

  test::exec OSTYPE=msys windows::addToPath /coucou
}

function test_windows::createLink() {
  test::title "✅ Testing windows::createLink"

  mkdir -p resources/gitignored
  :> resources/gitignored/file

  test::exec windows::createLink 'resources/gitignored/file' 'resources/gitignored/try/file2' true
  test::flush

  test::exec windows::createLink 'resources/gitignored/try' 'resources/gitignored/new'
  test::flush
}

function powershell() {
  echo "🙈 mocking powershell: $*";
}

main