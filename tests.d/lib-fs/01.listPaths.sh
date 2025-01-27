#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-fs
source fs
# shellcheck source=../../libraries.d/lib-array
source array

function main() {
  test_fs::listPaths
  test_fs::listFiles
  test_fs::listDirectories
}

function test_fs::listPaths() {
  test::title "✅ Testing fs::listPaths"

  test::func fs::listPaths "${PWD}/resources/search"
  test::func fs::listPaths "${PWD}/resources/search" true
  test::func fs::listPaths "${PWD}/resources/search" false true
  test::func fs::listPaths "${PWD}/resources/search" true true

  fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }
  test::exec declare -f fileNamedFile
  test::func fs::listPaths "${PWD}/resources/search" true true fileNamedFile

  # shellcheck disable=SC2317
  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  test::exec declare -f folderNamedHidden
  test::func fs::listPaths "${PWD}/resources/search" true true folderNamedHidden
}

function test_fs::listFiles() {
  test::title "✅ Testing fs::listFiles"

  test::func fs::listFiles "${PWD}/resources/search"
  test::func fs::listFiles "${PWD}/resources/search" true
  test::func fs::listFiles "${PWD}/resources/search" true true

  # shellcheck disable=SC2317
  fileNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  test::exec declare -f fileNamedHidden
  test::func fs::listFiles "${PWD}/resources/search" true true folderNamedHidden
}

function test_fs::listDirectories() {
  test::title "✅ Testing fs::listDirectories"

  test::func fs::listDirectories "${PWD}/resources/search"
  test::func fs::listDirectories "${PWD}/resources/search" true
  test::func fs::listDirectories "${PWD}/resources/search" true true

  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  test::exec declare -f folderNamedHidden
  test::func fs::listDirectories "${PWD}/resources/search" true true folderNamedHidden
}

main