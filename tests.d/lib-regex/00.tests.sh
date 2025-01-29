#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-regex
source regex

function main() {
  test_regex::getFirstGroup
}

function test_regex::getFirstGroup() {
  test::title "✅ Testing regex::getFirstGroup function"

  test::func regex::getFirstGroup 'name: julien' "'name:[[:space:]]*([[:alnum:]]*)'"
}

main