#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-regex
source regex

function main() {
  test_regex::replace
  test_regex::getFirstGroup
}

function test_regex::replace() {
  test::title "✅ Testing regex::replace function"

  local _MY_STRING='---
- name: marc
  city: paris
- name:   john
  city: london
- name:julien
  city: lyon
'
  test::printVars _MY_STRING
  test::func regex::replace _MY_STRING "'name:[[:space:]]*([[:alnum:]]*)'" "\c=\1 " 2 true
  test::func regex::replace _MY_STRING "'- name:[[:space:]]*([[:alnum:]]*)[^-]+'" "\c=\1 "

  _MY_STRING="This is the year 2000, madness rules the world."

  test::printVars _MY_STRING
  test::func regex::replace _MY_STRING "'[0-9]{4}'" "2025"
  test::func regex::replace _MY_STRING "'^(This) .*$'" "\1 is working."
}

function test_regex::getFirstGroup() {
  test::title "✅ Testing regex::getFirstGroup function"

  test::func MY_STRING='name: julien' regex::getFirstGroup MY_STRING "'name:[[:space:]]*([[:alnum:]]*)'"
}

main