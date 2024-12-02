#!/usr/bin/env bash

# shellcheck source=../../libs.d/lib-extension2
source extension2

function test_extension2::doNothing() {
  test::endTest "Testing extension2::doNothing" 0
}

function main() {
  test_extension2::doNothing
}

main
