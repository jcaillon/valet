#!/usr/bin/env bash

function testIo::invoke5() {
  io::createTempFile && local tmpFile="${RETURNED_VALUE}"
  local -i exitCode

  echo "Input stream content from a file" >"${tmpFile}"

  echo "→ io::invokef5 false 0 false inputStreamValue fakeexec --std-in --error"
  io::invokef5 false 0 false inputStreamValue fakeexec --std-in --error && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} true
  test::endTest "Testing io::invoke5, should return 1, input stream from string" ${exitCode}

  echo "→ io::invokef5 true 0 false inputStreamValue fakeexec --std-in --error"
  (io::invokef5 true 0 false inputStreamValue fakeexec --std-in --error) && exitCode=0 || exitCode=$?
  echo "exitcode=${exitCode}"
  test::endTest "Testing io::invoke5, should fail" ${exitCode}

  echo "→ io::invokef5 true 0,1,2 true '' fakeexec --error"
  io::invokef5 true 0,1,2 true '' fakeexec --error && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} true
  test::endTest "Testing io::invoke5, should translate error 1 to 0" ${exitCode}

  echo "→ io::invoke5 false 0 true 'tmpFile' fakeexec --std-in"
  io::invoke5 false 0 true "${tmpFile}" fakeexec --std-in && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} false
  test::endTest "Testing io::invoke5var, input stream for file, should get stdout/stderr from var" ${exitCode}

  # test trace mode
  echo "→ io::invokef5 false 0 false inputStreamValue fakeexec --std-in --error"
  log::setLevel trace
  io::invokef5 false 0 false inputStreamValue fakeexec --std-in --error && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} true
  log::setLevel info
  test::endTest "Testing io::invoke5, with trace mode on" ${exitCode}
}

function testIo::invoke2() {
  local -i exitCode

  echo "→ io::invokef2 false fakeexec --option argument1 argument2"
  io::invokef2 false fakeexec --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} true
  test::endTest "Testing io::invoke2, output to files" ${exitCode}

  echo "→ io::invoke2 false fakeexec --option argument1 argument2"
  io::invoke2 false fakeexec --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} false
  test::endTest "Testing io::invoke2var, output to var" ${exitCode}
}

function testIo::invoke() {
  local -i exitCode

  echo "→ io::invoke fakeexec --error"
  (io::invoke fakeexec --error 2> "${GLOBAL_TEST_TEMP_FILE}") && exitCode=0 || exitCode=$?
  test::echoFileWithLineNumberSubstitution "${GLOBAL_TEST_TEMP_FILE}" 1>&2
  test::endTest "Testing io::invoke, should fail" ${exitCode}

  echo "→ io::invoke fakeexec --option argument1 argument2"
  io::invoke fakeexec --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} false
  test::endTest "Testing io::invoke, output to var" ${exitCode}
}

function testIo::invoke2piped() {
  local -i exitCode

  echo "→ io::invokef2piped true 'this is an stdin' fakeexec --std-in --option argument1 argument2"
  io::invokef2piped true 'this is an stdin' fakeexec --std-in --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} true
  test::endTest "Testing io::invoke2piped, stdin as string, output to files" ${exitCode}

  echo "→ io::invoke2piped true 'this is an stdin' fakeexec --std-in --option argument1 argument2"
  io::invoke2piped true 'this is an stdin' fakeexec --std-in --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} false
  test::endTest "Testing io::invoke2pipedvar, stdin as string, output to vars" ${exitCode}
}

function echoio::invokeOutput() {
  local exitCode areFiles
  exitCode="${1}"
  areFiles="${2}"

  local debugMessage
  debugMessage="io::invoke function ended with exit code ⌈${exitCode}⌉."$'\n'
  if [[ ${areFiles} == "true" ]]; then
    debugMessage+="stdout from file:"$'\n'"⌈$(<"${RETURNED_VALUE}")⌉"$'\n'
    debugMessage+="stderr from file:"$'\n'"⌈$(<"${RETURNED_VALUE2}")⌉"$'\n'
  else
    debugMessage+="stdout from var:"$'\n'"⌈${RETURNED_VALUE}⌉"$'\n'
    debugMessage+="stderr from var:"$'\n'"⌈${RETURNED_VALUE2}⌉"$'\n'
  fi

  echo "${debugMessage}"
}

function fakeexec() {
  local inputStreamContent

  if [[ $* == *"--std-in"* ]]; then
    io::readStdIn
    inputStreamContent="${RETURNED_VALUE}"
  fi

  local IFS=" "
  echo "▶ called fakeexec $*"
  echo "▶ fakeexec input stream was:"
  echo "⌈${inputStreamContent:-}⌉"

  echo "This is an error output from fakeexec" 1>&2

  if [[ $* == *"--error"* ]]; then
    echo "returning 1 from fakeexec" 1>&2
    return 1
  fi
}

function main() {
  testIo::invoke5
  testIo::invoke2
  testIo::invoke
  testIo::invoke2piped
}

main
