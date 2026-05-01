#!/usr/bin/env bash

function main() {
  test::title "✅ Testing that assert of tests calls core::fail"
  unset -f test::fail

  # shellcheck source=../../libraries.d/lib-assert
  source assert

  test::func assert::equals "expected" "actual"

  function test::fail() {
    log::info "test::fail called with message: ${*}"
  }

  test::func assert::equals "expected" "actual"

  test::title "✅ Testing functions of assert library"

  test::func assert::equals "=" "="
  test_assert::isPath
}

function test_assert::isPath() {
  fs::createTempDirectory
  local tempDirectory="${REPLY}"
  : >"${tempDirectory}/file1"
  ln -s "${tempDirectory}/file1" "${tempDirectory}/link-to-file1"

  test::func assert::isLink "${tempDirectory}"
  test::func assert::isLink "${tempDirectory}/file1"
  test::func assert::isLink "${tempDirectory}/link-to-file1"
  test::func assert::isFile "${tempDirectory}"
  test::func assert::isFile "${tempDirectory}/file1"
  test::func assert::isFile "${tempDirectory}/link-to-file1"
  test::func assert::isDirectory "${tempDirectory}"
  test::func assert::isDirectory "${tempDirectory}/file1"
  test::func assert::isDirectory "${tempDirectory}/link-to-file1"
  test::func assert::isPath "${tempDirectory}"
  test::func assert::isPath "${tempDirectory}/file1"
  test::func assert::isPath "${tempDirectory}/link-to-file1"
}

function core::fail() {
  log::info "core::fail called with message: ${*}"
}

main
