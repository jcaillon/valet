#!/usr/bin/env bash

function testInvoke5() {
  createTempFile && local tmpFile="${LAST_RETURNED_VALUE}"
  local exitCode

  echo "Input stream content from a file" >"${tmpFile}"

  echo "→ invoke5 false 0 true \"\${tmpFile}\" fakeexec --std-in --option argument1 argument2"
  invoke5 false 0 true "${tmpFile}" fakeexec --std-in --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoInvokeOutput $exitCode true
  endTest "Testing invoke5, executable are taken in priority from VALET_BIN_PATH, input stream from file" 0

  echo "→ invoke5 false 0 false inputStreamValue fakeexec2 --std-in --error"
  invoke5 false 0 false inputStreamValue fakeexec2 --std-in --error && exitCode=0 || exitCode=$?
  echoInvokeOutput $exitCode true
  endTest "Testing invoke5, should return 1, input stream from string" 0

  echo "→ invoke5 true 0 false inputStreamValue fakeexec2 --std-in --error"
  (invoke5 true 0 false inputStreamValue fakeexec2 --std-in --error) && exitCode=0 || exitCode=$?
  echo "exitcode=$exitCode"
  endTest "Testing invoke5, should fail" 0

  echo "→ invoke5 true 0,1,2 true '' fakeexec2 --error"
  invoke5 true 0,1,2 true '' fakeexec2 --error && exitCode=0 || exitCode=$?
  echoInvokeOutput $exitCode true
  endTest "Testing invoke5, should translate error 1 to 0" 0

  echo "→ invoke5var false 0 true '' fakeexec2"
  invoke5var false 0 true '' fakeexec2 && exitCode=0 || exitCode=$?
  echoInvokeOutput $exitCode false
  endTest "Testing invoke5var, should get stdout/stderr from var" 0
}

function testInvoke3() {

echo "ok2" 1>&3
  echo "→ invoke3 false 0 fakeexec2 --option argument1 argument2"
  invoke3 false 0 fakeexec2 --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoInvokeOutput "$exitCode" true
  endTest "Testing invoke3, output to files" 0

echo "ok2" 1>&3
  echo "→ invoke3var false 0 fakeexec2 --option argument1 argument2"
  invoke3var false 0 fakeexec2 --option argument1 argument2 && exitCode=0 || exitCode=$?
  echoInvokeOutput "$exitCode" false
  endTest "Testing invoke3var, output to var" 0
}

function echoInvokeOutput() {
  local exitCode areFiles
  exitCode="${1}"
  areFiles="${2}"

  local debugMessage
  debugMessage="Invoke function ended with exit code ⌜${exitCode}⌝."$'\n'
  if [[ "${areFiles}" == "true" ]]; then
    debugMessage+="⌜stdout from file⌝:"$'\n'"$(<"${LAST_RETURNED_VALUE}")"$'\n'
    debugMessage+="⌜stderr from file⌝:"$'\n'"$(<"${LAST_RETURNED_VALUE2}")"$'\n'
  else
    debugMessage+="⌜stdout from var⌝:"$'\n'"${LAST_RETURNED_VALUE}"$'\n'
    debugMessage+="⌜stderr from var⌝:"$'\n'"${LAST_RETURNED_VALUE2}"$'\n'
  fi

  echo "${debugMessage}"
}

function fakeexec2() {
  local inputStreamContent

  if [[ "$*" == *"--std-in"* ]]; then
    read -rd '' inputStreamContent <&0 || true
  fi

  echo "▶ called fakeexec2"
  echo "Input stream was:"
  echo ---
  echo "${inputStreamContent:-}"
  echo ---
  echo "Arguments were:"
  echo "$@"

  echo "This is an error output from fakeexec2" 1>&2

  if [[ "$*" == *"--error"* ]]; then
    echo "returning 1 from fakeexec2" 1>&2
    return 1
  fi
}

function main() {
  # setting VALET_BIN_PATH to the current directory so we can find our executable fakeexec
  VALET_BIN_PATH="${PWD}"

  testInvoke5
  testInvoke3

  unset VALET_BIN_PATH
}

main
