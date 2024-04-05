#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet)
if [ -z "${_CORE_INCLUDED:-}" ]; then
  VALETD_DIR="${BASH_SOURCE[0]}"
  if [[ "${VALETD_DIR}" != /* ]]; then
    if pushd "${VALETD_DIR%/*}" &>/dev/null; then
      VALETD_DIR="${PWD}"
      popd &>/dev/null
    else VALETD_DIR="${PWD}"; fi
  else VALETD_DIR="${VALETD_DIR%/*}"; fi
  # shellcheck source=../core
  source "${VALETD_DIR%/*}/core"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> command: self test
#===============================================================
: "---
command: self test
function: selfTest
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
  parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  checkParseResults "${help:-}" "${parsingErrors:-}"

  setGlobalOptions

  # get the directory containing the tests for the commands
  getUserDirectory
  userDirectory="${userDirectory:-${LAST_RETURNED_VALUE}}"
  debug "User directory is ⌜${userDirectory}⌝."

  # change the shell options to include hidden files
  shopt -s dotglob
  shopt -s globstar

  local testsDirectory
  for testsDirectory in "${userDirectory}"/**; do
    debug "Tests directory: ⌜${testsDirectory}⌝."
    # if the directory is not a directory, skip
    [ ! -d "${testsDirectory}" ] && continue
    # if the directory is named .tests.d, then it is a test directory
    if [[ "${testsDirectory}" == *"/tests.d" ]]; then
      inform "Running all test suites in directory ⌜${testsDirectory}⌝."
      runTestSuites "${testsDirectory}"
    fi
  done

  # reset glob options
  shopt -u dotglob
  shopt -u globstar

  if [ -n "${withCore:-}" ]; then
    if [[ ! -d "${VALET_HOME}/tests.d" ]]; then
      warn "The valet core tests directory ⌜${VALET_HOME}/tests.d⌝ does not exist, skipping core tests."
    else
      runCoreTests
    fi
  fi
}

#===============================================================
# >>> command: self test-core
#===============================================================

: "---
command: self test-core
function: selfTestCore
shortDescription: Test valet core features.
description: |-
  Test valet core features using approval tests approach.
options:
- name: -a, --auto-approve
  description: |-
    The received test result files will automatically be approved.
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
- name: --error
  description: |-
    Test the error handling.
  noEnvironmentVariable: true
- name: --fail
  description: |-
    Test the fail.
  noEnvironmentVariable: true
- name: --exit
  description: |-
    Test the exit code.
  noEnvironmentVariable: true
- name: --unknown-command
  description: |-
    Test with an unknown command.
  noEnvironmentVariable: true
- name: --create-temp-files
  description: |-
    Test to create temp file and directory.
  noEnvironmentVariable: true
- name: --create-temp-files
  description: |-
    Test to create temp file and directory.
  noEnvironmentVariable: true
- name: --logging-level
  description: |-
    Test to output all log level messages.
  noEnvironmentVariable: true
- name: --wait-indefinitely
  description: |-
    Test to wait indefinitely.
  noEnvironmentVariable: true
- name: --show-help
  description: |-
    Test to show the help of the function.
---"
function selfTestCore() {
  parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  checkParseResults "${help:-}" "${parsingErrors:-}"

  setGlobalOptions

  if [ -n "${error:-}" ]; then
    warn "This is for testing valet core functions, the next statement will return 1 and create an error."
    returnOne
  elif [ -n "${fail:-}" ]; then
    fail "This is for testing valet core functions, failing now."
  elif [ -n "${exit:-}" ]; then
    # shellcheck disable=SC2317
    function onExit() {
      warn "This is a custom on exit function."
    }
    warn "This is for testing valet core functions, exiting with code 5."
    exit 5
  elif [ -n "${unknownCommand:-}" ]; then
    warn "This is for testing valet core functions, the next statement will call a non existing command, causing a call to command_not_found_handle."
    thisIsAnUnknownCommandForTesting
  elif [ -n "${createTempFiles:-}" ]; then
    # shellcheck disable=SC2317
    function cleanUp() {
      warn "This is a custom clean up function."
    }
    local tmp1 tmp2 tmp3 tmp4
    createTempFile && tmp1="${LAST_RETURNED_VALUE}"
    createTempFile && tmp2="${LAST_RETURNED_VALUE}"
    createTempDirectory && tmp3="${LAST_RETURNED_VALUE}"
    createTempDirectory && tmp4="${LAST_RETURNED_VALUE}"
    inform "Created temp file: ${tmp1}."
    inform "Created temp file: ${tmp2}."
    inform "Created temp directory: ${tmp3}."
    inform "Created temp directory: ${tmp4}."
    # activating debug log to see the cleanup
    setLogLevel "debug"
  elif [ -n "${loggingLevel:-}" ]; then
    debug "This is a debug message."
    inform "This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out."
    succeed "This is a success message."
    warn "This is a warning message."$'\n'"With a second line."
    if isDebugEnabled; then
      echo "The debug mode is activated!" 1>&2
    fi
  elif [ -n "${waitIndefinitely:-}" ]; then
    inform "This is for testing valet core functions, waiting indefinitely."
    while true; do
      # sleep for 1s
      read -rt 1 <> <(:) || :
    done
  elif [ -n "${showHelp:-}" ]; then
    showHelp
  else
    # default to running tests
    runCoreTests
  fi
}

function returnOne() { return 1; }

#===============================================================
# >>> Functions that can be used in the test files
#===============================================================

# Call this function to add a paragraph in the report file.
#
# $1: the text to add in the report file
#
# Usage:
#   commentTest "This is a comment."
function commentTest() {
  printf "%s\n\n" "${1:-}" >>"${_TEST_REPORT_FILE}"
}


# Call this function after each test to write the test results to the report file.
# This create a new H3 section in the report file with the test description and the exit code.
#
# $1: the title of the test
# $2: the exit code of the test
# $3: (optional) a text to explain what is being tested
#
# Usage:
#   endTest "Testing something" $?
function endTest() {
  local testTitle="${1:-}"
  local exitCode="${2:-}"
  local testDescription="${3:-}"

  resetFdRedirection

  {
    debug "Ended test ⌜${testTitle}⌝ with exit code ⌜${exitCode}⌝."

    # write the test title
    printf "%s\n\n" "### ${testTitle:-test}"

    # write the test description if any
    if [ -n "${testDescription}" ]; then
      printf "%s\n\n" "${testDescription}"
    fi

    # write the exit code
    printf "%s\n\n" "Exit code: \`${exitCode}\`"

    # write the standard output if any
    if [ -s "${_TEST_STANDARD_OUTPUT_FILE}" ]; then
      printf "%s\n\n%s\n" "**Standard** output:" "\`\`\`plaintext"
      echoFileSubstitutingPath "${_TEST_STANDARD_OUTPUT_FILE}"
      printf "\n%s\n\n" "\`\`\`"
    fi

    # write the error output if any
    if [ -s "${_TEST_STANDARD_ERROR_FILE}" ]; then
      printf "%s\n\n%s\n" "**Error** output:" "\`\`\`log"
      echoFileSubstitutingPath "${_TEST_STANDARD_ERROR_FILE}"
      printf "\n%s\n\n" "\`\`\`"
    fi

  } >>"${_TEST_REPORT_FILE}"

  # reset the standard output and error output files
  : >"${_TEST_STANDARD_OUTPUT_FILE}"
  : >"${_TEST_STANDARD_ERROR_FILE}"

  setFdRedirection

  set +Eeu +o pipefail
}

#===============================================================
# >>> Internal tests functions
#===============================================================

function runCoreTests() {
  local originalUserDirectory="${VALET_USER_DIRECTORY:-}"

  # we will run some example commands so we need to set the correct user directory and commands
  export VALET_USER_DIRECTORY="${VALET_HOME}/examples.d"
  unset _CMD_INCLUDED
  sourceUserCommands

  inform "Running all test suites in directory ⌜${VALET_HOME}/tests.d⌝."
  runTestSuites "${VALET_HOME}/tests.d"

  VALET_USER_DIRECTORY="${originalUserDirectory}"
}

# Run all the test suites in the given directory.
# A test suite is a folder that contains a test.sh file.
# This test.sh allows to run multiple tests.
# $1: the directory containing the test suites
#
# Usage:
#   runTestSuites "${VALET_HOME}/tests.d"
function runTestSuites() {
  local testsDirectory="${1}"

  createTempFile && _TEST_STANDARD_OUTPUT_FILE="${LAST_RETURNED_VALUE}"
  createTempFile && _TEST_STANDARD_ERROR_FILE="${LAST_RETURNED_VALUE}"
  createTempFile && _TEST_REPORT_FILE="${LAST_RETURNED_VALUE}"
  createTempFile && _TEST_TEMP_FILE="${LAST_RETURNED_VALUE}"

  local -i failedTestSuites nbTestSuites
  failedTestSuites=0
  nbTestSuites=0

  # for each test file in the test directory
  local testDirectory exitCode testDirectoryName testScript
  for testDirectory in "${testsDirectory}/"*; do
    testDirectoryName="${testDirectory##*/}"

    # skip if not a directory
    [ ! -d "${testDirectory}" ] && continue

    # skip if the test directory does not match the include pattern
    if [[ -n "${INCLUDE_PATTERN:-}" && ! ("${testDirectoryName}" =~ ${INCLUDE_PATTERN}) ]]; then
      debug "Skipping test ⌜${testDirectoryName##*/}⌝ because it does not match the include pattern."
      continue
    fi
    # skip if the test directory matches the exclude pattern
    if [[ -n "${EXCLUDE_PATTERN:-}" && "${testDirectoryName}" =~ ${EXCLUDE_PATTERN} ]]; then
      debug "Skipping test ⌜${testDirectoryName##*/}⌝ because it matches the exclude pattern."
      continue
    fi

    inform "Running test suite ⌜${testDirectory##*/}⌝."

    # write the test suite title
    printf "%s\n\n" "# Test suite ${testDirectory##*/}" >"${_TEST_REPORT_FILE}"

    # for each .sh script in the test directory, run the test
    for testScript in "${testDirectory}"/*.sh; do
      # skip if not a file
      [ ! -e "${testScript}" ] && continue

      inform "Running test       ├── ⌜${testScript##*/}⌝."

      runTest "${testDirectory}" "${testScript}"
    done

    exitCode=0
    compareWithApproved "${testDirectory}" "${_TEST_REPORT_FILE}" || exitCode=$?
    nbTestSuites+=1

    if [ "${exitCode}" -eq 0 ]; then
      succeed "Test suite ${testDirectory##*/} passed."
    else
      warn "Test suite ${testDirectory##*/} failed."
      failedTestSuites+=1
    fi
  done

  if [[ failedTestSuites -gt 0 ]]; then
    local failMessage
    failMessage="A total of ⌜${failedTestSuites}⌝/⌜${nbTestSuites}⌝ test(s) failed."
    if [ "${AUTO_APPROVE:-false}" = "true" ]; then
      failMessage+=$'\n'"The received test result files were automatically approved."
    else
      failMessage+=$'\n'"You should review the difference in the logs above or by comparing each ⌜**.received.md⌝ files with ⌜**.approved.md⌝ files."
      failMessage+=$'\n'"If the differences are legitimate, then approve the changes by running this command again with the option ⌜-a⌝."
    fi
    fail "${failMessage}"
  elif [[ nbTestSuites -gt 0 ]]; then
    succeed "A total of ⌜${nbTestSuites}⌝ tests passed!"
  else
    warn "No tests were found."
  fi

}

