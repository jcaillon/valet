#!/usr/bin/env bash

function main() {
  test::markdown "For these tests, we will use a special command \`fake\` defined as such:"
  test::exec declare -f fake

  test_io::invoke5
  test_io::invoke2
  test_io::invoke
  test_io::invoke2piped
}

function test_io::invoke5() {
  test::title "✅ Testing io::invoke5"

  printf '%s' "Input stream content from a file" >"${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Input stream from string, returns an error:"
  test::func io::invoke5 false 0 false "'input_stream'" fake --std-in --error

  test::markdown "Input stream from string, fails (exit):"
  test::exit io::invoke5 true 0 false "'input_stream'" fake --std-in --error

  test::markdown "Make error 1 acceptable:"
  test::func io::invoke5 true 0,1,2 true '' fake --error

  test::markdown "Normal, return everything as variables:"
  test::func io::invoke5 true '' '' '' fake

  test::markdown "Input stream for file, return everything as files:"
  test::prompt io::invokef5 false 0 true "${GLOBAL_TEST_TEMP_FILE}" fake --std-in
  test::resetReturnedVars
  io::invokef5 false 0 true "${GLOBAL_TEST_TEMP_FILE}" fake --std-in
  test::printReturnedVars

  if [[ -s ${RETURNED_VALUE:-} ]]; then
    test::exec io::cat "${RETURNED_VALUE}"
  fi
  if [[ -s ${RETURNED_VALUE2:-} ]]; then
    test::exec io::cat "${RETURNED_VALUE2}"
  fi
}

function test_io::invoke2() {
  test::title "✅ Testing io::invoke2"

  test::func io::invoke2 false fake --option argument1 argument2
  test::func io::invoke2 false fake --error
  test::exit io::invoke2 true fake --error

  test::func io::invokef2 false fake --option argument1 argument2
}

function test_io::invoke() {
  test::title "✅ Testing io::invoke"

  test::exit io::invoke fake --error
  test::func io::invoke fake --option argument1 argument2
}

function test_io::invoke2piped() {
  test::title "✅ Testing io::invoke2piped"

  test::func io::invoke2piped true "'input_stream'" fake --std-in --option argument1 argument2

  test::func io::invokef2piped true "'input_stream'" fake --std-in --option argument1 argument2
}

function fake() {
  local inputStreamContent

  if [[ $* == *"--std-in"* ]]; then
    io::readStdIn
    inputStreamContent="${RETURNED_VALUE}"
  fi

  local IFS=" "
  echo "🙈 mocking fake $*"
  if [[ -n ${inputStreamContent:-} ]]; then
    echo "Input stream: <${inputStreamContent}>"
  fi

  echo "INFO: log line from fake mock" 1>&2

  if [[ $* == *"--error"* ]]; then
    echo "ERROR: returning error from fake" 1>&2
    return 1
  fi
}

main
