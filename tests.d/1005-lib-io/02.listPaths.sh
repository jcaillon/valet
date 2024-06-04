#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-io
source io

function testIo::listPaths() {
  local IFS=$'\n'

  echo "→ io::listPaths \${PWD}/resources/search"
  io::listPaths "${PWD}/resources/search" && echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listPaths \${PWD}/resources/search" true
  io::listPaths "${PWD}/resources/search" true && echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listPaths \${PWD}/resources/search" false true
  io::listPaths "${PWD}/resources/search" false true && echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listPaths \${PWD}/resources/search" true true
  io::listPaths "${PWD}/resources/search" true true && echo "${RETURNED_ARRAY[*]}"

  echo
  fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }
  echo 'fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }'
  echo "→ io::listPaths \${PWD}/resources/search" true true fileNamedFile
  io::listPaths "${PWD}/resources/search" true true fileNamedFile && echo "${RETURNED_ARRAY[*]}"

  echo
  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  echo 'fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }'
  echo "→ io::listPaths \${PWD}/resources/search" true true '' folderNamedHidden
  io::listPaths "${PWD}/resources/search" true true '' folderNamedHidden && echo "${RETURNED_ARRAY[*]}"

  test::endTest "Testing io::listPaths" 0
}

function main() {
  testIo::listPaths
}

main