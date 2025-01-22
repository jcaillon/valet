#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-extension2
source extension2

function test_extension2::doNothing() {
  test::title "✅ Testing extension2::doNothing"

  test::exec extension2::doNothing
}

function main() {
  test_extension2::doNothing
}

main
