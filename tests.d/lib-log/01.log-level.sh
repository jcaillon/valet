#!/usr/bin/env bash

# shellcheck disable=SC2034
function main() {
  test::title "✅ Testing log levels"

  # fix stuff for printCallStack
  GLOBAL_STACK_FUNCTION_NAMES=(log::printCallStack log::error myCmd::subFunction myCmd::function)
  GLOBAL_STACK_SOURCE_FILES=("" "core" "${PWD}/path/to/subFunction.sh" "${PWD}/path/to/function.sh")
  GLOBAL_STACK_LINE_NUMBERS=(100 200 300)

  test::exec log::init

  test::exec log::setLevel trace

  test_log_log_one_of_each_level

  test::exec log::setLevel debug

  test_log_log_one_of_each_level

  test::exec log::setLevel info

  test_log_log_one_of_each_level

  test::exec log::setLevel success

  test_log_log_one_of_each_level

  test::exec log::setLevel warning

  test_log_log_one_of_each_level

  test::exec log::setLevel error

  test_log_log_one_of_each_level
}

function test_log_log_one_of_each_level() {
  log::getLevel
  test::title "✅ Testing level ${RETURNED_VALUE}"

  test::func log::getLevel
  test::exec log::isTraceEnabled
  test::exec log::isDebugEnabled

  test::exec log::error 'This is an error message.'
  test::exec log::warning 'This is a warning message.'
  test::exec log::success 'This is an success message.'
  test::exec log::info 'This is an info message.'
  test::exec log::debug 'This is a debug message.'
  test::exec log::trace 'This is a trace message.'
  test::exec log::errorTrace 'This is a errorTrace message, always shown.'
}

main
