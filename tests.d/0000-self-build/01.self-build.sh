#!/usr/bin/env bash

function testSelfBuild() {

  # setLogLevel "debug"
  selfBuild --output "commands" --user-directory ""

  local content
  IFS= read -rd '' content <"commands" || true
  echo "${content}"

  endTest "Testing selfbuild" 0
}

function reloadAllUserCmds() {
  # make sure reload the potentially new commands
  local var
  for var in ${!CMD_*}; do
    unset "${var}"
  done
  unset _CMD_INCLUDED
  sourceUserCommands
}

function main() {
  sourceForFunction selfBuild

  testSelfBuild

  reloadAllUserCmds
}

main
