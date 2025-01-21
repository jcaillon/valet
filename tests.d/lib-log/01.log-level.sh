#!/usr/bin/env bash

# shellcheck disable=SC2034
function main() {
  test::title "✅ Testing log levels"

  VALET_CONFIG_ENABLE_COLORS=false
  VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
  VALET_CONFIG_LOG_DISABLE_TIME=true
  VALET_CONFIG_LOG_COLUMNS=30
  VALET_CONFIG_LOG_DISABLE_WRAP=false

  # fix stuff for printCallStack
  GLOBAL_STACK_FUNCTION_NAMES=(log::printCallStack log::error myCmd::subFunction myCmd::function)
  GLOBAL_STACK_SOURCE_FILES=("" "core" "${PWD}/path/to/subFunction.sh" "${PWD}/path/to/function.sh")
  GLOBAL_STACK_LINE_NUMBERS=(100 200 300)

  test::printVars VALET_CONFIG_ENABLE_COLORS VALET_CONFIG_ENABLE_NERDFONT_ICONS VALET_CONFIG_LOG_DISABLE_TIME VALET_CONFIG_LOG_COLUMNS VALET_CONFIG_LOG_DISABLE_WRAP GLOBAL_STACK_FUNCTION_NAMES GLOBAL_STACK_SOURCE_FILES GLOBAL_STACK_LINE_NUMBERS

  test::exec log::createPrintFunction
  test::prompt eval "\${GLOBAL_LOG_PRINT_FUNCTION}"
  eval "${GLOBAL_LOG_PRINT_FUNCTION}"

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
