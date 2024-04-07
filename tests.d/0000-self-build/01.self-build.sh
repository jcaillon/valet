#!/usr/bin/env bash

function testSelfBuild() {

  # log::setLevel "debug"
  selfBuild --output "commands" --user-directory ""

  local content
  IFS= read -rd '' content <"commands" || true
  echo "${content}"

  endTest "Testing selfbuild" 0
}

function main() {
  core::sourceForFunction selfBuild

  testSelfBuild

  core::reloadUserCommands
}

main
