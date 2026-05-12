#!/usr/bin/env bash

command::sourceFunction "extensionsAddCommand"

function main() {
  test::title "✅ Testing extensions add-command"

  HOME="/nop"
  mkdir -p resources/gitignored

  pushd resources/gitignored &>/dev/null || test::fail "Unable to change directory"

  test::exec extensionsAddCommand 'new cool command'
  test::exec extensionsAddCommand 'new cool command'
  test::cat "commands.d/new-cool-command.sh"

  popd &>/dev/null || test::fail "Unable to change directory"

  rm -rf resources/gitignored
}

function interactive::confirm() {
  echo "🙈 mocking interactive::confirm $*"
  return 0
}

main
