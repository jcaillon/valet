#!/usr/bin/env bash

function test_log_level() {
  export VALET_CONFIG_ENABLE_COLORS=false
  export VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
  export VALET_CONFIG_LOG_DISABLE_TIME=true
  export VALET_CONFIG_LOG_COLUMNS=30
  export VALET_CONFIG_LOG_DISABLE_WRAP=false

  log::createPrintFunction
  eval "${GLOBAL_LOG_PRINT_FUNCTION}"

  echo
  echo "→ log::setLevel trace"
  log::setLevel trace

  test_log_log_one_of_each_level

  echo
  echo "→ log::setLevel debug"
  log::setLevel debug

  test_log_log_one_of_each_level

  echo
  echo "→ log::setLevel info"
  log::setLevel info

  test_log_log_one_of_each_level

  echo
  echo "→ log::setLevel success"
  log::setLevel success

  test_log_log_one_of_each_level

  echo
  echo "→ log::setLevel warning"
  log::setLevel warning

  test_log_log_one_of_each_level

  echo
  echo "→ log::setLevel error"
  log::setLevel error

  test_log_log_one_of_each_level
}

function test_log_log_one_of_each_level() {
  echo
  echo "→ log::getLevel"
  log::getLevel && echo "${RETURNED_VALUE}"

  echo
  echo "→ log::isTraceEnabled"
  log::isTraceEnabled && echo 0 || echo 1

  echo
  echo "→ log::isDebugEnabled"
  log::isDebugEnabled && echo 0 || echo 1

  # fix stuff for printCallStack
  GLOBAL_STACK_FUNCTION_NAMES=(log::printCallStack log::error myCmd::subFunction myCmd::function)
  GLOBAL_STACK_SOURCE_FILES=("" "core" "${PWD}/path/to/subFunction.sh" "${PWD}/path/to/function.sh")
  GLOBAL_STACK_LINE_NUMBERS=(100 200 300)

  echo
  echo "→ log::error 'This is an error message.'"
  log::error 'This is an error message.'

  echo
  echo "→ log::warning 'This is a warning message.'"
  log::warning 'This is a warning message.'

  echo
  echo "→ log::success 'This is an success message.'"
  log::success 'This is an success message.'

  echo
  echo "→ log::info 'This is an info message.'"
  log::info 'This is an info message.'

  echo
  echo "→ log::debug 'This is a debug message.'"
  log::debug 'This is a debug message.'

  echo
  echo "→ log::trace 'This is a trace message.'"
  log::trace 'This is a trace message.'

  echo
  echo "→ log::errorTrace 'This is a errorTrace message, always shown.'"
  log::errorTrace 'This is a errorTrace message, always shown.'
}

function test_log() {
  export VALET_CONFIG_ENABLE_COLORS=true
  export VALET_CONFIG_ENABLE_NERDFONT_ICONS=true
  export VALET_CONFIG_LOG_DISABLE_TIME=false
  export VALET_CONFIG_LOG_DISABLE_WRAP=false
  export VALET_CONFIG_LOG_ENABLE_TIMESTAMP=true
  export VALET_CONFIG_LOG_COLUMNS=50

  # fix the time to a known value
  export TZ=Etc/GMT+0
  unset EPOCHSECONDS EPOCHREALTIME
  export EPOCHSECONDS=548902800
  export EPOCHREALTIME=548902800.000000

  log::createPrintFunction
  echo

  echo "→ log::createPrintFunction"
  eval "${GLOBAL_LOG_PRINT_FUNCTION}"

  echo
  echo "→ log::print SUCCESS   OK ..."
  log::print SUCCESS   OK '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567' '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567'

  export VALET_CONFIG_ENABLE_COLORS=false
  export VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
  export VALET_CONFIG_LOG_DISABLE_TIME=true
  export VALET_CONFIG_LOG_COLUMNS=40

  log::createPrintFunction
  eval "${GLOBAL_LOG_PRINT_FUNCTION}"

  echo
  echo "→ log::info ..."
  log::info 'Next up is a big line with a lot of numbers not separated by spaces. Which means they will be truncated by characters and not by word boundaries like this sentence.' '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567' '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567'

  echo
  echo "→ log::printFile file-to-read 2"
  log::printFile file-to-read 2

  echo
  echo "→ log::printFile file-to-read"
  log::printFile file-to-read

  local text="What is Lorem Ipsum?

Lorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789

Why do we use it?

It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.
Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy.
Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."

  echo
  echo "→ log::printFileString \"\${text}\" 2"
  log::printFileString "${text}" 2

  echo
  echo "→ log::printFileString \"\${text}\""
  log::printFileString "${text}"
}

function main() {
  (test_log_level 1>&2)
  test::endTest "Testing log level" 0
  (test_log 1>&2)
  test::endTest "Testing log::xx functions" 0
}

main
