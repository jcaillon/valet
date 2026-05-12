#!/usr/bin/env bash

command::sourceFunction "extensionsAddLibrary"

function main() {
  test::title "✅ Testing extensions add-library"

  HOME="/nop"
  mkdir -p resources/gitignored

  pushd resources/gitignored &>/dev/null || test::fail "Unable to change directory"

  test::exec extensionsAddLibrary 'new-cool-lib'
  test::exec extensionsAddLibrary 'new-cool-lib'
  test::cat "libraries.d/lib-new-cool-lib"

  popd &>/dev/null || test::fail "Unable to change directory"

  rm -rf resources/gitignored
}

function interactive::confirm() {
  echo "🙈 mocking interactive::confirm $*"
  return 0
}

main
