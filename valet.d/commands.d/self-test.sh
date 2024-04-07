#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet)
if [[ -z "${_CORE_INCLUDED:-}" ]]; then
  VALETD_DIR="${BASH_SOURCE[0]}"
  if [[ "${VALETD_DIR}" != /* ]]; then
    if pushd "${VALETD_DIR%/*}" &>/dev/null; then VALETD_DIR="${PWD}"; popd &>/dev/null || true;
    else VALETD_DIR="${PWD}"; fi
  else VALETD_DIR="${VALETD_DIR%/*}"; fi
  # shellcheck source=../core
  source "${VALETD_DIR%/*}/core"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=self-test-utils
source self-test-utils

#===============================================================
# >>> command: self test
#===============================================================
: "---
command: self test
function: selfTest
author: github.com/jcaillon
shortDescription: Test your valet custom commands.
description: |-
  Test your valet custom commands using approval tests approach.
options:
- name: -d, --user-directory <path>
  description: |-
    The path to your valet directory.

    Each sub directory named ⌜.tests.d⌝ will be considered as a test directory containing a test.sh file.
- name: -a, --auto-approve
  description: |-
    The received test result files will automatically be approved.
- name: -c, --with-core
  description: |-
    Also test the valet core functions.

    This is only if you modified valet core functions themselves.
- name: -C, --only-core
  description: |-
    Only test the valet core functions. Skips the tests for user commands.
- name: -i, --include <pattern>
  description: |-
    A regex pattern to include only the test suites that match the pattern.

    The name of the test suite is given by the name of the directory containing the .sh test files.

    Example: --include '(1|commands)'
- name: -e, --exclude <pattern>
  description: |-
    A regex pattern to exclude all the test suites that match the pattern.

    The name of the test suite is given by the name of the directory containing the .sh test files.

    Example: --exclude '(1|commands)'
---"
function selfTest() {
  core::parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  setGlobalOptions

  if [[ ${onlyCore:-false} == "true" ]]; then
    runCoreTests
    return
  fi

  # get the directory containing the tests for the commands
  core::getUserDirectory
  userDirectory="${userDirectory:-${LAST_RETURNED_VALUE}}"
  log::debug "User directory is ⌜${userDirectory}⌝."

  # change the shell options to include hidden files
  shopt -s dotglob
  shopt -s globstar

  local testsDirectory
  for testsDirectory in "${userDirectory}"/**; do
    log::debug "Tests directory: ⌜${testsDirectory}⌝."
    # if the directory is not a directory, skip
    if [[ ! -d "${testsDirectory}" ]]; then continue; fi
    # if the directory is named .tests.d, then it is a test directory
    if [[ ${testsDirectory} == *"/tests.d" ]]; then
      log::info "Running all test suites in directory ⌜${testsDirectory}⌝."
      runTestSuites "${testsDirectory}"
    fi
  done

  # reset glob options
  shopt -u dotglob
  shopt -u globstar

  if [[ -n "${withCore:-}" ]]; then
    runCoreTests
  fi
}
