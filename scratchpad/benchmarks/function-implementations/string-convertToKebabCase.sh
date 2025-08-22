#!/usr/bin/env bash
# shellcheck source=../../../libraries.d/main
source "$(valet --source)"
include benchmark

tests=(
thisIsATest0
AnotherTest
--AnotherTest--
_SNAKE_CASE
__SNAKE_CASE__
kebab-case
--kebab-case--
)

function string::convertToKebabCase1() {
  local -n camelCaseStringToConvert="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"

  if [[ ${camelCaseStringToConvert} == *[[:upper:]]* && ${camelCaseStringToConvert} == *[[:lower:]]* ]]; then
    # from camelCase or PascalCase
    while [[ ${camelCaseStringToConvert} =~ [[:upper:]] ]]; do
      camelCaseStringToConvert="${camelCaseStringToConvert//"${BASH_REMATCH[0]}"/-"${BASH_REMATCH[0],}"}"
    done
  else
    # from SNAKE_CASE of already in snake-case
    camelCaseStringToConvert="${camelCaseStringToConvert,,}"
    camelCaseStringToConvert="${camelCaseStringToConvert//[![:lower:][:digit:]-]/-}"
  fi
  while [[ ${camelCaseStringToConvert} == -* ]]; do
    camelCaseStringToConvert="${camelCaseStringToConvert:1}"
  done
  while [[ ${camelCaseStringToConvert} == *- ]]; do
    camelCaseStringToConvert="${camelCaseStringToConvert%-}"
  done
}

function string::convertToKebabCase2() {
  local -n camelCaseStringToConvert="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"

  if [[ ${camelCaseStringToConvert} == *[[:upper:]]* && ${camelCaseStringToConvert} == *[[:lower:]]* ]]; then
    # from camelCase or PascalCase
    local -i charIndex strLength=${#camelCaseStringToConvert}
    local char output=""
    for ((charIndex = 0; charIndex < strLength; charIndex++)); do
      char="${camelCaseStringToConvert:charIndex:1}"
      if [[ ${char} == [[:upper:]] ]]; then
        output+="-${char,}"
      else
        output+="${char,}"
      fi
    done
    camelCaseStringToConvert="${output}"
  else
    # from SNAKE_CASE of already in snake-case
    camelCaseStringToConvert="${camelCaseStringToConvert,,}"
    camelCaseStringToConvert="${camelCaseStringToConvert//[![:lower:][:digit:]-]/-}"
  fi
  while [[ ${camelCaseStringToConvert} == -* ]]; do
    camelCaseStringToConvert="${camelCaseStringToConvert:1}"
  done
  while [[ ${camelCaseStringToConvert} == *- ]]; do
    camelCaseStringToConvert="${camelCaseStringToConvert%-}"
  done
}

function test1() {
  test1=""
  for test in "${tests[@]}"; do
    string::convertToKebabCase1 test
    test1+="${test}"$'\n'
  done
}

function test2() {
  test2=""
  for test in "${tests[@]}"; do
    string::convertToKebabCase2 test
    test2+="${test}"$'\n'
  done
}

test1
test2

log::info "Test1:
${test1[*]}"

if [[ ${test1} != "${test2}" ]]; then
  core::fail "The two implementations returned different results."
fi

benchmark::run test1 test2