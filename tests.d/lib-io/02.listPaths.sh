#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-io
source io
# shellcheck source=../../libraries.d/lib-array
source array

function main() {
  test_io::listPaths
  test_io::listFiles
  test_io::listDirectories
}

function test_io::listPaths() {
  test::title "✅ Testing io::listPaths"

  test::func io::listPaths "${PWD}/resources/search"
  test::func io::listPaths "${PWD}/resources/search" true
  test::func io::listPaths "${PWD}/resources/search" false true
  test::func io::listPaths "${PWD}/resources/search" true true

  fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }
  test::exec declare -f fileNamedFile
  test::func io::listPaths "${PWD}/resources/search" true true fileNamedFile

  # shellcheck disable=SC2317
  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  test::exec declare -f folderNamedHidden
  test::func io::listPaths "${PWD}/resources/search" true true '' folderNamedHidden
}

function test_io::listFiles() {
  test::title "✅ Testing io::listFiles"

  test::func io::listFiles "${PWD}/resources/search"
  test::func io::listFiles "${PWD}/resources/search" true
  test::func io::listFiles "${PWD}/resources/search" true true

  # shellcheck disable=SC2317
  fileNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  test::exec declare -f fileNamedHidden
  test::func io::listFiles "${PWD}/resources/search" true true folderNamedHidden
}

function test_io::listDirectories() {
  test::title "✅ Testing io::listDirectories"

  test::func io::listDirectories "${PWD}/resources/search"
  test::func io::listDirectories "${PWD}/resources/search" true
  test::func io::listDirectories "${PWD}/resources/search" true true

  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  test::exec declare -f folderNamedHidden
  test::func io::listDirectories "${PWD}/resources/search" true true folderNamedHidden
}

main