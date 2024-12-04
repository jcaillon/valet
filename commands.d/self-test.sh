#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../libraries.d/core
  source "$(dirname -- "$(command -v valet)")/libraries.d/core"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=self-test-utils
source self-test-utils
# shellcheck source=../libraries.d/lib-string
source string

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
- name: -C, --core-only
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
- name: -P, --no-parallel-tests
  description: |-
    Disable the default behavior of running the tests in parallel. Will run the tests sequentially.
examples:
- name: self test
  description: |-
    Run all the tests found in the valet user directory.
- name: self test -a
  description: |-
    Run all the tests found in the valet user directory and automatically approve the results.
- name: self test -i '(my-thing|my-stuff)'
  description: |-
    Run only the test suites that match the regex pattern ⌜(my-thing|my-stuff)⌝.
---"
function selfTest() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  # can't have the profiler on
  if command -v profiler::disable &> /dev/null; then
    profiler::disable
  fi

  local startTime="${EPOCHREALTIME}"

  # set global variables that can be evaluated to export vars/functions in a way that
  # we have consistent results in the test suites
  selfTestUtils_setupDiffCommand
  selfTestUtils_setEvalVariables

  # set the options
  unset TEST_AUTO_APPROVE \
    TEST_INCLUDE_PATTERN \
    TEST_EXCLUDE_PATTERN \
    TEST_NO_PARALLEL_TESTS
  if [[ -n "${autoApprove:-}" ]]; then
    TEST_AUTO_APPROVE="true"
  fi
  if [[ -n "${include:-}" ]]; then
    log::info "Including only test suites that match the pattern ⌜${include}⌝."
    TEST_INCLUDE_PATTERN="${include}"
  fi
  if [[ -n "${exclude:-}" ]]; then
    log::info "Excluding all test suites that match the pattern ⌜${exclude}⌝."
    TEST_EXCLUDE_PATTERN="${exclude}"
  fi
  if [[ -n "${noParallelTests:-}" ]]; then
    log::info "Running all tests sequentially."
    TEST_NO_PARALLEL_TESTS="true"
  fi

  declare -i NB_TEST_SUITES=0 NB_FAILED_TEST_SUITES=0

  if [[ ${coreOnly:-false} != "true" ]]; then
    # get the user directory
    core::getUserDirectory
    userDirectory="${userDirectory:-${RETURNED_VALUE}}"

    # rebuild the commands for the user dir
    log::info "Rebuilding the commands for the user directory ⌜${userDirectory}⌝."
    selfTestUtils_rebuildCommands --user-directory "${userDirectory}"

    # change the shell options to include hidden files
    shopt -s dotglob
    local testsDirectory listOfDirectories currentDirectory

    # the shopt globstar does not include files under symbolic link directories
    # so we need to manually force the search in these directories
    listOfDirectories="${userDirectory}"$'\n'
    while [[ -n "${listOfDirectories}" ]]; do
      currentDirectory="${listOfDirectories%%$'\n'*}"
      listOfDirectories="${listOfDirectories#*$'\n'}"
      log::trace "Searching for test suites directory in ⌜${currentDirectory}⌝."
      log::trace "listOfDirectories: ⌜${listOfDirectories}⌝."
      for testsDirectory in "${currentDirectory}"/*; do
        if [[ ! -d "${testsDirectory}" ]]; then
          # if the directory is not a directory, skip
          continue
        elif [[ ${testsDirectory} == *"/tests.d" ]]; then
          # if the directory is named .tests.d, then it is a test directory
          log::info "Running all test suites in directory ⌜${testsDirectory}⌝."

          # we should always run the test suite from the user directory to have consistent paths
          # in the report files
          pushd "${testsDirectory}" 1> /dev/null

          selfTestUtils_runTestSuites "${testsDirectory}"
          popd 1> /dev/null
        elif [[ ${testsDirectory##*/} != "."* ]]; then
          # we need the directory to the search list except if it starts with a .
          listOfDirectories+="${testsDirectory}"$'\n'
          log::trace "adding directory ⌜${testsDirectory}⌝ to the search list."
        fi
      done
    done

    # reset glob options
    shopt -u dotglob
  fi

  if [[ -n "${withCore:-}" || ${coreOnly:-false} == "true" ]]; then
    selfTestRunCoreTests
  fi

  string::microsecondsToHuman $((${EPOCHREALTIME//./} - ${startTime//./})) "%S seconds and %l ms"
  log::info "Total time running tests: ⌜${RETURNED_VALUE}⌝."

  if [[ NB_FAILED_TEST_SUITES -gt 0 ]]; then
    local failMessage
    failMessage="A total of ⌜${NB_FAILED_TEST_SUITES}⌝/⌜${NB_TEST_SUITES}⌝ test(s) failed."
    if [[ ${TEST_AUTO_APPROVE:-false} == "true" ]]; then
      failMessage+=$'\n'"The received test result files were automatically approved."
      log::warning "${failMessage}"
    else
      failMessage+=$'\n'"Check for eventual test errors in the logs above."
      failMessage+=$'\n'"You should review the difference in the logs above or by manually comparing each ⌜**.received.md⌝ files with ⌜**.approved.md⌝ files."
      failMessage+=$'\n'"If the differences are legitimate, then approve the changes by running this command again with the option ⌜-a⌝."
      core::fail "${failMessage}"
    fi
  elif [[ NB_TEST_SUITES -gt 0 ]]; then
    log::success "A total of ⌜${NB_TEST_SUITES}⌝ tests passed!"
  else
    log::warning "No eligible test suites found."
  fi
}

# Allows to run the core tests of Valet (tests.d directory in the repo) as
# well as the examples (examples.d in the repo).
function selfTestRunCoreTests() {
  if [[ ! -d "${GLOBAL_VALET_HOME}/tests.d" ]]; then
    core::fail "The valet core tests directory ⌜${GLOBAL_VALET_HOME}/tests.d⌝ does not exist, cannot run core tests."
  fi

  # we need to rebuild the commands for the core commands only
  selfTestUtils_rebuildCommands --core-only --no-output

  # we should always run the test suite from the valet home directory to have consistent paths
  # in the report files
  pushd "${GLOBAL_VALET_HOME}" 1>/dev/null

  log::info "Running all test suites in directory ⌜${GLOBAL_VALET_HOME}/tests.d⌝."
  selfTestUtils_runTestSuites "${GLOBAL_VALET_HOME}/tests.d"

  # now we can also test the commands in examples.d if the directory is there
  if [[ ! -d "${GLOBAL_VALET_HOME}/examples.d" ]]; then
    log::warning "The valet examples directory ⌜${GLOBAL_VALET_HOME}/examples.d⌝ does not exist, cannot run the tests on the core examples."
  else
    # we need to rebuild the commands for the examples only
    selfTestUtils_rebuildCommands --user-directory "${GLOBAL_VALET_HOME}/examples.d" --no-output

    log::info "Running all test suites in directory ⌜${GLOBAL_VALET_HOME}/examples.d⌝."
    selfTestUtils_runTestSuites "${GLOBAL_VALET_HOME}/examples.d/showcase/tests.d"
  fi

  popd 1>/dev/null

  # reload the original commands
  core::reloadUserCommands
}
