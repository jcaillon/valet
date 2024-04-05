#!/usr/bin/env bash

include io

function testToAbsolutePath() {

  echo "→ toAbsolutePath \${PWD}/fakeexec"
  toAbsolutePath "${PWD}/fakeexec" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ toAbsolutePath fakeexec"
  toAbsolutePath "fakeexec" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ toAbsolutePath ./fakeexec"
  toAbsolutePath "./fakeexec" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ toAbsolutePath ../0003-self/fakeexec"
  toAbsolutePath "../0003-self/fakeexec" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing toAbsolutePath" 0
}

function outputTextToStdErr() {
  echo "This is an error message" 1>&2
}

function testCaptureOutput() {

  echo "→ captureOutput echo \"Hello world!\""
  captureOutput echo "Hello world!" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ captureOutput outputTextToStdErr"
  captureOutput outputTextToStdErr && echo "${LAST_RETURNED_VALUE2}"

  endTest "Testing captureOutput" 0
}

function testReadFile() {

  echo "→ readFile 'resources/file-to-read' 100"
  readFile 'resources/file-to-read' 100
  echo "${LAST_RETURNED_VALUE}"

  endTest "Testing readFile limited to x chars" 0

  echo "→ readFile 'resources/file-to-read'"
  readFile 'resources/file-to-read'
  echo "${LAST_RETURNED_VALUE}"

  endTest "Testing readFile unlimited" 0
}

function main() {
  testToAbsolutePath
  testCaptureOutput
  testReadFile
}

main