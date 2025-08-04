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
  test::func fs::listPaths "${PWD}/resources/search" recursive=true
  test::func fs::listPaths "${PWD}/resources/search" includeHidden=true
  test::func fs::listPaths "${PWD}/resources/search" recursive=true includeHidden=true

  fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }
  test::exec declare -f fileNamedFile
  test::func fs::listPaths "${PWD}/resources/search" recursive=true includeHidden=true filter=fileNamedFile

  # shellcheck disable=SC2317
  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  test::exec declare -f folderNamedHidden
  test::func fs::listPaths "${PWD}/resources/search" recursive=true includeHidden=true filter=folderNamedHidden
}

function test_fs::listFiles() {
  test::title "✅ Testing fs::listFiles"

  test::func fs::listFiles "${PWD}/resources/search"
  test::func fs::listFiles "${PWD}/resources/search" recursive=true
  test::func fs::listFiles "${PWD}/resources/search" recursive=true includeHidden=true

  # shellcheck disable=SC2317
  fileNamedContainsHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  test::exec declare -f fileNamedContainsHidden
  test::func fs::listFiles "${PWD}/resources/search" recursive=true includeHidden=true filter=fileNamedContainsHidden
}

function test_fs::listDirectories() {
  test::title "✅ Testing fs::listDirectories"

  test::func fs::listDirectories "${PWD}/resources/search"
  test::func fs::listDirectories "${PWD}/resources/search" recursive=true
  test::func fs::listDirectories "${PWD}/resources/search" recursive=true includeHidden=true

  folderNamedContainsHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  test::exec declare -f folderNamedContainsHidden
  test::func fs::listDirectories "${PWD}/resources/search" recursive=true includeHidden=true filter=folderNamedContainsHidden
}

main