#!/usr/bin/env bash

core::sourceFunction "selfUpdate"

function testSelfUpdateDocumentation() {
  echo "→ valet self update --help"
  (selfUpdate --help)
  test::endTest "Install script usage" 0
}

function testSelfUpdateNothingToDo() {
  local -i exitCode

  log::setLevel success
  echo "→ selfUpdate --skip-extensions-update"
  selfUpdate --skip-extensions-update && exitCode=0 || exitCode=$?
  test::endTest "Testing selfUpdate, nothing to do (already up to date)" ${exitCode}
  log::setLevel info
}


# function testSelfInstall() {
#   local -i exitCode

#   echo "→ SelfUpdate --no-shim --no-path --no-examples --no-extras --skip-extensions-update"
#   SelfUpdate --no-shim --no-path --no-examples --no-extras --skip-extensions-update && exitCode=0 || exitCode=$?
#   test::endTest "Testing SelfUpdate, dry run major version" ${exitCode}
# }

function main() {
  testSelfUpdateDocumentation
  testSelfUpdateNothingToDo
  # testSelfInstall
}

main

core::resetIncludedFiles