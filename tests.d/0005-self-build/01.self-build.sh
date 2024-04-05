#!/usr/bin/env bash

function testSelfBuild() {

  createTempFile && local tmpFile="${LAST_RETURNED_VALUE}"

  # setLogLevel "debug"
  selfBuild --output "${tmpFile}" --user-directory "${VALET_HOME}/examples.d"

  local content
  IFS= read -rd '' content < "${tmpFile}" || true
  echo "${content}"

  endTest "Testing selfbuild" 0
}

function main() {
  sourceForFunction selfBuild

  testSelfBuild
}

main