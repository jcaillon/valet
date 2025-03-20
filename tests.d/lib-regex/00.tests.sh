#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-regex
source regex

function main() {
  test_regex::escapeRegexSpecialChars
  test_regex::getFuzzySearchRegexFromSearchString
  test_regex::getMatches
  test_regex::replace
  test_regex::getFirstGroup
}

function test_regex::escapeRegexSpecialChars() {
  test::title "✅ Testing regex::escapeRegexSpecialChars function"

  local _string='\^$.|?*+[]{}()'
  test::func regex::escapeRegexSpecialChars "${_string}"
}

function test_regex::getFuzzySearchRegexFromSearchString() {
  test::title "✅ Testing regex::getFuzzySearchRegexFromSearchString function"

  local _string="the"
  test::exec regex::getFuzzySearchRegexFromSearchString _string
  test::printVars _string _STRING_FUZZY_FILTER_REGEX

  _string='\^$.|?*+[]{}()'
  test::exec regex::getFuzzySearchRegexFromSearchString _string
  test::printVars _string _STRING_FUZZY_FILTER_REGEX
}

function test_regex::getMatches() {
  test::title "✅ Testing regex::getMatches function"

  local _MY_STRING='---
- name: marc
  city: paris
- name:   john
  city: london
- name:julien
  city: lyon
'
  test::printVars _MY_STRING
  test::func regex::getMatches _MY_STRING "'name:[[:space:]]*([[:alnum:]]*)'"
  test::func regex::getMatches _MY_STRING "'name:[[:space:]]*([[:alnum:]]*)'" "\1" 2
  test::func regex::getMatches _MY_STRING "'name:[[:space:]]*([[:alnum:]]*)'" "\1" 0
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
  test::func regex::replace _MY_STRING "'^(This) is.*$'" "\1 is working."
  test::func regex::replace _MY_STRING "'^(This) is.*$'" "\1 is working." 0
  test::func regex::replace _MY_STRING "'^(This) is.*$'" "\1 is working." 0 true
}

function test_regex::getFirstGroup() {
  test::title "✅ Testing regex::getFirstGroup function"

  test::func MY_STRING='name: julien' regex::getFirstGroup MY_STRING "'name:[[:space:]]*([[:alnum:]]*)'"
}

main