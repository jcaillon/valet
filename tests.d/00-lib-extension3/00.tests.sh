#!/usr/bin/env bash

# shellcheck source=../../libs.d/lib-extension3
source extension3

function test_extension3::doNothing() {
  test::endTest "Testing extension3::doNothing" 0
}

function main() {
  test_extension3::doNothing
}

main
