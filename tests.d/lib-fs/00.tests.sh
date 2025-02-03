#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_fs::toAbsolutePath
  test_fs::readFile
  test_fs::createDirectoryIfNeeded
  test_fs::createFilePathIfNeeded
  test_fs::cat
  test_fs::isDirectoryWritable
  test_fs::createLink
  test_fs::head
  test_fs::tail
  test_fs::getFileMaxLineLength
}

function test_fs::getFileMaxLineLength() {
  test::title "✅ Testing fs::getFileMaxLineLength"

  test::func fs::getFileMaxLineLength 'resources/file-to-read'

  test::func VALET_CONFIG_STRICT_PURE_BASH=true fs::getFileMaxLineLength 'resources/file-to-read'
}

function test_fs::toAbsolutePath() {
  test::title "✅ Testing fs::toAbsolutePath"

  test::func fs::toAbsolutePath "${PWD}/01.invoke.sh"
  test::func fs::toAbsolutePath .
  test::func fs::toAbsolutePath ..
  test::func fs::toAbsolutePath 01.invoke.s
  test::func fs::toAbsolutePath ../1004-lib-system/00.tests.sh
  test::func fs::toAbsolutePath resources
  test::func fs::toAbsolutePath ./01.invoke.sh
  test::func fs::toAbsolutePath ./resources
  test::func fs::toAbsolutePath missing-file
}

function test_fs::readFile() {
  test::title "✅ Testing fs::readFile"

  test::func fs::readFile 'resources/file-to-read' 22
  test::func fs::readFile 'resources/file-to-read'
}

function test_fs::createDirectoryIfNeeded() {
  test::title "✅ Testing fs::createDirectoryIfNeeded"

  test::func fs::createDirectoryIfNeeded resources/dir/subdir

  test::markdown "This next command will fail because the directory already exists (it is a file)."
  test::exit fs::createDirectoryIfNeeded resources/dir/subdir/file1

  test::func fs::createDirectoryIfNeeded resources/gitignored/derp
  if [[ -d resources/gitignored/derp ]]; then
    test::markdown "Directory created successfully!"
  fi
  rm -Rf resources/gitignored 1>/dev/null
}

function test_fs::createFilePathIfNeeded() {
  test::title "✅ Testing fs::createFilePathIfNeeded"
  test::func fs::createFilePathIfNeeded resources/dir/subdir/file1

  test::func fs::createFilePathIfNeeded resources/gitignored/allo/file1
  if [[ -f resources/gitignored/allo/file1 ]]; then
    test::markdown "File created successfully!"
  fi
  rm -Rf resources/gitignored 1>/dev/null
}

function test_fs::cat() {
  test::title "✅ Testing fs::cat"

  test::func fs::cat 'resources/file-to-read'
}

function test_fs::isDirectoryWritable() {
  test::title "✅ Testing fs::isDirectoryWritable"

  test::exec fs::isDirectoryWritable /tmp "&&" echo 'Writable' "||" echo 'Not writable'
}

function test_fs::createLink() {
  test::title "✅ Testing fs::createLink"

  function ln() { echo "🙈 mocking ln: $*"; }
  local osType="${OSTYPE:-}"
  OSTYPE="linux-gnu"

  mkdir -p resources/gitignored
  :> resources/gitignored/file

  test::exec fs::createLink 'resources/gitignored/file' 'resources/gitignored/try/file2' true
  test::flush

  test::exec fs::createLink 'resources/gitignored/try' 'resources/gitignored/new'
  test::flush

  OSTYPE="${osType}"
  unset -f ln
}

function test_fs::head() {
  test::title "✅ Testing fs::head"

  test::exec fs::head 'resources/file-to-read' 10
  test::exec fs::head 'resources/file-to-read' 0
  test::exec fs::head 'resources/file-to-read' 99

  test::func fs::head 'resources/file-to-read' 3 true
}

function test_fs::tail() {
  test::title "✅ Testing fs::tail"

  test::exec fs::tail 'resources/file-to-read' 3
  test::exec fs::tail 'resources/file-to-read' 0
  test::exec fs::tail 'resources/file-to-read' 99

  test::func fs::tail 'resources/file-to-read' 3 true
}

main