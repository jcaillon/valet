#!/usr/bin/env bash

core::sourceFunction "selfDocument"
# shellcheck disable=SC1091
source io

function testSelfDocument() {
  io::createTempDirectory
  local directory="${RETURNED_VALUE}"

  echo "→ selfDocument --output ${directory} --core-only"
  selfDocument --output "${directory}" --core-only

  echo
  echo "→ cat ${directory}/lib-valet.md"
  io::cat "${directory}/lib-valet.md"
  echo
  echo "→ cat ${directory}/lib-valet"
  io::cat "${directory}/lib-valet"
  echo
  echo "→ cat ${directory}/.vscode/valet.code-snippets"
  io::cat "${directory}/.vscode/valet.code-snippets"

  test::endTest "Testing selfDocument" 0
}

# hard code the date
function system::date() {
  RETURNED_VALUE="2013-11-10"
}

function core::getVersion() {
  RETURNED_VALUE="1.2.3"
}

function main() {
  testSelfDocument
}

main

core::resetIncludedFiles
source system