#!/usr/bin/env bash

function testSelfBuild() {

  # log::setLevel "debug"
  "${VALET_HOME}/valet.d/commands.d/self-build.sh" --output "commands" --user-directory ""

  local content
  IFS= read -rd '' content <"commands" || true
  echo "${content}"

  endTest "Testing selfbuild" 0
}

function main() {
  testSelfBuild

  core::reloadUserCommands
}

main
