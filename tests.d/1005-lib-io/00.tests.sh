#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-io
source io

function test_io::toAbsolutePath() {

  echo "→ io::toAbsolutePath \${PWD}/01.invoke.sh"
  io::toAbsolutePath "${PWD}/01.invoke.sh" && echo "${RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath ."
  io::toAbsolutePath . && echo "${RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath .."
  io::toAbsolutePath .. && echo "${RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath 01.invoke.sh"
  io::toAbsolutePath 01.invoke.sh && echo "${RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath ../1004-lib-system/00.tests.sh"
  io::toAbsolutePath "../1004-lib-system/00.tests.sh" && echo "${RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath resources"
  io::toAbsolutePath resources && echo "${RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath ./01.invoke.sh"
  io::toAbsolutePath ./01.invoke.sh && echo "${RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath ./resources"
  io::toAbsolutePath ./resources && echo "${RETURNED_VALUE}"

  echo
  echo "→ io::toAbsolutePath missing-file"
  io::toAbsolutePath "missing-file" && echo "${RETURNED_VALUE}"

  test::endTest "Testing io::toAbsolutePath" 0
}

function outputTextToStdErr() {
  echo "This is an error message" 1>&2
}

function test_io::readFile() {

  echo "→ io::readFile 'resources/file-to-read' 100"
  io::readFile 'resources/file-to-read' 100
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::readFile limited to x chars" 0

  echo "→ io::readFile 'resources/file-to-read'"
  io::readFile 'resources/file-to-read'
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::readFile unlimited" 0
}

function test_io::createDirectoryIfNeeded() {

  echo "→ io::createDirectoryIfNeeded 'resources/dir/subdir'"
  io::createDirectoryIfNeeded resources/dir/subdir
  echo "${RETURNED_VALUE}"

  echo "→ io::createDirectoryIfNeeded 'resources/dir/subdir/file1'"
  (io::createDirectoryIfNeeded resources/dir/subdir/file1) || echo "Failed as expected because its a file"

  echo "→ io::createDirectoryIfNeeded 'resources/gitignored/derp'"
  io::createDirectoryIfNeeded resources/gitignored/derp
  echo "${RETURNED_VALUE}"
  if [[ -d resources/gitignored/derp ]]; then
    echo "Directory created successfully!"
  fi
  rm -Rf resources/gitignored

  test::endTest "Testing io::createDirectoryIfNeeded" 0
}

function test_io::createFilePathIfNeeded() {

  echo "→ io::createFilePathIfNeeded 'resources/dir/subdir/file1'"
  io::createFilePathIfNeeded resources/dir/subdir/file1
  echo "${RETURNED_VALUE}"

  echo "→ io::createFilePathIfNeeded 'resources/gitignored/allo/file1'"
  io::createFilePathIfNeeded resources/gitignored/allo/file1
  echo "${RETURNED_VALUE}"
  if [[ -f resources/gitignored/allo/file1 ]]; then
    echo "File created successfully!"
  fi
  rm -Rf resources/gitignored

  test::endTest "Testing io::createFilePathIfNeeded" 0
}

function test_io::sleep() {

  echo "→ io::sleep 0.001"
  io::sleep 0.001

  test::endTest "Testing io::sleep" 0
}

function test_io::cat() {

  echo "→ io::cat 'resources/file-to-read'"
  io::cat 'resources/file-to-read'

  test::endTest "Testing io::cat" 0
}

function test_io::readStdIn() {

  echo "→ io::readStdIn <<<'coucou'"
  io::readStdIn <<<"coucou"
  echo "${RETURNED_VALUE}"

  echo "→ io::readStdIn"
  io::readStdIn
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::readStdIn" 0
}

