#!/usr/bin/env bash
# shellcheck source=../../../libraries.d/main
source "$(valet --source)"
include benchmark

tests=(
  "hello,world"
  "foo,bar"
  "baz,qux"
  "oh|crap"
  "hi there"
)
testsChar=(
  ","
  ","
  ","
  "|"
  " "
)

function string::split1() {
  local -n inputString_NameRef="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"
  local IFS="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"
  # shellcheck disable=SC2206
  # shellcheck disable=SC2034
  REPLY_ARRAY=(${inputString_NameRef})
}

function string::split2() {
  local -n inputString_NameRef="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"
  IFS="${2}" read -r -a REPLY_ARRAY <<<"${inputString_NameRef}"
}

function string::split3() {
  local \
    inputString="${!1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    separator="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"
  local chunk
  REPLY_ARRAY=()
  while [[ -n ${inputString} ]]; do
    chunk="${inputString%%"${separator}"*}"
    inputString="${inputString:${#chunk}+1}"
    REPLY_ARRAY+=("${chunk}")
  done
}

function test1() {
  test1=""
  for test in "${!tests[@]}"; do
    string::split1 "tests[$test]" "${testsChar[$test]}"
    test1+="${REPLY_ARRAY[*]}"$'\n'
  done
}

function test2() {
  test2=""
  for test in "${!tests[@]}"; do
    string::split1 "tests[$test]" "${testsChar[$test]}"
    test2+="${REPLY_ARRAY[*]}"$'\n'
  done
}

function test3() {
  test3=""
  for test in "${!tests[@]}"; do
    string::split3 "tests[$test]" "${testsChar[$test]}"
    test3+="${REPLY_ARRAY[*]}"$'\n'
  done
}

test1
test2
test3

log::info "Test1:
${test1[*]}"
log::info "Test2:
${test2[*]}"
log::info "Test3:
${test3[*]}"

if [[ ${test1} != "${test2}" || ${test1} != "${test3}" ]]; then
  core::fail "The implementations returned different results."
fi

benchmark::run test1 test2 test3
