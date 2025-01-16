#!/usr/bin/env bash

core::sourceFunction "selfAddCommand"
core::sourceFunction "selfAddLibrary"

function test_selfAddLibrary() {
  mkdir -p resources/gitignored

  pushd resources/gitignored &>/dev/null || core::fail "Unable to change directory"

  echo "→ selfAddLibrary 'new-cool-lib'"
  selfAddLibrary 'new-cool-lib'

  echo "→ selfAddLibrary 'new-cool-lib'"
  selfAddLibrary 'new-cool-lib'

  echo
  echo "→ cat commands.d/new-cool-command.sh"
  io::cat "commands.d/new-cool-command.sh"

  popd &>/dev/null || core::fail "Unable to change directory"

  rm -rf resources/gitignored
  test::endTest "Testing selfAddLibrary" 0
}

function test_selfAddCommand() {
  mkdir -p resources/gitignored

  pushd resources/gitignored &>/dev/null || core::fail "Unable to change directory"

  echo "→ selfAddCommand 'new cool command'"
  selfAddCommand 'new cool command'

  echo "→ selfAddCommand 'new cool command'"
  selfAddCommand 'new cool command'

  echo
  echo "→ cat commands.d/new-cool-command.sh"
  io::cat "commands.d/new-cool-command.sh"

  popd &>/dev/null || core::fail "Unable to change directory"

  rm -rf resources/gitignored
  test::endTest "Testing selfAddCommand" 0
}

function main() {
  test_selfAddCommand
  test_selfAddLibrary
}

function interactive::promptYesNo() {
  echo "prompt: $1"
  return 0
}

_OLD_HOME="${HOME}"
HOME="/nop"

main

HOME="${_OLD_HOME}"
core::resetIncludedFiles
source interactive