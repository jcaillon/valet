#!/usr/bin/env bash

# shellcheck disable=SC2034
function main() {
  test::title "✅ Testing with a function with finite arguments"

  test::exit functionWithFiniteArgs
  test::exec functionWithFiniteArgs argument1 argument2
  test::exec functionWithFiniteArgs argument1 argument2 myOption=one
  test::exec functionWithFiniteArgs argument1 argument2 myOption=one myOption2="my value"
  test::exec functionWithFiniteArgs argument1 argument2 unknownOption=unknownValue

  test::title "✅ Testing with a function with infinite arguments"

  test::exit functionWithInfiniteArgs
  test::exec functionWithInfiniteArgs argument1 argument2
  test::exec functionWithInfiniteArgs argument1 argument2 myOption=one
  test::exec functionWithInfiniteArgs argument1 argument2 --- myOption=one
  test::exec functionWithInfiniteArgs argument1 argument2 1 2 3 --- myOption=one myOption2="my value"
}

function getToEval() {
  local param
  local -i nb=0
  for param; do
    if [[ ${param} == "---" ]]; then
      break
    fi
    nb+=1
  done
  if (($# == nb)); then
    # no separators, only arguments
    REPLY=":"
    return 0
  elif (($# == 0)); then
    # a separator but no options after it
    REPLY="set -- \"\${@:1:${nb}}\""
    return 0
  fi
  shift "$((nb + 1))"
  local IFS=$' '
  REPLY="local ${*@Q}; set -- \"\${@:1:${nb}}\""
}

function functionWithFiniteArgs() {
  local \
    arg1="${1}" \
    arg2="${2}" \
    myOption="1" \
    myOption2="2"
  shift 2
  local IFS=$' '
  eval "local a= ${*@Q}"

  echo "local a= ${*@Q}"
  local
}

function functionWithInfiniteArgs() {
  local \
    arg1="${1}" \
    arg2="${2}" \
    myOption="1" \
    myOption2="2"
  shift 2
  getToEval "${@}"
  eval "${REPLY}"

  echo "${REPLY}"
  local
  echo "remaining arguments: '${*}'"
}


main