function runTest() {
  local testDirectory="${1}"
  local testScript="${2}"

  # redirect the standard output and error output to files
  setFdRedirection

  trap onExitTest EXIT

  # used in echoFileSubstitutingPath to replace this path with .
  CURRENT_DIRECTORY="${PWD}"

  # write the test script name
  local scriptName="${testScript##*/}"
  scriptName="${scriptName%.sh}"
  printf "%s\n\n" "## Test script ${scriptName}" >>"${_TEST_REPORT_FILE}"

  # run the test
  pushd "${testDirectory}" >/dev/null
  # shellcheck disable=SC1091
  set +Eeu +o pipefail
  # shellcheck disable=SC1090
  source "${testScript}"
  set -Eeu -o pipefail
  popd >/dev/null

  resetFdRedirection

  trap onExitInternal EXIT

  # test if the user forgot to call endTest
  if [[ -s "${_TEST_STANDARD_OUTPUT_FILE}" || -s "${_TEST_STANDARD_ERROR_FILE}" ]]; then
    fail "The test script ⌜${testScript}⌝ did not call endTest OR it had outputs after the last endTest call."
  fi

}

function compareWithApproved() {
  local testDirectory exitCode approvedFile receivedFile receivedFileToCopy
  testDirectory="${1}"
  receivedFileToCopy="${2}"
  testName="${testDirectory##*/}"

  approvedFile="${testDirectory}/results.approved.md"
  receivedFile="${testDirectory}/results.received.md"

  if [ ! -f "${approvedFile}" ]; then
    debug "🧪 ${testName}: no approved file, creating one."
    : >"${approvedFile}"
  fi

  if diff --color -u "${approvedFile}" "${receivedFileToCopy}" 1>&2; then
    debug "🧪 ${testName}: OK, equal to approved file."
    rm -f "${receivedFile}" 2>/dev/null || true
    return 0
  else
    echo "${receivedFile} is different than ${approvedFile} (see above)" 1>&2
    warn "🧪 ${testName}: KO, differs from approved file (see difference above)." | tee >(cat >&2)
  fi

  # if the option is activated, we approve the received file
  if [ "${AUTO_APPROVE:-false}" == "true" ]; then
    inform "🧪 ${testName}: Auto-approving"
    cp -f "${receivedFileToCopy}" "${approvedFile}"
    rm -f "${receivedFile}" 2>/dev/null || true
  else
    cp -f "${receivedFileToCopy}" "${receivedFile}"
  fi

  return 1
}

