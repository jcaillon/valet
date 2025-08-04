#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-exe
source exe
# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test::markdown "For these tests, we will use a special command \`fake\` defined as such:"
  test::exec declare -f fake

  test_exe::invoke5
  test_exe::invoke2
  test_exe::invoke
  test_exe::invoke3piped
}

function test_exe::invoke5() {
  test::title "✅ Testing exe::invoke5"

  printf '%s' "Input stream content from a file" >"${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Input stream from string, returns an error:"
  test::func exe::invoke5 false 0 false "'input_stream'" fake --std-in --error

  test::markdown "Input stream from string, fails (exit):"
  test::exit exe::invoke5 true 0 false "'input_stream'" fake --std-in --error

  test::markdown "Make error 1 acceptable:"
  test::func exe::invoke5 true 0,1,2 true '' fake --error

  test::markdown "Normal, return everything as variables:"
  test::func exe::invoke5 true '' '' '' fake

  test::markdown "Normal, does not redirect outputs:"
  noRedirection=true test::exec exe::invoke5 true '' '' '' fake

  test::markdown "Input stream for file, return everything as files:"
  test::prompt exe::invokef5 false 0 true "${GLOBAL_TEST_TEMP_FILE}" fake --std-in
  test::resetReplyVars
  exe::invokef5 false 0 true "${GLOBAL_TEST_TEMP_FILE}" fake --std-in
  test::printReplyVars

  if [[ -s ${REPLY:-} ]]; then
    test::exec fs::cat "${REPLY}"
  fi
  if [[ -s ${REPLY2:-} ]]; then
    test::exec fs::cat "${REPLY2}"
  fi
}

function test_exe::invoke2() {
  test::title "✅ Testing exe::invoke2"

  test::func exe::invoke2 false fake --option argument1 argument2
  test::func exe::invoke2 false fake --error
  test::exit exe::invoke2 true fake --error

  test::func exe::invokef2 false fake --option argument1 argument2

  test::exec exe::invoket2 false fake --option argument1 argument2
}

function test_exe::invoke() {
  test::title "✅ Testing exe::invoke"

  test::exit exe::invoke fake --error
  test::func exe::invoke fake --option argument1 argument2
}

function test_exe::invoke3piped() {
  test::title "✅ Testing exe::invoke3piped"

  test::func exe::invoke3piped true "'input_stream'" fake --std-in --option argument1 argument2

  test::func exe::invokef3piped true "'input_stream'" fake --std-in --option argument1 argument2
}

function fake() {
  local inputStreamContent

  if [[ $* == *"--std-in"* ]]; then
    bash::readStdIn
    inputStreamContent="${REPLY}"
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