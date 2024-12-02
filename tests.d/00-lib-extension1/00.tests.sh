#!/usr/bin/env bash

# shellcheck source=../../libs.d/lib-extension1
source extension1

function test_extension1::doNothing() {
  test::endTest "Testing extension1::doNothing" 0
}

function main() {
  test_extension1::doNothing
}

main