# Allows to explicitly warn the user that a test made Valet exit (it should not).
# Give guidance on what to do to fix this.
function onExitTest() {
  local rc=$?

  resetFdRedirection

  local message="The program is exiting during a test with code ${rc}."$'\n'
  readFile "${_TEST_STANDARD_ERROR_FILE}"
  message+="Current test error output: ⌜${LAST_RETURNED_VALUE}⌝"$'\n'
  message+="If you expect the tested function/program to exit/fail, then run it in a subshell like that:"$'\n'"(myFunctionThatFails)"

  warn "${message}"

  ERROR_DISPLAY=1
  onExitInternal
}

# After this function call, everything written to stdout and stderr will be redirected
# to the test output files.
# Call resetFdRedirection to reset the redirection.
function setFdRedirection() {
  # redirect the standard output and error output to files
  exec 3>&1 1>"${_TEST_STANDARD_OUTPUT_FILE}"
  exec 4>&2 2>"${_TEST_STANDARD_ERROR_FILE}"

  # sets up a simpler log function for the tests
  # so we can have consistent results independent of the environment
  if [ -z "${ORIGINAL_LOG_LINE_FUNCTION:-}" ]; then
    ORIGINAL_LOG_LINE_FUNCTION="${LOG_LINE_FUNCTION}"
    ORIGINAL_VALET_NO_COLOR="${VALET_NO_COLOR:-}"
    ORIGINAL_LOG_LEVEL="${VALET_LOG_LEVEL:-}"
    ORIGINAL_VALET_DO_NOT_USE_LOCAL_BIN="${VALET_DO_NOT_USE_LOCAL_BIN:-}"
  fi
  export VALET_LOG_LEVEL="info"
  setLogLevel info &>/dev/null
  export VALET_NO_COLOR="true"
  setLogColors
  export VALET_NO_TIMESTAMP="true"
  export VALET_NO_ICON="true"
  export VALET_NO_WRAP="true"
  export VALET_CI_MODE="false"
  export VALET_LOG_COLUMNS=9999
  export _COLUMNS=9999
  export VALET_DO_NOT_USE_LOCAL_BIN="true"
  if [ -z "${SIMPLIFIED_LOG_LINE_FUNCTION:-}" ]; then
    createLogLineFunction
    SIMPLIFIED_LOG_LINE_FUNCTION="${LOG_LINE_FUNCTION}"
  fi
  eval "${SIMPLIFIED_LOG_LINE_FUNCTION}"
}

