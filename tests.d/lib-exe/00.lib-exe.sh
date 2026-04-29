#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-exe
source exe
# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test::markdown "For these tests, we will use a special command \`fake\` defined as such:"
  test::exec declare -f fake

  test_exe::invoke
}

function test_exe::invoke() {
  test::title "✅ Testing exe::invoke"

  test::markdown "Normal invocation:"
  test::func exe::invoke fake

  test::markdown "Error, fails (exit):"
  test::exit exe::invoke fake --error

  test::markdown "Error, fails with message (exit):"
  test::exit exe::invoke fake --error --- failMessage="Custom error message."

  test::markdown "Error but with no fail option:"
  test::func exe::invoke fake --error --- noFail=true

  test::markdown "Input stream from string:"
  test::func exe::invoke fake --std-in --- noFail=true stdin="input_stream"

  test::markdown "Input stream from string with trace mode:"
  log::setLevel trace silent=true
  test::func exe::invoke fake --std-in --- noFail=true stdin="input_stream"
  log::setLevel info

  test::markdown "Input stream for file:"
  printf '%s' "Input stream content from a file" >"${GLOBAL_TEST_TEMP_FILE}"
  test::func exe::invoke fake --std-in --- stdinFile="${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Make error 1 acceptable:"
  test::func exe::invoke fake --error --- acceptableCodes=1

  test::markdown "Do not redirect the output:"
  test::func exe::invoke fake --- noRedirection=true

  test::markdown "Return the paths instead of content:"
  test::func exe::invoke fake --- replyPathOnly=true

  test::markdown "Use custom files:"
  fs::createTempFile pathOnly=true
  test::func exe::invoke fake --- replyPathOnly=true stderrPath="${REPLY}" stdoutPath="${GLOBAL_TEST_TEMP_FILE}"
  test::exec fs::cat "${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Append output:"
  test::func exe::invoke fake --- appendRedirect=true stdoutPath="${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Group redirects:"
  test::func exe::invoke fake --- groupRedirect=true stdoutPath="${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Only warn on errors:"
  test::func exe::invoke fake --error --- warnOnFailure=true

  OSTYPE="msys"
  test::markdown "Auto clean CR on windows."
  exe::invoke fakeWindows
  if [[ ${REPLY} == *$'\r'* || ${REPLY2} == *$'\r'* ]]; then
    test::fail "exe::invoke did not remove Windows CR characters from the output on windows."
  fi

  test::markdown "Keep CR on windows."
  exe::invoke fakeWindows --- keepWindowsCr=true
  if [[ ${REPLY} != *$'\r'* || ${REPLY2} != *$'\r'* ]]; then
    test::fail "exe::invoke did not keep Windows CR characters in the output on windows."
  fi
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

  echo "INFO: log line from fake mock to stderr" 1>&2

  if [[ $* == *"--error"* ]]; then
    echo "ERROR: returning error from fake" 1>&2
    return 1
  fi
}

function fakeWindows() {
  printf "Line 1 with Windows CR\r\nLine 2 with Windows CR\r\n"
  printf "Error line 1 with Windows CR\r\nError line 2 with Windows CR\r\n" 1>&2
}

main
