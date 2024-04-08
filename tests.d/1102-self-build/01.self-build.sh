#!/usr/bin/env bash

function testSelfBuild() {
  setTempFilesNumber 500
  io::createTempFile && local tempFile="${LAST_RETURNED_VALUE}"

  ("${_VALET_HOME}/valet.d/commands.d/self-build.sh" --output "${tempFile}" --user-directory "")

  local content
  IFS= read -rd '' content <"${tempFile}" || true
  echo "${content}"

  endTest "Testing selfbuild" 0
}

function main() {
  testSelfBuild

  core::reloadUserCommands
}

main
