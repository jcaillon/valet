#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-extension3
source extension3

function test_extension3::doNothing() {
  test::title "✅ Testing extension3::doNothing"

  test::exec extension3::doNothing
}

function main() {
  test_extension3::doNothing
}

main