# Restores the standard output and error output.
# Call this function after setFdRedirection.
function resetFdRedirection() {
  # reset the standard output and error output
  exec 1>&3 3>&-
  exec 2>&4 4>&-

  # reset the original logs
  export VALET_LOG_LEVEL="${ORIGINAL_LOG_LEVEL}"
  setLogLevel "${ORIGINAL_LOG_LEVEL}" &>/dev/null
  export VALET_NO_COLOR="${ORIGINAL_VALET_NO_COLOR}"
  export VALET_DO_NOT_USE_LOCAL_BIN="${ORIGINAL_VALET_DO_NOT_USE_LOCAL_BIN}"
  setLogColors
  eval "${ORIGINAL_LOG_LINE_FUNCTION}"
}

function setGlobalOptions() {
  unset AUTO_APPROVE INCLUDE_PATTERN EXCLUDE_PATTERN
  if [ -n "${autoApprove:-}" ]; then
    AUTO_APPROVE="true"
  fi
  if [ -n "${include:-}" ]; then
    inform "Including only test suites that match the pattern ⌜${include}⌝."
    INCLUDE_PATTERN="${include}"
  fi
  if [ -n "${exclude:-}" ]; then
    inform "Excluding all test suites that match the pattern ⌜${exclude}⌝."
    EXCLUDE_PATTERN="${exclude}"
  fi
}

