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
# shellcheck source=../libraries.d/lib-progress
source progress
# shellcheck source=../libraries.d/lib-bash
source bash
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
    The number of test suites to run in parallel. Set to 0 to run all the test suites sequentially.
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
  command::parseArguments "$@" && eval "${RETURNED_VALUE}"
  command::checkParsedResults

  time::getProgramElapsedMicroseconds
  local startTimeInMicroSeconds="${RETURNED_VALUE}"

  # check what will be used to display the diff between received and approved files
  selfTestUtils_setupDiffCommand

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
  if ((_TEST_NB_PARALLEL_TEST_SUITES == 0)); then
    log::debug "Running all test suites sequentially."
    _TEST_PARALLEL_RUN_QUALIFIER="sequentially"
  else
    log::debug "Running up to ⌜${_TEST_NB_PARALLEL_TEST_SUITES}⌝ test suites in parallel."
    _TEST_PARALLEL_RUN_QUALIFIER="in parallel (max ${_TEST_NB_PARALLEL_TEST_SUITES})"
  fi

  GLOBAL_TEST_APPROVAL_FAILURE_STATUS=141
  GLOBAL_TEST_IMPLEMENTATION_FAILURE_STATUS=142
  declare -g -i _TEST_FAILURE_STATUS=0
  declare -g -i _TEST_TEST_SUITES_COUNT=0
  declare -g -a _TEST_FAILED_TEST_SUITES=()

  fs::createTempDirectory
  GLOBAL_TEST_VALET_USER_DIRECTORY="${RETURNED_VALUE}"

  # test suites in the user directory
  if [[ ${coreOnly:-false} != "true" ]]; then
    # get the user directory
    core::getUserDirectory
    userDirectory="${userDirectory:-${RETURNED_VALUE}}"

    # rebuild the commands for the user dir
    selfTestUtils_rebuildCommands --user-directory "${userDirectory}" --output "${GLOBAL_TEST_VALET_USER_DIRECTORY}/commands"

    fs::listDirectories "${userDirectory}"
    local extensionDirectory
    for extensionDirectory in "${RETURNED_ARRAY[@]}"; do
      if [[ -d ${extensionDirectory}/tests.d ]]; then
        selfTest_runSingleTestSuites "${extensionDirectory}/tests.d"
      fi
    done
  fi

  # core test suites
  if [[ -n ${withCore:-} || ${coreOnly:-false} == "true" ]]; then
    if [[ ! -d ${GLOBAL_INSTALLATION_DIRECTORY}/tests.d ]]; then
      core::fail "The valet core tests directory ⌜${GLOBAL_INSTALLATION_DIRECTORY}/tests.d⌝ does not exist, cannot run core tests."
    fi

    # we need to rebuild the commands for the core commands only
    rm -Rf "${GLOBAL_TEST_VALET_USER_DIRECTORY}"
    selfTestUtils_rebuildCommands --core-only  --output "${GLOBAL_TEST_VALET_USER_DIRECTORY}/commands"
    selfTest_runSingleTestSuites "${GLOBAL_INSTALLATION_DIRECTORY}/tests.d"

    # now we can also test the commands in examples.d if the directory is there
    if [[ ! -d ${GLOBAL_INSTALLATION_DIRECTORY}/examples.d ]]; then
      log::warning "The valet examples directory ⌜${GLOBAL_INSTALLATION_DIRECTORY}/examples.d⌝ does not exist, cannot run the tests on the core examples."
    else
      # we need to rebuild the commands for the examples only
      rm -Rf "${GLOBAL_TEST_VALET_USER_DIRECTORY}"
      selfTestUtils_rebuildCommands --user-directory "${GLOBAL_INSTALLATION_DIRECTORY}/examples.d"  --output "${GLOBAL_TEST_VALET_USER_DIRECTORY}/commands"
      selfTest_runSingleTestSuites "${GLOBAL_INSTALLATION_DIRECTORY}/examples.d/showcase/tests.d"
    fi
  fi

  time::getProgramElapsedMicroseconds
  time::convertMicrosecondsToHuman $((RETURNED_VALUE - startTimeInMicroSeconds)) "%S seconds and %l ms"
  log::info "Total time running tests: ⌜${RETURNED_VALUE}⌝."

  if ((${#_TEST_FAILED_TEST_SUITES[@]} > 0)); then
    local failMessage
    failMessage="A total of ⌜${#_TEST_FAILED_TEST_SUITES[@]}⌝ out of ${_TEST_TEST_SUITES_COUNT} test(s) failed:"$'\n'
    local treeString="  ├─" treePadding="  │  " failedTestSuite
    local -i nb=0
    for failedTestSuite in "${_TEST_FAILED_TEST_SUITES[@]}"; do
      if ((nb == ${#_TEST_FAILED_TEST_SUITES[@]} - 1)); then
        treeString="  └─"
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
  elif ((_TEST_TEST_SUITES_COUNT > 0)); then
    log::success "A total of ⌜${_TEST_TEST_SUITES_COUNT}⌝ tests passed!"
  else
    log::warning "No eligible test suites found."
  fi
}

# ## selfTest_runSingleTestSuites
#
# Run all the test suites in the given `tests.d` directory.
#
# - $1: the directory containing the test suites
#
# Returns:
#   the number of test suites run (increments the global variable _TEST_TEST_SUITES_COUNT)
#   the number of failed test suites (add to the global variable _TEST_FAILED_TEST_SUITES)
#
# Usage:
#   selfTest_runSingleTestSuites "${GLOBAL_INSTALLATION_DIRECTORY}/tests.d"
function selfTest_runSingleTestSuites() {
  local testsDotDirectory="${1}"
  log::debug "Running all test suites in directory ⌜${testsDotDirectory}⌝."

  # make a list of all test suite directories
  fs::listDirectories "${testsDotDirectory}"
  local testDirectory testDirectoryName
  local -a testSuiteDirectories=()
  for testDirectory in "${RETURNED_ARRAY[@]}"; do
    testDirectoryName="${testDirectory##*/}"

    # skip if not a directory or hidden dir
    if [[ ! -d ${testDirectory} ]]; then continue; fi

    # skip if the test directory does not match the include pattern
    if [[ -n ${_TEST_INCLUDE_PATTERN:-} && ! (${testDirectory} =~ ${_TEST_INCLUDE_PATTERN}) ]]; then
      log::debug "Skipping test ⌜${testDirectory}⌝ because it does not match the include pattern."
      continue
    fi
    # skip if the test directory matches the exclude pattern
    if [[ -n ${_TEST_EXCLUDE_PATTERN:-} && ${testDirectory} =~ ${_TEST_EXCLUDE_PATTERN} ]]; then
      log::debug "Skipping test ⌜${testDirectory}⌝ because it matches the exclude pattern."
      continue
    fi
    testSuiteDirectories+=("${testDirectory}")
  done

  if ((${#testSuiteDirectories[@]} == 0)); then
    log::info "No matching test suites found in directory ⌜${testsDotDirectory}⌝."
    return 0
  fi

  log::info "Running ⌜${#testSuiteDirectories[@]}⌝ test suites from directory ⌜${testsDotDirectory}⌝ ${_TEST_PARALLEL_RUN_QUALIFIER}."

  pushd "${testsDotDirectory}" 1>/dev/null

  # run a custom user script before the tests if it exists
  selfTestUtils_runHookScript "${testsDotDirectory}/before-tests"

  progress::start
  progress::update 0 "Running test suites."

  # sequential run
  if ((_TEST_NB_PARALLEL_TEST_SUITES == 0 || ${#testSuiteDirectories[@]} == 1)); then
    local -i testSuitesDoneCount=0
    for testDirectory in "${testSuiteDirectories[@]}"; do
      testDirectoryName="${testDirectory##*/}"
      log::debug "Starting test suite ⌜${testDirectoryName}⌝."

      progress::update $((testSuitesDoneCount * 100 / ${#testSuiteDirectories[@]})) "Running test suite ⌜${testDirectoryName}⌝."
      (selfTest_runSingleTestSuite "${testDirectory}") || _TEST_FAILED_TEST_SUITES+=("${testDirectoryName}")
      testSuitesDoneCount+=1
    done

  else
    # parallel run
    declare -g -a _TEST_SUITE_NAMES=() _TEST_SUITE_COMMANDS=() _TEST_SUITE_OUTPUT_FILES=()
    for testDirectory in "${testSuiteDirectories[@]}"; do
      _TEST_SUITE_NAMES+=("${testDirectory##*/}")
      fs::createTempFile
      _TEST_SUITE_OUTPUT_FILES+=("${RETURNED_VALUE}")
      _TEST_SUITE_COMMANDS+=("selfTest_runSingleTestSuite '${testDirectory}' &>'${RETURNED_VALUE}'")
    done

    bash::runInParallel _TEST_SUITE_NAMES _TEST_SUITE_COMMANDS "${_TEST_NB_PARALLEL_TEST_SUITES}" selfTest_parallelCallback
  fi

  progress::stop

  # run a custom user script after the tests if it exists
  selfTestUtils_runHookScript "${testsDotDirectory}/after-tests"

  _TEST_TEST_SUITES_COUNT=$((_TEST_TEST_SUITES_COUNT + ${#testSuiteDirectories[@]}))

  popd 1>/dev/null
}

# ## selfTest_parallelCallback
#
# Callback function for the parallel run of test suites.
# Called when a test suite is completed (either successfully or not).
#
# It updates the progress bar and displays the output of the test suite.
function selfTest_parallelCallback() {
  local -i index="${1}"
  local jobName="${2}"
  local -i exitCode="${3}"
  local -i percent="${4}"

  progress::update "${percent}" "Done running test suite ⌜${jobName}⌝."

  # display the job output
  fs::readFile "${_TEST_SUITE_OUTPUT_FILES[${index}]}"
  printf '%s\n' "${RETURNED_VALUE%$'\n'}"

  if ((exitCode != 0)); then
    _TEST_FAILED_TEST_SUITES+=("${jobName}")
  fi
}

# ## selfTest_runSingleTestSuite
#
# Run a single test suite.
#
# - $1: the directory containing the test suite
#
function selfTest_runSingleTestSuite() {
  local testSuiteDirectory="${1}"

  core::setShellOptions
  main::unregisterTraps

  GLOBAL_TEST_SUITE_NAME="${testSuiteDirectory##*/}"
  local testsDotDirectory="${testSuiteDirectory%/*}"
  log::debug "Running test suite ⌜${testSuiteDirectory}⌝."

  # make a list of all test scripts
  local -a testScripts=()
  local testScript
  for testScript in "${testSuiteDirectory}"/*.sh; do
    # skip if not a file
    if [[ ! -f "${testScript}" ]]; then
      continue
    fi
    testScripts+=("${testScript}")
  done

  if ((${#testScripts[@]} == 0)); then
    log::info "No test scripts found in test suite ⌜${testSuiteDirectory}⌝."
    return 0
  fi

  # setup the temp locations for this test suite (cleanup is done at self test command level since
  # we create everything in the original temp directory)
  GLOBAL_TEST_BASE_TEMPORARY_DIRECTORY="${GLOBAL_TEMPORARY_DIRECTORY}/tmp-${BASHPID}.${GLOBAL_TEST_SUITE_NAME}"
  unset -v VALET_CONFIG_WORK_FILES_DIRECTORY
  TMPDIR="${GLOBAL_TEST_BASE_TEMPORARY_DIRECTORY}"

  GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY="${GLOBAL_TEMPORARY_DIRECTORY}/output-${BASHPID}.${GLOBAL_TEST_SUITE_NAME}"
  GLOBAL_TEST_STANDARD_OUTPUT_FILE="${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}/stdout"
  GLOBAL_TEST_STANDARD_ERROR_FILE="${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}/stderr"
  GLOBAL_TEST_REPORT_FILE="${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}/report"
  GLOBAL_TEST_STACK_FILE="${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}/stack"
  GLOBAL_TEST_LOG_FILE="${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}/log"
  mkdir -p "${GLOBAL_TEST_OUTPUT_TEMPORARY_DIRECTORY}"
  # shellcheck disable=SC2034
  GLOBAL_TEST_CURRENT_DIRECTORY="${testSuiteDirectory}"
  GLOBAL_TESTS_D_DIRECTORY="${testsDotDirectory}"

  # run a custom user script before the test suite if it exists
  selfTestUtils_runHookScript "${GLOBAL_TESTS_D_DIRECTORY}/before-each-test-suite"

  # write the test suite title
  printf "%s\n\n" "# Test suite ${GLOBAL_TEST_SUITE_NAME}" >"${GLOBAL_TEST_REPORT_FILE}"

  pushd "${testSuiteDirectory}" 1>/dev/null

  # run the test scripts
  log::info "⌜${GLOBAL_TEST_SUITE_NAME}⌝:"
  local treeString="  ├─" treePadding="  │  "
  local -i nbScriptsDone=0 nbOfScriptsWithErrors=0
  for testScript in "${testScripts[@]}"; do
    GLOBAL_TEST_SUITE_SCRIPT_NAME="${testScript##*/}"
    if ((nbScriptsDone == ${#testScripts[@]} - 1)); then
      treeString="  └─"
      treePadding="     "
    fi
    log::printString "${treeString} ${GLOBAL_TEST_SUITE_SCRIPT_NAME}" "${treePadding}"

    # write the test script name
    printf "%s\n\n" "## Test script ${GLOBAL_TEST_SUITE_SCRIPT_NAME%.sh}" >>"${GLOBAL_TEST_REPORT_FILE}"

    # Run the test script in a subshell.
    # This way each test can define any vars or functions without polluting
    # the global execution of the tests.
    if ! (
      core::setShellOptions
      trap 'selfTest_onExitTestInternal $?' EXIT
      trap 'selfTest_onErrTestInternal' ERR
      selfTest_runSingleTest "${testSuiteDirectory}" "${testScript}" || exit $?
    ) >"${GLOBAL_TEST_STACK_FILE}" 2>"${GLOBAL_TEST_LOG_FILE}"; then

      # Handle an error that occurred in the test script.
      # We trapped the EXIT signal in the subshell that runs the test and we make it output the
      # stack trace in a file (selfTest_onExitTestInternal). We can now read this file and display the stack trace.
      local exitCode="${PIPESTATUS[0]:-}"

      # get the stack trace at script exit
      fs::readFile "${GLOBAL_TEST_STACK_FILE}"
      eval "${RETURNED_VALUE//declare -a/}"

      selfTestUtils_displayTestLogs
      selfTestUtils_displayTestSuiteOutputs

      if ((exitCode == GLOBAL_TEST_IMPLEMENTATION_FAILURE_STATUS)); then
        # the function test::fail was called, there was a coding mistake in the test script that we caught
        fs::readFile "${GLOBAL_TEST_LOG_FILE}"
        log::error "The test script ⌜${testScript##*/}⌝ failed because an error was explicitly thrown in the test script:" \
          "" \
          "${RETURNED_VALUE}" \
          "" \
          "Error in ⌜${testScript/#"${GLOBAL_PROGRAM_STARTED_AT_DIRECTORY}/"/}⌝."
        log::printCallStack 1 7

      elif [[ -n ${GLOBAL_STACK_FUNCTION_NAMES_ERR:-} ]]; then
        log::error "The test script ⌜${testScript##*/}⌝ had an error  and exited with code ⌜${exitCode}⌝." \
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
        # print the last line of the err output, which is supposed to be the bash error message
        fs::tail "${GLOBAL_TEST_STANDARD_ERROR_FILE}" 1 true
        if [[ -n ${RETURNED_ARRAY[0]:-} ]]; then
          log::printString "░ ${RETURNED_ARRAY[0]:-}" "░ "
        fi
        log::printCallStack 2 7
      else
        log::error "The test script ⌜${testScript##*/}⌝ exited with code ⌜${exitCode}⌝." \
          "Test scripts must not exit or return an error (shell options are set to exit on error)." \
          "" \
          "If you expect a tested function or command to exit, run it in a subshell using one of these two methods:" \
          "" \
          "- ⌜(myCommandThatFails) || echo 'failed as expected with code \${PIPESTATUS[0]:-}'⌝" \
          "- ⌜test::exit myCommandThatFails⌝" \
          "" \
          "Error in ⌜${testScript/#"${GLOBAL_PROGRAM_STARTED_AT_DIRECTORY}/"/}⌝:"
        log::printCallStack 1 7
      fi

      nbOfScriptsWithErrors+=1

    else
      # check if the user forgot to call flush
      if [[ -s "${GLOBAL_TEST_STANDARD_OUTPUT_FILE}" || -s "${GLOBAL_TEST_STANDARD_ERROR_FILE}" ]]; then
        selfTestUtils_displayTestLogs
        selfTestUtils_displayTestSuiteOutputs
        log::error "The test script had un-flushed when it ended."$'\n'$'\n'"Everything that gets printed to the standard or error output during a test must be flushed to the report. You can use ⌜test::flush⌝ to do that (or other test functions)."$'\n'$'\n'"Error in ⌜${testScript/#"${GLOBAL_PROGRAM_STARTED_AT_DIRECTORY}/"/}⌝."
        nbOfScriptsWithErrors+=1
      fi

    fi

    nbScriptsDone+=1
  done

  popd 1>/dev/null

  # run a custom user script after the test suite if it exists
  selfTestUtils_runHookScript "${GLOBAL_TESTS_D_DIRECTORY}/after-each-test-suite"

  # exit with an error if there were errors in the test scripts
  if ((nbOfScriptsWithErrors > 0)); then
    return 1
  fi

  # compare the test suite outputs with the approved files
  if ! selfTestUtils_compareWithApproved "${testSuiteDirectory}" "${GLOBAL_TEST_REPORT_FILE}"; then
    selfTestUtils_displayTestLogs
    if ((_TEST_FAILURE_STATUS <= GLOBAL_TEST_APPROVAL_FAILURE_STATUS)); then
      _TEST_FAILURE_STATUS="${GLOBAL_TEST_APPROVAL_FAILURE_STATUS}"
    fi
    return "${GLOBAL_TEST_APPROVAL_FAILURE_STATUS}"
  fi

  if log::isDebugEnabled; then
    selfTestUtils_displayTestLogs
  fi
  return 0
}

# ## selfTest_onExitTestInternal
#
# Will be called if a test exits (usually because of an error).
# It will output the stack trace in a file.
# We need to capture the stack trace within the subshell that runs the test script.
function selfTest_onExitTestInternal() {
  # handle an exit in the test script
  local exitCode="${1}"

  if ((exitCode == 0)); then
    return 0
  fi

  if [[ ! -v GLOBAL_STACK_FUNCTION_NAMES ]]; then
    GLOBAL_STACK_FUNCTION_NAMES=("${FUNCNAME[@]}")
    GLOBAL_STACK_SOURCE_FILES=("${BASH_SOURCE[@]}")
    GLOBAL_STACK_LINE_NUMBERS=("${BASH_LINENO[@]}")
    declare -p GLOBAL_STACK_FUNCTION_NAMES GLOBAL_STACK_SOURCE_FILES GLOBAL_STACK_LINE_NUMBERS 1>&3
  fi
}

# ## selfTest_onErrTestInternal
#
# Will be called if a test script has an error.
# We need to capture the stack trace within the subshell that runs the test script.
function selfTest_onErrTestInternal() {
  # handle an error in the test script
  GLOBAL_STACK_FUNCTION_NAMES_ERR=("${FUNCNAME[@]}")
  GLOBAL_STACK_SOURCE_FILES_ERR=("${BASH_SOURCE[@]}")
  GLOBAL_STACK_LINE_NUMBERS_ERR=("${BASH_LINENO[@]}")
  declare -p GLOBAL_STACK_FUNCTION_NAMES_ERR GLOBAL_STACK_SOURCE_FILES_ERR GLOBAL_STACK_LINE_NUMBERS_ERR 1>&3
}

# ## selfTest_runSingleTest
#
# Run a single test script.
#
# It will redirect the standard output and error output to files and run the test script.
function selfTest_runSingleTest() {
  local testDirectory="${1}"
  local testScript="${2}"

  # set a simplified log print function to have consistent results in tests
  selfTestUtils_setupValetForConsistency

  # reset the temporary location (to have consistency when using fs::createTempDirectory for example)
  if [[ -d ${GLOBAL_TEST_BASE_TEMPORARY_DIRECTORY} ]]; then
    rm -Rf "${GLOBAL_TEST_BASE_TEMPORARY_DIRECTORY}" || :
  fi
  fs::setupTempFileGlobalVariable
  fs::cleanTempFiles
  mkdir -p "${GLOBAL_TEST_BASE_TEMPORARY_DIRECTORY}"

  # set a new user directory so that commands are correctly recreated if calling
  # valet from a test
  cp -R "${GLOBAL_TEST_VALET_USER_DIRECTORY}" "${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}.valet.d"
  export VALET_USER_DIRECTORY="${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}.valet.d"

  # shellcheck disable=SC2034
  GLOBAL_TEST_TEMP_FILE="${GLOBAL_TEMPORARY_FILE_PREFIX}-temp"

  # redirect the standard output and error output to files
  exec 3>&1 1>"${GLOBAL_TEST_STANDARD_OUTPUT_FILE}"
  exec 4>&2 2>"${GLOBAL_TEST_STANDARD_ERROR_FILE}"

  # run a custom user script before the test if it exists
  selfTestUtils_runHookScript "${GLOBAL_TESTS_D_DIRECTORY}/before-each-test"

  # run the test
  # shellcheck disable=SC1090
  builtin source "${testScript}"

  # run a custom user script after the test if it exists
  selfTestUtils_runHookScript "${GLOBAL_TESTS_D_DIRECTORY}/after-each-test"

  exec 3>&-
  exec 4>&-

  self_makeReplacementsInReport
}

# ## self_makeReplacementsInReport
#
# In order to have consistent results in tests, we need to replace to replace
# values that could be different on each run/machine.
function self_makeReplacementsInReport() {
  fs::readFile "${GLOBAL_TEST_REPORT_FILE}"
  RETURNED_VALUE="${RETURNED_VALUE//${GLOBAL_INSTALLATION_DIRECTORY}\/valet/valet}"
  RETURNED_VALUE="${RETURNED_VALUE//${GLOBAL_INSTALLATION_DIRECTORY}/\$GLOBAL_INSTALLATION_DIRECTORY}"
  RETURNED_VALUE="${RETURNED_VALUE//${GLOBAL_TEST_CURRENT_DIRECTORY}/.}"
  RETURNED_VALUE="${RETURNED_VALUE//${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}/\/tmp/valet}"
  RETURNED_VALUE="${RETURNED_VALUE//${GLOBAL_TEMPORARY_FILE_PREFIX}/\/tmp/valet}"
  printf "%s" "${RETURNED_VALUE}" >"${GLOBAL_TEST_REPORT_FILE}"
}
