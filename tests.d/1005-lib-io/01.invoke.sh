#!/usr/bin/env bash

function testIo::invoke5() {
  setTempFilesNumber 300
  io::createTempFile && local tmpFile="${RETURNED_VALUE}"
  local -i exitCode

  echo "Input stream content from a file" >"${tmpFile}"

  echo "→ io::invoke5 false 0 false inputStreamValue fakeexec --std-in --error"
  io::invoke5 false 0 false inputStreamValue fakeexec --std-in --error && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} true
  endTest "Testing io::invoke5, should return 1, input stream from string" ${exitCode}

  echo "→ io::invoke5 true 0 false inputStreamValue fakeexec --std-in --error"
  (io::invoke5 true 0 false inputStreamValue fakeexec --std-in --error) && exitCode=0 || exitCode=$?
  echo "exitcode=${exitCode}"
  endTest "Testing io::invoke5, should fail" ${exitCode}

  echo "→ io::invoke5 true 0,1,2 true '' fakeexec --error"
  io::invoke5 true 0,1,2 true '' fakeexec --error && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} true
  endTest "Testing io::invoke5, should translate error 1 to 0" ${exitCode}

  echo "→ io::invoke5var false 0 true 'tmpFile' fakeexec --std-in"
  io::invoke5var false 0 true "${tmpFile}" fakeexec --std-in && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} false
  endTest "Testing io::invoke5var, input stream for file, should get stdout/stderr from var" ${exitCode}

  # test debug mode
  echo "→ io::invoke5 false 0 false inputStreamValue fakeexec --std-in --error"
  log::setLevel debug
  io::invoke5 false 0 false inputStreamValue fakeexec --std-in --error && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} true
  endTest "Testing io::invoke5, with debug mode on" ${exitCode}
}

function testIo::invoke3() {
  local -i exitCode

  echo "→ io::invoke3 false 0 fakeexec --option argument1 argument2"
  io::invoke3 false 0 fakeexec --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} true
  endTest "Testing io::invoke3, output to files" ${exitCode}

  echo "→ io::invoke3var false 0 fakeexec --option argument1 argument2"
  io::invoke3var false 0 fakeexec --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} false
  endTest "Testing io::invoke3var, output to var" ${exitCode}
}

function testIo::invoke() {
  local -i exitCode

  echo "→ io::invoke fakeexec --error"
  (io::invoke fakeexec --error 2> "${GLOBAL_TEST_TEMP_FILE}") && exitCode=0 || exitCode=$?
  echoFileWithLineNumberSubstitution "${GLOBAL_TEST_TEMP_FILE}" 1>&2
  endTest "Testing io::invoke, should fail" ${exitCode}

  echo "→ io::invoke fakeexec --option argument1 argument2"
  io::invoke fakeexec --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} false
  endTest "Testing io::invoke, output to var" ${exitCode}
}

function testIo::invokePiped() {
  local -i exitCode

  echo "→ io::invokePiped 'this is an stdin' fakeexec --std-in --option argument1 argument2"
  io::invokePiped 'this is an stdin' fakeexec --std-in --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoio::invokeOutput ${exitCode} false
  endTest "Testing io::invokePiped, stdin as string, output to var" ${exitCode}
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
  testIo::invoke3
  testIo::invoke
  testIo::invokePiped
}

main
