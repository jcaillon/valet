#!/usr/bin/env bash

function main() {
  test_source
}

function test_source() {
  test::title "✅ Test source"

  test::exec core::resetIncludedFiles

  # shellcheck disable=SC2034
  CMD_LIBRARY_DIRECTORIES=("${PWD}/resources/ext2" "${PWD}/resources/ext1")
  # shellcheck disable=SC2034
  GLOBAL_INSTALLATION_DIRECTORY="${PWD}/resources"

  test::printVars CMD_LIBRARY_DIRECTORIES _CORE_INCLUDED_LIBRARIES

  test::markdown "Including the stuff library twice, expecting to be sourced once."
  test::exec source stuff
  test::exec source stuff
  test::flush

  test::markdown "Including a user defined library."
  test::exec source stuff2
  test::flush

  test::markdown "Including a script using relative path twice, expecting to be sourced once."
  test::exec source resources/script1.sh
  test::exec source resources/script1.sh
  test::flush

  test::markdown "Including a script using an absolute path twice, expecting to be sourced once."
  test::exec source "${PWD}/resources/script1.sh"
  test::exec source "${PWD}/resources/script1.sh"
  test::flush

  test::markdown "Including non existing library."
  test::exit source NOPNOP
  test::flush

  test::printVars _CORE_INCLUDED_LIBRARIES
}

main
