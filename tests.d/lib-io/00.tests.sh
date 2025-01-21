#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-io
source io

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
  test_io::tail
}

function test_io::toAbsolutePath() {
  test::title "✅ Testing io::toAbsolutePath"

  test::func io::toAbsolutePath "${PWD}/01.invoke.sh"
  test::func io::toAbsolutePath .
  test::func io::toAbsolutePath ..
  test::func io::toAbsolutePath 01.invoke.s
  test::func io::toAbsolutePath ../1004-lib-system/00.tests.sh
  test::func io::toAbsolutePath resources
  test::func io::toAbsolutePath ./01.invoke.sh
  test::func io::toAbsolutePath ./resources
  test::func io::toAbsolutePath missing-file
}

function test_io::readFile() {
  test::title "✅ Testing io::readFile"

  test::func io::readFile 'resources/file-to-read' 22
  test::func io::readFile 'resources/file-to-read'
}

function test_io::createDirectoryIfNeeded() {
  test::title "✅ Testing io::createDirectoryIfNeeded"

  test::func io::createDirectoryIfNeeded resources/dir/subdir

  test::markdown "This next command will fail because the directory already exists (it is a file)."
  test::exit io::createDirectoryIfNeeded resources/dir/subdir/file1

  test::func io::createDirectoryIfNeeded resources/gitignored/derp
  if [[ -d resources/gitignored/derp ]]; then
    test::markdown "Directory created successfully!"
  fi
  rm -Rf resources/gitignored 1>/dev/null
}

function test_io::createFilePathIfNeeded() {
  test::title "✅ Testing io::createFilePathIfNeeded"
  test::func io::createFilePathIfNeeded resources/dir/subdir/file1

  test::func io::createFilePathIfNeeded resources/gitignored/allo/file1
  if [[ -f resources/gitignored/allo/file1 ]]; then
    test::markdown "File created successfully!"
  fi
  rm -Rf resources/gitignored 1>/dev/null
}

function test_io::sleep() {
  test::title "✅ Testing io::sleep"

  test::exec io::sleep 0.001
}

function test_io::cat() {
  test::title "✅ Testing io::cat"

  test::func io::cat 'resources/file-to-read'
}

function test_io::readStdIn() {
  test::title "✅ Testing io::readStdIn"

  test::prompt "io::readStdIn <<<'coucou'"
  test::resetReturnedVars
  io::readStdIn <<<"coucou"
  test::printReturnedVars

  test::func io::readStdIn
}

function test_io::countArgs() {
  test::title "✅ Testing io::countArgs"

  test::func io::countArgs 'arg1' 'arg2' 'arg3'
  test::func io::countArgs "\${PWD}/resources/*"
}

function test_io::isDirectoryWritable() {
  test::title "✅ Testing io::isDirectoryWritable"

  test::exec io::isDirectoryWritable /tmp "&&" echo 'Writable' "||" echo 'Not writable'
}

function test_io::convertToWindowsPath() {
  test::title "✅ Testing io::convertToWindowsPath"

  test::func io::convertToWindowsPath '/tmp/file'
  test::func io::convertToWindowsPath '/mnt/d/Users/username'
  test::func io::convertToWindowsPath '/c/data/file'
}

function test_io::convertFromWindowsPath() {
  test::title "✅ Testing io::convertFromWindowsPath"

  # shellcheck disable=SC2317
  function test::transformTextBeforeFlushing() { _TEST_OUTPUT="${_TEST_OUTPUT//\/mnt}"; }
  test::func io::convertFromWindowsPath 'C:\Users\username'
  test::func io::convertFromWindowsPath 'D:\data\file'
  unset test::transformTextBeforeFlushing
}

function test_io::createLink() {
  test::title "✅ Testing io::createLink"

  function ln() { echo "🙈 mocking ln: $*"; }
  local osType="${OSTYPE:-}"
  OSTYPE="linux-gnu"

  mkdir -p resources/gitignored
  :> resources/gitignored/file

  test::exec io::createLink 'resources/gitignored/file' 'resources/gitignored/try/file2' true
  test::flush

  test::exec io::createLink 'resources/gitignored/try' 'resources/gitignored/new'
  test::flush

  OSTYPE="${osType}"
  unset -f ln
}

function test_io::head() {
  test::title "✅ Testing io::head"

  test::exec io::head 'resources/file-to-read' 10
  test::exec io::head 'resources/file-to-read' 0
  test::exec io::head 'resources/file-to-read' 99

  test::func io::head 'resources/file-to-read' 3 true
}

function test_io::captureOutput() {
  test::title "✅ Testing io::captureOutput"

  test::func io::captureOutput echo coucou
  test::func io::captureOutput declare -f io::captureOutput
  test::func io::captureOutput "[[" 1 -eq 0 "]]" || echo "Failed as expected"
}

function test_io::tail() {
  test::title "✅ Testing io::tail"

  test::exec io::tail 'resources/file-to-read' 3
  test::exec io::tail 'resources/file-to-read' 0
  test::exec io::tail 'resources/file-to-read' 99

  test::func io::tail 'resources/file-to-read' 3 true
}

main