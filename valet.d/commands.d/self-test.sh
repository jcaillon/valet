#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
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
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  # set the options
  unset TEST_AUTO_APPROVE \
    TEST_INCLUDE_PATTERN \
    TEST_EXCLUDE_PATTERN
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

  declare -i NB_TEST_SUITES=0 NB_FAILED_TEST_SUITES=0

  if [[ ${onlyCore:-false} != "true" ]]; then
    # get the user directory
    core::getUserDirectory
    userDirectory="${userDirectory:-${RETURNED_VALUE}}"

    # rebuild the commands for the user dir
    log::info "Rebuilding the commands for the user directory ⌜${userDirectory}⌝."
    rebuildCommands "${userDirectory}"

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

          runTestSuites "${testsDirectory}"
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

  if [[ -n "${withCore:-}" || ${onlyCore:-false} == "true" ]]; then
    runCoreTests
  fi

  if [[ NB_FAILED_TEST_SUITES -gt 0 ]]; then
    local failMessage
    failMessage="A total of ⌜${NB_FAILED_TEST_SUITES}⌝/⌜${NB_TEST_SUITES}⌝ test(s) failed."
    if [[ ${TEST_AUTO_APPROVE:-false} == "true" ]]; then
      failMessage+=$'\n'"The received test result files were automatically approved."
      log::warning "${failMessage}"
    else
      failMessage+=$'\n'"You should review the difference in the logs above or by comparing each ⌜**.received.md⌝ files with ⌜**.approved.md⌝ files."
      failMessage+=$'\n'"If the differences are legitimate, then approve the changes by running this command again with the option ⌜-a⌝."
      core::fail "${failMessage}"
    fi
  elif [[ NB_TEST_SUITES -gt 0 ]]; then
    log::success "A total of ⌜${NB_TEST_SUITES}⌝ tests passed!"
  else
    log::warning "No elligible test suites found."
  fi
}
