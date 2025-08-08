#!/usr/bin/env bash

# shellcheck disable=SC2034
function main() {
  test_functionArgumentsParsing
}

function test_functionArgumentsParsing() {
  test::title "✅ Testing a function with finite arguments"

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

  test::title "✅ Testing errors in a function with finite arguments"

  # fix output for printCallStack
  GLOBAL_STACK_FUNCTION_NAMES=(log::getCallStack log::printCallStack functionWithFiniteArgs test_functionArgumentsParsing main)
  GLOBAL_STACK_SOURCE_FILES=("core" "core" "00.coding-style.sh" "00.coding-style.sh" "00.coding-style.sh")
  GLOBAL_STACK_LINE_NUMBERS=(10 100 200 300)

  test::exit functionWithFiniteArgs argument1 argument2 1invalid

  test::title "✅ Testing errors in a function with infinite arguments"

  test::exit functionWithInfiniteArgs argument1 argument2 --- 1invalid
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
  core::parseFunctionOptions "${@}"
  eval "${REPLY}"

  echo "${REPLY}"
  local
  echo "remaining arguments: '${*}'"
}


main
