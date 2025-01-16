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
  echo "→ head --lines 40 ${directory}/lib-valet.md"
  io::head "${directory}/lib-valet.md" 40
  echo
  echo "→ head --lines 40 ${directory}/lib-valet"
  io::head "${directory}/lib-valet" 40
  echo
  echo "→ head --lines 40 ${directory}/valet.code-snippets"
  io::head "${directory}/valet.code-snippets" 40

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
