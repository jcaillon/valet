#!/usr/bin/env bash

command::sourceFunction "selfAddLibrary"

function main() {
  test::title "✅ Testing self add-library"

  HOME="/nop"
  mkdir -p resources/gitignored

  pushd resources/gitignored &>/dev/null || test::fail "Unable to change directory"

  test::exec selfAddLibrary 'new-cool-lib'
  test::exec selfAddLibrary 'new-cool-lib'
  test::exec fs::cat "libraries.d/lib-new-cool-lib"

  popd &>/dev/null || test::fail "Unable to change directory"

  rm -rf resources/gitignored
}

function interactive::confirm() {
  echo "🙈 mocking interactive::confirm $*"
  return 0
}

main
