#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-io
source io

function testIo::listPaths() {
  local IFS=$'\n'

  echo "→ io::listPaths \${PWD}/resources/search"
  io::listPaths "${PWD}/resources/search"
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listPaths \${PWD}/resources/search" true
  io::listPaths "${PWD}/resources/search" true
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listPaths \${PWD}/resources/search" false true
  io::listPaths "${PWD}/resources/search" false true
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listPaths \${PWD}/resources/search" true true
  io::listPaths "${PWD}/resources/search" true true
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }
  echo 'fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }'
  echo "→ io::listPaths \${PWD}/resources/search" true true fileNamedFile
  io::listPaths "${PWD}/resources/search" true true fileNamedFile
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  echo 'fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }'
  echo "→ io::listPaths \${PWD}/resources/search" true true '' folderNamedHidden
  io::listPaths "${PWD}/resources/search" true true '' folderNamedHidden
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  test::endTest "Testing io::listPaths" 0
}

function testIo::listFiles() {
  local IFS=$'\n'

  echo "→ io::listFiles \${PWD}/resources/search"
  io::listFiles "${PWD}/resources/search"
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listFiles \${PWD}/resources/search" true
  io::listFiles "${PWD}/resources/search" true
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listFiles \${PWD}/resources/search" true true
  io::listFiles "${PWD}/resources/search" true true
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  echo 'fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }'
  echo "→ io::listFiles \${PWD}/resources/search" true true folderNamedHidden
  io::listFiles "${PWD}/resources/search" true true folderNamedHidden
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  test::endTest "Testing io::listFiles" 0
}

function testIo::listDirectories() {
  local IFS=$'\n'

  echo "→ io::listDirectories \${PWD}/resources/search"
  io::listDirectories "${PWD}/resources/search"
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listDirectories \${PWD}/resources/search" true
  io::listDirectories "${PWD}/resources/search" true
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  echo "→ io::listDirectories \${PWD}/resources/search" true true
  io::listDirectories "${PWD}/resources/search" true true
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  echo
  folderNamedHidden() { if [[ ${1##*/} == *hidden* ]]; then return 0; else return 1; fi; }
  echo 'fileNamedFile() { if [[ ${1##*/} =~ ^file[[:digit:]]+$ ]]; then return 0; else return 1; fi; }'
  echo "→ io::listDirectories \${PWD}/resources/search" true true folderNamedHidden
  io::listDirectories "${PWD}/resources/search" true true folderNamedHidden
  specialArraySort RETURNED_ARRAY
  echo "${RETURNED_ARRAY[*]}"

  test::endTest "Testing io::listDirectories" 0
}

function specialArraySort() {
  local -n array=${1}
  local -i i j
  local temp
  for ((i = 0; i < ${#array[@]}; i++)); do
    for ((j = i + 1; j < ${#array[@]}; j++)); do
      if [[ ( ${array[i]} != "."* && ${array[j]} == "."* ) || ${array[i]} > ${array[j]} ]]; then
        temp="${array[i]}"
        array[i]="${array[j]}"
        array[j]="${temp}"
      fi
    done
  done
}

function main() {
  testIo::listPaths
  testIo::listFiles
  testIo::listDirectories
}

main