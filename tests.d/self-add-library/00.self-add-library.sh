#!/usr/bin/env bash

core::sourceFunction "selfAddLibrary"

function main() {
  test::title "✅ Testing self add-library"

  HOME="/nop"
  mkdir -p resources/gitignored

  pushd resources/gitignored &>/dev/null || test::fail "Unable to change directory"

  test::exec selfAddLibrary 'new-cool-lib'
  test::exec selfAddLibrary 'new-cool-lib'
  test::exec io::cat "libraries.d/lib-new-cool-lib"

  popd &>/dev/null || test::fail "Unable to change directory"

  rm -rf resources/gitignored
}

function interactive::promptYesNo() {
  echo "🙈 mocking interactive::promptYesNo $*"
  return 0
}

main
