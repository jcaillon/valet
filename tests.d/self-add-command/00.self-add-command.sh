#!/usr/bin/env bash

command::sourceFunction "selfAddCommand"

function main() {
  test::title "✅ Testing self add-command"

  HOME="/nop"
  mkdir -p resources/gitignored

  pushd resources/gitignored &>/dev/null || test::fail "Unable to change directory"

  test::exec selfAddCommand 'new cool command'
  test::exec selfAddCommand 'new cool command'
  test::cat "commands.d/new-cool-command.sh"

  popd &>/dev/null || test::fail "Unable to change directory"

  rm -rf resources/gitignored
}

function interactive::confirm() {
  echo "🙈 mocking interactive::confirm $*"
  return 0
}

main
