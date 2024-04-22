#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-io
source io

function testIo::toAbsolutePath() {

  echo "→ io::toAbsolutePath \${PWD}/01.invoke.sh"
  io::toAbsolutePath "${PWD}/01.invoke.sh" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath 01.invoke.sh"
  io::toAbsolutePath "01.invoke.sh" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath ./01.invoke.sh"
  io::toAbsolutePath "./01.invoke.sh" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath ../0003-self/01.invoke.sh"
  io::toAbsolutePath "../0003-self/01.invoke.sh" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing io::toAbsolutePath" 0
}

function outputTextToStdErr() {
  echo "This is an error message" 1>&2
}

function testIo::captureOutput() {

  echo "→ io::captureOutput echo \"Hello world!\""
  io::captureOutput echo "Hello world!" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ io::captureOutput outputTextToStdErr"
  io::captureOutput outputTextToStdErr && echo "${LAST_RETURNED_VALUE2}"

  endTest "Testing io::captureOutput" 0
}

function testIo::readFile() {

  echo "→ io::readFile 'resources/file-to-read' 100"
  io::readFile 'resources/file-to-read' 100
  echo "${LAST_RETURNED_VALUE}"

  endTest "Testing io::readFile limited to x chars" 0

  echo "→ io::readFile 'resources/file-to-read'"
  io::readFile 'resources/file-to-read'
  echo "${LAST_RETURNED_VALUE}"

  endTest "Testing io::readFile unlimited" 0
}

function testIo::createFilePathIfNeeded() {

  echo "→ io::createFilePathIfNeeded 'resources/dir/subdir/file1'"
  io::createFilePathIfNeeded resources/dir/subdir/file1
  echo "${LAST_RETURNED_VALUE}"

  if [[ -f resources/dir/subdir/file1 ]]; then
    echo "File created successfully!"
  fi

  endTest "Testing io::createFilePathIfNeeded" 0
}

function main() {
  testIo::toAbsolutePath
  testIo::captureOutput
  testIo::readFile
  testIo::createFilePathIfNeeded
}

main