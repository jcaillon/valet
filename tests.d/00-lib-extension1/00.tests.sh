#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-extension1
source extension1

function test_extension1::doNothing() {
  test::title "✅ Testing extension1::doNothing"

  test::exec extension1::doNothing
}

function main() {
  test_extension1::doNothing
}

main
