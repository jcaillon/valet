#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-io
source io

function testIo::listPaths() {
  local IFS=$'\n'

  echo "→ io::listPaths \${PWD}/resources/search"
  io::listPaths "${PWD}/resources/search"
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listPaths \${PWD}/resources/search" true
  io::listPaths "${PWD}/resources/search" true
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listPaths \${PWD}/resources/search" false true
  io::listPaths "${PWD}/resources/search" false true
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listPaths \${PWD}/resources/search" true true
  io::listPaths "${PWD}/resources/search" true true
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }
  echo 'fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }'
  echo "→ io::listPaths \${PWD}/resources/search" true true fileNamedFile
  io::listPaths "${PWD}/resources/search" true true fileNamedFile
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  echo 'fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }'
  echo "→ io::listPaths \${PWD}/resources/search" true true '' folderNamedHidden
  io::listPaths "${PWD}/resources/search" true true '' folderNamedHidden
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  test::endTest "Testing io::listPaths" 0
}

function testIo::listFiles() {
  local IFS=$'\n'

  echo "→ io::listFiles \${PWD}/resources/search"
  io::listFiles "${PWD}/resources/search"
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listFiles \${PWD}/resources/search" true
  io::listFiles "${PWD}/resources/search" true
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listFiles \${PWD}/resources/search" true true
  io::listFiles "${PWD}/resources/search" true true
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  echo 'fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }'
  echo "→ io::listFiles \${PWD}/resources/search" true true folderNamedHidden
  io::listFiles "${PWD}/resources/search" true true folderNamedHidden
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  test::endTest "Testing io::listFiles" 0
}

function testIo::listDirectories() {
  local IFS=$'\n'

  echo "→ io::listDirectories \${PWD}/resources/search"
  io::listDirectories "${PWD}/resources/search"
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listDirectories \${PWD}/resources/search" true
  io::listDirectories "${PWD}/resources/search" true
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listDirectories \${PWD}/resources/search" true true
  io::listDirectories "${PWD}/resources/search" true true
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  echo 'fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }'
  echo "→ io::listDirectories \${PWD}/resources/search" true true folderNamedHidden
  io::listDirectories "${PWD}/resources/search" true true folderNamedHidden
  array::sort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  test::endTest "Testing io::listDirectories" 0
}

function main() {
  local original_lc_all=${LC_ALL:-}
  # make sure the sort is consistent!
  LC_ALL=C
  testIo::listPaths
  testIo::listFiles
  testIo::listDirectories
  unset LC_ALL
  if [[ -n ${original_lc_all} ]]; then
    export LC_ALL=${original_lc_all}
  fi
}

main