#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-io
source io

function testIo::toAbsolutePath() {

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

function testIo::readFile() {

  echo "→ io::readFile 'resources/file-to-read' 100"
  io::readFile 'resources/file-to-read' 100
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::readFile limited to x chars" 0

  echo "→ io::readFile 'resources/file-to-read'"
  io::readFile 'resources/file-to-read'
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::readFile unlimited" 0
}

function testIo::createDirectoryIfNeeded() {

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

function testIo::createFilePathIfNeeded() {

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

function testIo::sleep() {

  echo "→ io::sleep 0.001"
  io::sleep 0.001

  test::endTest "Testing io::sleep" 0
}

function testIo::cat() {

  echo "→ io::cat 'resources/file-to-read'"
  io::cat 'resources/file-to-read'

  test::endTest "Testing io::cat" 0
}

function testIo::readStdIn() {

  echo "→ io::readStdIn <<<'coucou'"
  io::readStdIn <<<"coucou"
  echo "${RETURNED_VALUE}"

  echo "→ io::readStdIn"
  io::readStdIn
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::readStdIn" 0
}

function testIo::countArgs() {

  echo "→ io::countArgs 'arg1' 'arg2' 'arg3'"
  io::countArgs 'arg1' 'arg2' 'arg3'
  echo "${RETURNED_VALUE}"

  echo "→ io::countArgs \$PWD/*"
  io::countArgs "${PWD}/resources"/*
  echo "${RETURNED_VALUE}"

  test::endTest "Testing io::countArgs" 0
}

function testIo::isDirectoryWritable() {

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

function test_io::runPs1Command() {
  function powershell() { echo "$*"; }

  echo "→ io::runPs1Command 'Get-Process'"
  io::runPs1Command 'Get-Process'
  echo "$?"

  echo "→ io::runPs1Command 'echo \\\"ok\\\"' true"
  io::runPs1Command 'echo "ok"' true
  echo "$?"

  unset -f powershell
  test::endTest "Testing io::runPs1Command" 0
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

function main() {
  testIo::toAbsolutePath
  testIo::readFile
  testIo::createDirectoryIfNeeded
  testIo::createFilePathIfNeeded
  testIo::sleep
  testIo::cat
  testIo::readStdIn
  testIo::countArgs
  testIo::isDirectoryWritable
  test_io::runPs1Command
  test_io::convertToWindowsPath
  test_io::createLink
}

main