# This function is used to echo the content of a file with some substitutions.
# The substitutions are:
# - replace the VALET_HOME with $VALET_HOME
# - replace the current test directory with a dot
# - replace a line with ${TMPDIR}/valet-*/ (temp directory) by /valet/
#
# This allows to have consistent results accross different execution environments for the tests.
#
# Usage:
#   myCommandThatProducesLinesWithValetDirectoryPath 2> "${_TEST_TEMP_FILE}"
#   echoFileSubstitutingPath "${_TEST_TEMP_FILE}" 1>&2
function echoFileSubstitutingPath() {
  local file="${1}"
  local line
  local IFS=$'\n'
  local -i firstLine=1
  while read -rd $'\n' line; do
    if [[ firstLine -eq 1 ]]; then
      firstLine=0
    else
      echo
    fi
    line="${line//${VALET_HOME}/\$VALET_HOME}"
    line="${line//${CURRENT_DIRECTORY}/.}"
    line="${line//${_TEMPORARY_DIRECTORY}/\/tmp}"
    line="${line//${_TEMPORARY_PREFIX}*.valet/\/tmp/valet}"
    if [[ "${line}" =~ "after "[0-9]{1,}s.$ ]]; then
      line="${line/%after */after Xs.}"
    fi
    echo -n "${line}"
  done <"${file}"
}
