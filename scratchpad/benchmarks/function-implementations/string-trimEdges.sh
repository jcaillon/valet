#!/usr/bin/env bash
# shellcheck source=../../../libraries.d/main
source "$(valet --source)"
include benchmark

tests=(
  $'\r\t'"    hello    "
  "hello   "$'\r\t'
  $'\r\t\n'"     hello"
)

function string::trimEdges1() {
  local -n inputString_NameRef="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"
  local \
    charsToTrim=$' \t\r\n' \
    IFS=$' '
  shift 1
  eval "local a= ${*@Q}"

  inputString_NameRef="${inputString_NameRef#"${inputString_NameRef%%[^"${charsToTrim}"]*}"}"
  inputString_NameRef="${inputString_NameRef%"${inputString_NameRef##*[^"${charsToTrim}"]}"}"
}

function string::trimEdges2() {
  local -n inputString_NameRef="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"
  local \
    charsToTrim=$' \t\r\n' \
    trimmed
  IFS=$' '
  shift 1
  eval "local a= ${*@Q}"

  trimmed="${inputString_NameRef%%[^"${charsToTrim}"]*}"
  inputString_NameRef="${inputString_NameRef:${#trimmed}}"
  trimmed="${inputString_NameRef##*[^"${charsToTrim}"]}"
  inputString_NameRef="${inputString_NameRef:0:-${#trimmed}}"
}

function test1() {
  local str
  test1=""
  for test in "${!tests[@]}"; do
    str="${tests["${test}"]}"
    string::trimEdges1 str
    test1+="${str}"$'\n'
  done
}

function test2() {
  local str
  test2=""
  for test in "${!tests[@]}"; do
    str="${tests["${test}"]}"
    string::trimEdges2 str
    test2+="${str}"$'\n'
  done
}

test1
test2

log::info "Test1:
${test1}"
log::info "Test2:
${test2}"

benchmark::run test1 test2
