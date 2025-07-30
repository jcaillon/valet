#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ ! -v GLOBAL_CORE_INCLUDED ]]; then
  # shellcheck source=../libraries.d/core
  source "$(valet --source)"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=self-test-utils
source self-test-utils
# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-progress
source progress
# shellcheck source=../libraries.d/lib-bash
source bash
# shellcheck source=../libraries.d/lib-coproc
source coproc
# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-time
source time

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
- name: -d, --extensions-directory <path>
  description: |-
    The path to your valet extensions directory.

    Each sub directory named ⌜.tests.d⌝ in an extension will be considered as a test directory containing a test.sh file.
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
    A regex pattern to include only the test suites (path) that match the pattern.

    The name of the test suite is given by the name of the directory containing the .sh test files.

    Example: --include '(1|commands)'
- name: -e, --exclude <pattern>
  description: |-
    A regex pattern to exclude all the test suites (path) that match the pattern.

    The name of the test suite is given by the name of the directory containing the .sh test files.

    Example: --exclude '(1|commands)'
- name: -p, --parallel-test-suites <number>
  default: 8
  description: |-
    The number of test suites to run in parallel.
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
  command::parseArguments "$@" && eval "${REPLY}"
  command::checkParsedResults

  time::getProgramElapsedMicroseconds
  local startTimeInMicroSeconds="${REPLY}"

  # set the options
  unset _TEST_AUTO_APPROVE \
    _TEST_INCLUDE_PATTERN \
    _TEST_EXCLUDE_PATTERN
  if [[ -n ${autoApprove:-} ]]; then
    _TEST_AUTO_APPROVE="true"
  fi
  if [[ -n ${include:-} ]]; then
    log::info "Including only test suites that match the pattern ⌜${include}⌝."
    _TEST_INCLUDE_PATTERN="${include}"
  fi
  if [[ -n ${exclude:-} ]]; then
    log::info "Excluding all test suites that match the pattern ⌜${exclude}⌝."
    _TEST_EXCLUDE_PATTERN="${exclude}"
  fi
  _TEST_NB_PARALLEL_TEST_SUITES="${parallelTestSuites:-}"
  log::debug "Running up to ⌜${_TEST_NB_PARALLEL_TEST_SUITES}⌝ test suites in parallel."

  # check what will be used to display the diff between received and approved files
  selfTestUtils_setupDiffCommand

  selfTestUtils_prepareModifiedTrapFunctions

  GLOBAL_TEST_IMPLEMENTATION_FAILURE_STATUS=141
  GLOBAL_TEST_APPROVAL_FAILURE_STATUS=142
  declare -g -i _TEST_FAILURE_STATUS=0
  declare -g -a _TEST_FAILED_TEST_SUITES=()

  # prepare a list of all the test suites to run (with extra info for each test suite)
  log::info "Listing all test suites to run."

  progress::start "<spinner>"

  local -a \
    _TEST_TEST_SUITE_NAME=() \
    _TEST_TEST_SUITE_DIRECTORY=() \
    _TEST_COMMAND=()

  local tempUserDataDirectory

  # test suites in the user directory
  if [[ ${coreOnly:-false} != "true" ]]; then
    fs::createTempDirectory
    tempUserDataDirectory="${REPLY}"

    core::getExtensionsDirectory
    extensionsDirectory="${extensionsDirectory:-${REPLY}}"

    # rebuild the commands for the user dir
    selfTestUtils_rebuildCommands --extensions-directory "${extensionsDirectory}" --output "${tempUserDataDirectory}"

    fs::listDirectories "${extensionsDirectory}"
    local extensionDirectory
    for extensionDirectory in "${REPLY_ARRAY[@]}"; do
      if [[ -d ${extensionDirectory}/tests.d ]]; then
        selfTest_addTestSuites "${extensionDirectory}/tests.d" "${tempUserDataDirectory}"
      fi
    done
  fi

  # core test suites
  if [[ -n ${withCore:-} || ${coreOnly:-false} == "true" ]]; then
    if [[ ! -d ${GLOBAL_INSTALLATION_DIRECTORY}/tests.d ]]; then
      core::fail "The valet core tests directory ⌜${GLOBAL_INSTALLATION_DIRECTORY}/tests.d⌝ does not exist, cannot run core tests."
    fi

    # we need to rebuild the commands for the core commands only
    fs::createTempDirectory
    tempUserDataDirectory="${REPLY}"

    selfTestUtils_rebuildCommands --core-only --include-showcase --output "${tempUserDataDirectory}"
    selfTest_addTestSuites "${GLOBAL_INSTALLATION_DIRECTORY}/tests.d" "${tempUserDataDirectory}"

    # now we can also test the commands in showcase.d if the directory is there
    if [[ ! -d ${GLOBAL_INSTALLATION_DIRECTORY}/showcase.d ]]; then
      log::warning "The valet showcase directory ⌜${GLOBAL_INSTALLATION_DIRECTORY}/showcase.d⌝ does not exist, cannot run the tests on the core showcase."
    else
      selfTest_addTestSuites "${GLOBAL_INSTALLATION_DIRECTORY}/showcase.d/tests.d" "${tempUserDataDirectory}"
    fi
  fi

  progress::stop

  time::getProgramElapsedMicroseconds
  local runStartTimeInMicroSeconds="${REPLY}"
  time::convertMicrosecondsToHuman $((REPLY - startTimeInMicroSeconds)) "%S seconds and %l ms"
  log::info "Found ${#_TEST_TEST_SUITE_NAME[@]} test suites in ⌜${REPLY}⌝."

  # run all tests suites
  progress::start
  progress::update 0 "Running test suites."

  _OPTION_MAX_IN_PARALLEL=${_TEST_NB_PARALLEL_TEST_SUITES} \
  _OPTION_COMPLETED_CALLBACK=selfTest_parallelCallback \
  _OPTION_PRINT_REDIRECTED_LOGS=true \
    coproc::runInParallel _TEST_COMMAND

  progress::stop

  time::getProgramElapsedMicroseconds
  time::convertMicrosecondsToHuman $((REPLY - runStartTimeInMicroSeconds)) "%S seconds and %l ms"
  log::info "Total time running tests: ⌜${REPLY}⌝."

  if ((${#_TEST_FAILED_TEST_SUITES[@]} > 0)); then
    local failMessage
    failMessage="A total of ⌜${#_TEST_FAILED_TEST_SUITES[@]}⌝ out of ${#_TEST_TEST_SUITE_NAME[@]} test(s) failed:"$'\n'
    local treeString="  ├─" treePadding="  │  " failedTestSuite
    local -i nb=0
    for failedTestSuite in "${_TEST_FAILED_TEST_SUITES[@]}"; do
      if ((nb == ${#_TEST_FAILED_TEST_SUITES[@]} - 1)); then
        treeString="  ╰─"
        treePadding="     "
      fi
      failMessage+=$'\n'"- ⌜${failedTestSuite}⌝."
      nb+=1
    done
    if [[ ${_TEST_AUTO_APPROVE:-false} == "true" ]]; then
      failMessage+=$'\n'$'\n'"The received test result files were automatically approved."
      failMessage+=$'\n'"Run the tests again to verify that they pass."
      log::warning "${failMessage}"
    else
      failMessage+=$'\n'$'\n'"Check for the test errors in the logs above."
      if ((_TEST_FAILURE_STATUS == GLOBAL_TEST_APPROVAL_FAILURE_STATUS)); then
        failMessage+=$'\n'$'\n'"You should review the difference in the logs above or by manually comparing each ⌜**.received.md⌝ files with ⌜**.approved.md⌝ files."
        failMessage+=$'\n'$'\n'"If the differences are OK, approve the changes by running this command again with the option ⌜-a⌝."
      fi
      core::fail "${failMessage}"
    fi
  elif (( ${#_TEST_TEST_SUITE_NAME[@]} > 0)); then
    log::success "A total of ⌜${#_TEST_TEST_SUITE_NAME[@]}⌝ tests passed!"
  else
    log::warning "No eligible test suites found."
  fi
}

# ## selfTest_addTestSuites
#
# Add all the test suites in the given `tests.d` directory to the global test suite lists.
function selfTest_addTestSuites() {
  local testsDotDirectory="${1}"
  local testUserDataDirectory="${2}"
  log::debug "Adding all test suites in directory ⌜${testsDotDirectory}⌝."

  # make a list of all test suite directories
  _OPTION_FILTER=selfTest_filterTestSuiteDirectories fs::listPaths "${testsDotDirectory}"

  if ((${#REPLY_ARRAY[@]} == 0)); then
    log::info "No matching test suites found in directory ⌜${testsDotDirectory}⌝."
    return 0
  fi
  log::info "Found ⌜${#REPLY_ARRAY[@]}⌝ test suites from directory ⌜${testsDotDirectory}⌝."

  local testDirectory
  for testDirectory in "${REPLY_ARRAY[@]}"; do
    _TEST_TEST_SUITE_NAME+=("${testDirectory##*/}")
    _TEST_TEST_SUITE_DIRECTORY+=("${testDirectory}")
    _TEST_COMMAND+=("selfTest_runSingleTestSuite '${testDirectory}' '${testUserDataDirectory}'")
  done
}

# ## selfTest_filterTestSuiteDirectories
#
# Filter function for the test suite directories.
function selfTest_filterTestSuiteDirectories() {
  local testDirectory="${1}"

  # skip if not a directory or hidden dir
  if [[ ! -d ${testDirectory} ]]; then
    return 1
  fi

  # skip if the test directory does not match the include pattern
  if [[ -n ${_TEST_INCLUDE_PATTERN:-} && ! (${testDirectory} =~ ${_TEST_INCLUDE_PATTERN}) ]]; then
    log::debug "Skipping test ⌜${testDirectory}⌝ because it does not match the include pattern."
    return 1
  fi

  # skip if the test directory matches the exclude pattern
  if [[ -n ${_TEST_EXCLUDE_PATTERN:-} && ${testDirectory} =~ ${_TEST_EXCLUDE_PATTERN} ]]; then
    log::debug "Skipping test ⌜${testDirectory}⌝ because it matches the exclude pattern."
    return 1
  fi
}

# ## selfTest_parallelCallback
#
# Callback function for the parallel run of test suites.
# Called when a test suite is completed (either successfully or not).
#
# It updates the progress bar and displays the output of the test suite.
function selfTest_parallelCallback() {
  local -i index="${1}"
  local -i exitCode="${2}"
  local -i percent="${3}"

  progress::update "${percent}" "Done running test suite ⌜${_TEST_TEST_SUITE_NAME[index]}⌝."

  if (( exitCode != 0 )); then
    _TEST_FAILED_TEST_SUITES+=("${_TEST_TEST_SUITE_NAME[index]}")
    if (( exitCode > _TEST_FAILURE_STATUS )); then
      _TEST_FAILURE_STATUS="${exitCode}"
    fi
  fi
  REPLY=0
}

# ## selfTest_runSingleTestSuite
#
# Run a single test suite.
#
# - $1: the directory containing the test suite
#
function selfTest_runSingleTestSuite() {
  GLOBAL_TEST_SUITE_DIRECTORY="${1}"
  local testUserDataDirectory="${2}"

  GLOBAL_TESTS_D_DIRECTORY="${GLOBAL_TEST_SUITE_DIRECTORY%/*}"
  GLOBAL_TEST_SUITE_NAME="${GLOBAL_TEST_SUITE_DIRECTORY##*/}"

  log::debug "Running test suite ⌜${GLOBAL_TEST_SUITE_DIRECTORY}⌝."

  # make a list of all test scripts
  local -a testScripts=()
  local testScript IFS=' '
  for testScript in "${GLOBAL_TEST_SUITE_DIRECTORY}"/*.sh; do
    # skip if not a file
    if [[ ! -f "${testScript}" ]]; then
      continue
    fi
    testScripts+=("${testScript}")
  done

  if ((${#testScripts[@]} == 0)); then
    log::info "No test scripts found in test suite ⌜${GLOBAL_TEST_SUITE_DIRECTORY}⌝."
    return 0
  fi

  GLOBAL_TEST_BASE_TEMPORARY_DIRECTORY="${GLOBAL_TEMPORARY_DIRECTORY}/tmp-${BASHPID}.${GLOBAL_TEST_SUITE_NAME:0:7}"
  GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY="${GLOBAL_TEMPORARY_DIRECTORY}/output-${BASHPID}.${GLOBAL_TEST_SUITE_NAME:0:7}"
  GLOBAL_TEST_STANDARD_OUTPUT_FILE="${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}/stdout"
  GLOBAL_TEST_STANDARD_ERROR_FILE="${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}/stderr"
  GLOBAL_TEST_REPORT_FILE="${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}/report"
  GLOBAL_TEST_STACK_FILE="${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}/stack"
  GLOBAL_TEST_LOG_FILE="${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}/log"
  mkdir -p "${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}"
  exec {GLOBAL_FD_TEST_LOG}>"${GLOBAL_TEST_LOG_FILE}"

  # write the test suite title
  printf "%s\n\n" "# Test suite ${GLOBAL_TEST_SUITE_NAME}" >"${GLOBAL_TEST_REPORT_FILE}"

  # run the test scripts
  log::info "⌜${GLOBAL_TEST_SUITE_NAME}⌝:"
  local treeString="  ├─" treePadding="  │  "
  local -i nbScriptsDone=0
  for testScript in "${testScripts[@]}"; do
    GLOBAL_TEST_SUITE_SCRIPT_NAME="${testScript##*/}"
    if ((nbScriptsDone == ${#testScripts[@]} - 1)); then
      treeString="  ╰─"
      treePadding="     "
    fi
    log::printString "${treeString} ${GLOBAL_TEST_SUITE_SCRIPT_NAME}" "${treePadding}"

    # write the test script name
    printf "%s\n\n" "## Test script ${GLOBAL_TEST_SUITE_SCRIPT_NAME%.sh}" >>"${GLOBAL_TEST_REPORT_FILE}"

    # Run the test script in a subshell.
    # This way each test script can define any vars or functions without polluting
    # the global execution of the tests.
    bash::runInSubshell selfTest_runSingleTest "${testScript}" "${testUserDataDirectory}"
    local exitCode="${REPLY}"

    if (( exitCode != 0 )); then
      # Handle an error that occurred in the test script.
      # If the error happened in the test script, we will have capture the stack trace in a file so we can read it.

      # get the stack trace at script exit
      fs::readFile "${GLOBAL_TEST_STACK_FILE}"
      eval "${REPLY//declare -a/}"

      selfTestUtils_displayTestLogs
      selfTestUtils_displayTestSuiteOutputs

      if ((exitCode == GLOBAL_TEST_IMPLEMENTATION_FAILURE_STATUS)); then
        # the function test::fail was called, there was a coding mistake in the test script that we caught
        fs::readFile "${GLOBAL_TEST_LOG_FILE}"
        log::error "The test script ⌜${testScript##*/}⌝ failed because an error was explicitly thrown in the test script:" \
          "" \
          "${REPLY}" \
          "test::fail called in ⌜${testScript/#"${GLOBAL_PROGRAM_STARTED_AT_DIRECTORY}/"/}⌝."
        log::printCallStack 0 10

      elif [[ -n ${GLOBAL_STACK_FUNCTION_NAMES_ERR:-} ]]; then
        log::error "The test script ⌜${testScript##*/}⌝ had an error and exited with code ⌜${exitCode}⌝." \
          "Test scripts will exit if a command ends with an error (shell option to exit on error)." \
          "" \
          "If you expect a tested function or command to fail, use one of these two methods to display the failure without exiting the script:" \
          "" \
          "- ⌜myCommandThatFails || echo 'failed as expected with code \$?'⌝" \
          "- ⌜test::exec myCommandThatFails⌝" \
          "" \
          "Error in ⌜${testScript/#"${GLOBAL_PROGRAM_STARTED_AT_DIRECTORY}/"/}⌝:"
        GLOBAL_STACK_FUNCTION_NAMES=("${GLOBAL_STACK_FUNCTION_NAMES_ERR[@]}")
        GLOBAL_STACK_SOURCE_FILES=("${GLOBAL_STACK_SOURCE_FILES_ERR[@]}")
        GLOBAL_STACK_LINE_NUMBERS=("${GLOBAL_STACK_LINE_NUMBERS_ERR[@]}")
        log::printCallStack 1 10
      else
        log::error "The test script ⌜${testScript##*/}⌝ exited with code ⌜${exitCode}⌝." \
          "Test scripts must not exit or return an error (shell options are set to exit on error)." \
          "" \
          "If you expect a tested function or command to exit, run it in a subshell using one of these two methods:" \
          "" \
          "- ⌜(myCommandThatFails) || echo 'failed as expected with code \${PIPESTATUS[0]:-}'⌝" \
          "- ⌜test::exit myCommandThatFails⌝" \
          "" \
          "Exited in ⌜${testScript/#"${GLOBAL_PROGRAM_STARTED_AT_DIRECTORY}/"/}⌝:"
        log::printCallStack 1 10
      fi

      # exit with an error if there were errors in the test scripts
      _OPTION_SILENT=true exit 1

    elif [[ -s "${GLOBAL_TEST_STANDARD_OUTPUT_FILE}" || -s "${GLOBAL_TEST_STANDARD_ERROR_FILE}" ]]; then
      selfTestUtils_displayTestLogs
      selfTestUtils_displayTestSuiteOutputs
      log::error "The test script had un-flushed when it ended."$'\n'$'\n'"Everything that gets printed to the standard or error output during a test must be flushed to the report. You can use ⌜test::flush⌝ to do that (or other test functions)."$'\n'$'\n'"Error in ⌜${testScript/#"${GLOBAL_PROGRAM_STARTED_AT_DIRECTORY}/"/}⌝."

      # exit with an error if there were errors in the test scripts
      _OPTION_SILENT=true exit 1
    fi

    nbScriptsDone+=1
  done

  # compare the test suite outputs with the approved files
  if ! selfTestUtils_compareWithApproved "${GLOBAL_TEST_SUITE_DIRECTORY}" "${GLOBAL_TEST_REPORT_FILE}"; then
    selfTestUtils_displayTestLogs
    _OPTION_SILENT=true exit "${GLOBAL_TEST_APPROVAL_FAILURE_STATUS}"
  fi

  if log::isDebugEnabled; then
    selfTestUtils_displayTestLogs
  fi
  _OPTION_SILENT=true exit 0
}

# ## selfTest_runSingleTest
#
# Run a single test script.
#
# It will redirect the standard output and error output to files and run the test script.
function selfTest_runSingleTest() {
  local testScript="${1}"
  local testUserDataDirectory="${2}"

  pushd "${GLOBAL_TEST_SUITE_DIRECTORY}" 1>/dev/null

  # Set the value of Valet variables to ensure consistency in the tests
  selfTestUtils_setupValetForConsistency

  # setup the temp locations for this test suite (cleanup is done at self test command level since
  # we create everything in the original temp directory)
  unset -v VALET_CONFIG_RUNTIME_DIRECTORY VALET_CONFIG_TEMP_DIRECTORY XDG_RUNTIME_DIR
  TMPDIR="${GLOBAL_TEST_BASE_TEMPORARY_DIRECTORY}"

  # reset the temporary location (to have consistency when using fs::createTempDirectory for example)
  if [[ -d ${GLOBAL_TEST_BASE_TEMPORARY_DIRECTORY} ]]; then
    rm -Rf "${GLOBAL_TEST_BASE_TEMPORARY_DIRECTORY}"
  fi
  fs::setupTempFileGlobalVariable
  fs::cleanTempFiles
  mkdir -p "${GLOBAL_TEST_BASE_TEMPORARY_DIRECTORY}"

  # set a new user directories so that commands are correctly recreated if calling
  # valet from a test
  cp -R "${testUserDataDirectory}" "${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}.valet.d"
  export VALET_CONFIG_USER_VALET_DIRECTORY="${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}.valet.d"
  export VALET_CONFIG_DIRECTORY="${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}.valet.d"
  export VALET_CONFIG_USER_DATA_DIRECTORY="${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}.valet.d"
  export VALET_CONFIG_USER_CACHE_DIRECTORY="${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}.valet.d"
  export VALET_CONFIG_USER_STATE_DIRECTORY="${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}.valet.d"

  # shellcheck disable=SC2034
  GLOBAL_TEST_TEMP_FILE="${GLOBAL_TEMPORARY_FILE_PREFIX}-temp"

  # Set the value of important bash variables to ensure consistency in the tests
  selfTestUtils_setupBashForConsistency

  # redirect the standard output and error output to files
  exec 1>"${GLOBAL_TEST_STANDARD_OUTPUT_FILE}"
  exec 2>"${GLOBAL_TEST_STANDARD_ERROR_FILE}"
  # since we changed fd2, we also need to redeclare fd that point to fd2
  exec {GLOBAL_FD_LOG}>&2
  exec {GLOBAL_FD_TUI}>&2
  unset -v GLOBAL_FD_ORIGINAL_STDERR

  # modify the trap functions to capture the stack trace at script exit/error
  eval "${_TEST_TRAP_FUNCTIONS_MODIFIED}"

  # run a custom user script before the tests if it exists
  selfTestUtils_runHookScript "${GLOBAL_TESTS_D_DIRECTORY}/before-tests"

  # run the test
  # shellcheck disable=SC1090
  builtin source "${testScript}"

  # run a custom user scrip after the test if it exists
  selfTestUtils_runHookScript "${GLOBAL_TESTS_D_DIRECTORY}/after-tests"

  selfTestUtils_makeReplacementsInReport

  exec {GLOBAL_FD_LOG}>&-
  exec {GLOBAL_FD_TUI}>&-
}