function test_io::countArgs() {

  echo "→ io::countArgs 'arg1' 'arg2' 'arg3'"
  io::countArgs 'arg1' 'arg2' 'arg3'
  echo "${RETURNED_VALUE}"

  echo "→ io::countArgs \$PWD/*"
  io::countArgs "${PWD}/resources"/*
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::countArgs" 0
}

function test_io::isDirectoryWritable() {

  echo "→ io::isDirectoryWritable '/tmp'"
  if io::isDirectoryWritable '/tmp'; then
    echo "Writable"
  else
    echo "Not writable"
  fi

  echo "→ io::isDirectoryWritable '/tmp/notexisting'"
  if io::isDirectoryWritable '/tmp/notexisting'; then
    echo "Writable"
  else
    echo "Not writable"
  fi

  test::endTest "Testing io::isDirectoryWritable" 0
}

function test_io::convertToWindowsPath() {
  echo "→ io::convertToWindowsPath '/tmp/file'"
  io::convertToWindowsPath '/tmp/file'
  echo "${RETURNED_VALUE}"

  echo "→ io::convertToWindowsPath '/mnt/d/Users/username'"
  io::convertToWindowsPath '/mnt/d/Users/username'
  echo "${RETURNED_VALUE}"

  echo "→ io::convertToWindowsPath '/c/data/file'"
  io::convertToWindowsPath '/c/data/file'
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::convertToWindowsPath" 0
}

function test_io::convertFromWindowsPath() {
  printf "%s\n" "→ io::convertFromWindowsPath 'C:\\Users\\username'"
  io::convertFromWindowsPath 'C:\Users\username'
  echo "${RETURNED_VALUE}"

  printf "%s\n" "→ io::convertFromWindowsPath 'D:\\data\\file'"
  io::convertFromWindowsPath 'D:\data\file'
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::convertFromWindowsPath" 0
}

function test_io::createLink() {
  function ln() { echo "ln: $*"; }
  local osType="${OSTYPE:-}"
  OSTYPE="linux-gnu"

  mkdir -p resources/gitignored
  :> resources/gitignored/file

  echo "→ io::createLink 'resources/gitignored/file' 'resources/gitignored/try/file2' true"
  io::createLink 'resources/gitignored/file' 'resources/gitignored/try/file2' true
  echo "${RETURNED_VALUE}"

  echo "→ io::createLink 'resources/gitignored/try' 'resources/gitignored/new'"
  io::createLink 'resources/gitignored/try' 'resources/gitignored/new'
  echo "${RETURNED_VALUE}"

  OSTYPE="${osType}"
  unset -f ln
  test::endTest "Testing io::createLink" 0
}

function test_io::head() {

  echo "→ io::head 'resources/file-to-read' 10"
  io::head 'resources/file-to-read' 10

  test::endTest "Testing io::head limited to 10 lines" 0

  echo "→ io::head 'resources/file-to-read' 0"
  io::head 'resources/file-to-read' 0

  test::endTest "Testing io::head limited to 0 lines" 0

  echo "→ io::head 'resources/file-to-read' 99"
  io::head 'resources/file-to-read' 99

  test::endTest "Testing io::head limited to 99 lines" 0

  echo "→ io::head 'resources/file-to-read' 10 true"
  io::head 'resources/file-to-read' 10 true
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::head to var" 0
}

function test_io::captureOutput() {

  echo "→ io::captureOutput 'echo coucou'"
  io::captureOutput 'echo coucou'
  echo "${RETURNED_VALUE}"

  echo
  echo "→ io::captureOutput 'declare -f io::captureOutput'"
  io::captureOutput 'declare -f io::captureOutput'
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::captureOutput" 0

  echo "→ io::captureOutput '[[ 1 -eq 0 ]]'"
  io::captureOutput '[[ 1 -eq 0 ]]' || echo "Failed as expected"

  test::endTest "Testing io::captureOutput when command is failing" 0
}


function main() {
  test_io::toAbsolutePath
  test_io::readFile
  test_io::createDirectoryIfNeeded
  test_io::createFilePathIfNeeded
  test_io::sleep
  test_io::cat
  test_io::readStdIn
  test_io::countArgs
  test_io::isDirectoryWritable
  test_io::convertToWindowsPath
  test_io::createLink
  test_io::convertFromWindowsPath
  test_io::head
  test_io::captureOutput
}

main