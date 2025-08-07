#!/usr/bin/env bash

# shellcheck disable=SC2034
function main() {
  test::title "✅ Testing with a function with finite arguments"

  test::setTestCallStack
  test::exit functionWithFiniteArgs
  test::unsetTestCallStack
  test::exec functionWithFiniteArgs argument1 argument2
  test::exec functionWithFiniteArgs argument1 argument2 myOption=one
  test::exec functionWithFiniteArgs argument1 argument2 myOption=one myOption2="my value"
  test::exec functionWithFiniteArgs argument1 argument2 unknownOption=unknownValue

  test::title "✅ Testing with a function with infinite arguments"

  test::setTestCallStack
  test::exit functionWithFiniteArgs
  test::unsetTestCallStack
  test::exec functionWithInfiniteArgs argument1 argument2
  test::exec functionWithInfiniteArgs argument1 argument2 myOption=one
  test::exec functionWithInfiniteArgs argument1 argument2 ---
  test::exec functionWithInfiniteArgs argument1 argument2 --- myOption=one
  test::exec functionWithInfiniteArgs argument1 argument2 1 2 3 --- myOption=one myOption2="my value"
}

function functionWithFiniteArgs() {
  local \
    arg1="${1}" \
    arg2="${2}" \
    myOption="1" \
    myOption2="2" \
    IFS=$' '
  shift 2
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
  core::parseShellParameters "${@}"
  eval "${REPLY}"

  echo "${REPLY}"
  local
  echo "remaining arguments: '${*}'"
}


main
