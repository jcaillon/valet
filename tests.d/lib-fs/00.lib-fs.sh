#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_fs::getCommandPath
  test_fs::getScriptDirectory
  test_fs::writeToFile
  test_fs::createTemp
  test_fs::getFileLineCount
  test_fs::getAbsolutePath
  test_fs::readFile
  test_fs::createDirectoryIfNeeded
  test_fs::createFileIfNeeded
  test_fs::cat
  test_fs::isDirectoryWritable
  test_fs::createLink
  test_fs::head
  test_fs::tail
}

function test_fs::getCommandPath() {
  test::title "✅ Testing fs::getCommandPath"

  local oldPath="${PATH}"
  PATH="${PWD}/resources:${PATH}"
  test::func fs::getCommandPath script.sh
  PATH="${oldPath}"

  hash -p resources/script2.sh script2
  test::func fs::getCommandPath script2

  test::func fs::getCommandPath unknown-command1
}

function test_fs::getScriptDirectory() {
  test::title "✅ Testing fs::getScriptDirectory"

  test::prompt fs::getScriptDirectory
  fs::getScriptDirectory
  echo "${REPLY}"
  test::flush

  test::prompt source resources/script.sh
  source resources/script.sh
  echo "${REPLY}"
  test::flush
}

function test_fs::writeToFile() {
  test::title "✅ Testing fs::writeToFile"

  local _content="Hello,"
  test::exec fs::writeToFile resources/gitignored/file1 _content

  _content=" World!"
  test::exec fs::writeToFile resources/gitignored/file1 _content append=true

  test::exec fs::cat resources/gitignored/file1
}

function test_fs::createTemp() {
  test::title "✅ Testing fs::createTempFile and fs::createTempDirectory"

  test::func fs::createTempFile pathOnly=true
  if [[ ! -f "${REPLY}" ]]; then
    test::markdown "The file path was returned but the file does not exist."
  fi

  test::func fs::createTempDirectory pathOnly=true
  if [[ ! -d "${REPLY}" ]]; then
    test::markdown "The directory path was returned but the directory does not exist."
  fi
}

function test_fs::getFileLineCount() {
  test::title "✅ Testing fs::getFileLineCount"

  test::func fs::getFileLineCount 'resources/file-to-read'

  # TODO: fix this test cause it should be 3 but it is 2
  test::func fs::getFileLineCount 'resources/file-with-final-eol'

  test::func VALET_CONFIG_STRICT_PURE_BASH=true fs::getFileLineCount 'resources/file-to-read'
}

function test_fs::getAbsolutePath() {
  test::title "✅ Testing fs::getAbsolutePath"

  test::func fs::getAbsolutePath "${PWD}/01.invoke.sh"
  test::func fs::getAbsolutePath .
  test::func fs::getAbsolutePath ..
  test::func fs::getAbsolutePath 01.invoke.s
  test::func fs::getAbsolutePath ../1004-lib-system/00.tests.sh
  test::func fs::getAbsolutePath resources
  test::func fs::getAbsolutePath ./01.invoke.sh
  test::func fs::getAbsolutePath ./resources
  test::func fs::getAbsolutePath missing-file

  function pwd() { echo "mocked pwd"; }
  test::func fs::getAbsolutePath "${PWD}/01.invoke.sh" realpath=true
  unset -f pwd
}

function test_fs::readFile() {
  test::title "✅ Testing fs::readFile"

  test::func fs::readFile 'resources/file-to-read' maxCharacters=22
  test::func fs::readFile 'resources/file-to-read'
}

function test_fs::createDirectoryIfNeeded() {
  test::title "✅ Testing fs::createDirectoryIfNeeded"

  test::func fs::createDirectoryIfNeeded resources/dir/subdir

  # on certain versions of bash, you get a different quote character
  function test::scrubOutput() { GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT//'‘'/"'"}"; GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT//'’'/"'"}"; }

  test::markdown "This next command will fail because the directory already exists (it is a file)."
  test::exit fs::createDirectoryIfNeeded resources/dir/subdir/file1

  unset -f test::scrubOutput

  test::func fs::createDirectoryIfNeeded resources/gitignored/derp
  if [[ -d resources/gitignored/derp ]]; then
    test::markdown "Directory created successfully!"
  fi
  rm -Rf resources/gitignored 1>/dev/null
}

function test_fs::createFileIfNeeded() {
  test::title "✅ Testing fs::createFileIfNeeded"
  test::func fs::createFileIfNeeded resources/dir/subdir/file1

  test::func fs::createFileIfNeeded resources/gitignored/allo/file1
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

  test::exec fs::isDirectoryWritable /tmp
  test::exec fs::isDirectoryWritable /tmp testFileName="test-file"
}

function test_fs::createLink() {
  test::title "✅ Testing fs::createLink"

  function ln() { echo "🙈 mocking ln: $*"; }
  function rm() { echo "🙈 mocking rm: $*"; }

  mkdir -p resources/gitignored
  :> resources/gitignored/file

  test::exec fs::createLink 'resources/gitignored/file' 'resources/gitignored/try/file2' hardlink=true
  test::flush

  test::exec fs::createLink 'resources/gitignored/try' 'resources/gitignored/new'
  test::flush

  : >"resources/gitignored/try/file2"
  test::exec fs::createLink 'resources/gitignored/file' 'resources/gitignored/try/file2' force=true hardlink=true
  test::flush

  unset -f ln rm
}

function test_fs::head() {
  test::title "✅ Testing fs::head"

  test::exec fs::head 'resources/file-to-read' 10
  test::exec fs::head 'resources/file-to-read' 0
  test::exec fs::head 'resources/file-to-read' 99

  test::func fs::head 'resources/file-to-read' 3 toArray=true
}

function test_fs::tail() {
  test::title "✅ Testing fs::tail"

  test::exec fs::tail 'resources/file-to-read' 3
  test::exec fs::tail 'resources/file-to-read' 0
  test::exec fs::tail 'resources/file-to-read' 99

  test::func fs::tail 'resources/file-to-read' 3 toArray=true
}

main