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
  test::func exe::call fake

  test::markdown "Error, fails (exit):"
  test::exit exe::call fake --error

  test::markdown "Error but with no fail option:"
  test::func exe::call fake --error --- noFail=true

  test::markdown "Input stream from string:"
  test::func exe::call fake --std-in --- noFail=true stdin="input_stream"

  test::markdown "Input stream from string with trace mode:"
  log::setLevel trace silent=true
  test::func exe::call fake --std-in --- noFail=true stdin="input_stream"
  log::setLevel info

  test::markdown "Input stream for file:"
  printf '%s' "Input stream content from a file" >"${GLOBAL_TEST_TEMP_FILE}"
  test::func exe::call fake --std-in --- stdinFile="${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Make error 1 acceptable:"
  test::func exe::call fake --error --- acceptableCodes=1

  test::markdown "Do not redirect the output:"
  test::func exe::call fake --- noRedirection=true

  test::markdown "Return the paths instead of content:"
  test::func exe::call fake --- replyPathOnly=true

  test::markdown "Use custom files:"
  fs::createTempFile pathOnly=true
  test::func exe::call fake --- replyPathOnly=true stderrPath="${REPLY}" stdoutPath="${GLOBAL_TEST_TEMP_FILE}"
  test::exec fs::cat "${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Append output:"
  test::func exe::call fake --- appendRedirect=true stdoutPath="${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Group redirects:"
  test::func exe::call fake --- groupRedirect=true stdoutPath="${GLOBAL_TEST_TEMP_FILE}"
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

main