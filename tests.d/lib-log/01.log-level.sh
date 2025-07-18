#!/usr/bin/env bash

# shellcheck disable=SC2034
function main() {
  test::title "✅ Testing log levels"

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
  test::title "✅ Testing level ${REPLY}"

  test::func log::getLevel
  test::exec log::isTraceEnabled
  test::exec log::isDebugEnabled

  test::setTestCallStack
  test::exec log::error 'This is an error message.'
  test::unsetTestCallStack
  test::exec log::warning 'This is a warning message.'
  test::exec log::success 'This is an success message.'
  test::exec log::info 'This is an info message.'
  test::exec log::debug 'This is a debug message.'
  test::exec log::trace 'This is a trace message.'
  test::exec log::errorTrace 'This is a errorTrace message, always shown.'
}

main
