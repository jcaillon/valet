#!/usr/bin/env bash
# Title:         valet.d/commands/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet)
if [ -z "${_MAIN_INCLUDED:-}" ]; then
  VALETD_DIR="${BASH_SOURCE[0]}"
  VALETD_DIR="${VALETD_DIR%/*}" # strip file name
  VALETD_DIR="${VALETD_DIR%/*}" # strip directory
  # shellcheck source=../main
  source "${VALETD_DIR}/main"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> self test for valet commands (and optionally, core functions)
#===============================================================
function about_selfTest() {
  echo "
command: self test
fileToSource: ${BASH_SOURCE[0]}
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
"
}

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
    if [[ "${testsDirectory}" == *"/.tests.d" ]]; then
      inform "Running all test suites in directory ⌜${testsDirectory}⌝."
      runTestSuites "${testsDirectory}"
    fi
  done

  # change the shell options to exclude hidden files
  shopt -u dotglob
  shopt -u globstar

  if [ -n "${withCore:-}" ]; then
    inform "Running all test suites in directory ⌜${VALET_HOME}/tests.d⌝."
    runTestSuites "${VALET_HOME}/tests.d"
  fi
}

#===============================================================
# >>> self core test for valet
#===============================================================
function about_selfTestCore() {
  echo "
command: self test-core
fileToSource: ${BASH_SOURCE[0]}
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
  - name: --fail
    description: |-
      Test the fail.
  - name: --exit
    description: |-
      Test the exit code.
  - name: --unknown-command
    description: |-
      Test with an unknown command.
  - name: --create-temp-files
    description: |-
      Test to create temp file and directory.
  - name: --create-temp-files
    description: |-
      Test to create temp file and directory.
  - name: --logging-level
    description: |-
      Test to output all log level messages.
  - name: --wait-indefinitely
    description: |-
      Test to wait indefinitely.
  - name: --show-help
    description: |-
      Test to show the help of the function.
"
}

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
    setLogLevelInt "debug"
  elif [ -n "${loggingLevel:-}" ]; then
    debug "This is a debug message."
    inform "This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out."
    succeed "This is a success message."
    warn "This is a warning message."$'\n'"With a second line."
    if isDebugMode; then
      echo "The debug mode is activated!" 1>&2
    fi
  elif [ -n "${waitIndefinitely:-}" ]; then
    inform "This is for testing valet core functions, waiting indefinitely."
    while true; do
      sleep 1
    done
  elif [ -n "${showHelp:-}" ]; then
    showHelp
  else
    # default to running all tests
    inform "Running all test suites in directory ⌜${VALET_HOME}/tests.d⌝."
    runTestSuites "${VALET_HOME}/tests.d"
  fi
}

function returnOne() { return 1; }

#===============================================================
# >>> Functions that can be used in the test files
#===============================================================

# Call this function after each test to write the test results to the report file.
# $1: the description of the test
# $2: the exit code of the test
#
# Usage:
#   endTest "Testing something" $?
function endTest() {
  local testDescription="${1:-}"
  local exitCode="${2:-}"

  # reset the standard output and error output
  resetFdRedirection

  debug "Ended test ⌜${testDescription}⌝ with exit code ⌜${exitCode}⌝."

  # write the test title
  printf "%s\n\n" "### ${testDescription:-test}" >>"${_TEST_REPORT_FILE}"

  # write the exit code
  printf "%s\n\n" "Exit code: ${exitCode}" >>"${_TEST_REPORT_FILE}"

  # write the standard output if any
  local stdOut
  IFS= read -rd '' stdOut <"${_TEST_STANDARD_OUTPUT_FILE}" || true
  if [ -n "${stdOut:-}" ]; then
    printf "%s\n\n%s\n%s\n%s\n\n" "**Standard** output:" "\`\`\`plaintext" "${stdOut%$'\n'}" "\`\`\`" >>"${_TEST_REPORT_FILE}"
  fi

  # write the error output if any
  local errorOut
  IFS= read -rd '' errorOut <"${_TEST_STANDARD_ERROR_FILE}" || true
  if [ -n "${errorOut:-}" ]; then
    printf "%s\n\n%s\n%s\n%s\n\n" "**Error** output:" "\`\`\`log" "${errorOut%$'\n'}" "\`\`\`" >>"${_TEST_REPORT_FILE}"
  fi

  # reset the standard output and error output files
  : >"${_TEST_STANDARD_OUTPUT_FILE}"
  : >"${_TEST_STANDARD_ERROR_FILE}"
  setFdRedirection

  set +Eeu +o pipefail
}

# This function is used to echo the content of the temp file with some substitutions.
# The substitutions are:
# - replace the VALET_HOME with $VALET_HOME
# - replace the current test directory with a dot
# - replace a line ending with a code line number :0 by :XXX
# - replace a line ending with "after ${SECONDS}s." by "after Xs."
# - replace a line with ${TMPDIR}/valet-*/ (temp directory) by /valet/
#
# This allows to have consistent results accross different execution environments for the tests.
#
# Usage:
#   myCommandThatProducesLinesWithValetDirectoryPath 2> "${_TEST_TEMP_FILE}"
#   echoTempFileWithSubstitution "${_TEST_TEMP_FILE}" 1>&2

function echoTempFileWithSubstitution() {
  local file="${1:-${_TEST_TEMP_FILE}}"
  local line
  local IFS=$'\n'
  while read -rd $'\n' line; do
    line="${line//${VALET_HOME}/\$VALET_HOME}"
    line="${line//${PWD}/.}"
    line="${line//${_TEMPORARY_DIRECTORY}/\/tmp}"
    line="${line//\/valet-*\//\/valet\/}"
    if [[ "${line}" =~ :[0-9]{1,}$ ]]; then
      line="${line/%:*/:XXX}"
    fi
    if [[ "${line}" =~ "after "[0-9]{1,}s.$ ]]; then
      line="${line/%after */after Xs.}"
    fi
    echo "${line}"
  done <"${file}"
}

#===============================================================
# >>> Internal tests functions
#===============================================================

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

  # setting up valet to minimize output difference between 2 runs
  setSimplerLogFunction

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

  resetLogLineFunction

  # reset the standard output and error output
  resetFdRedirection
}

function compareWithApproved() {
  local testDirectory exitCode approvedFile receivedFile receivedFileToCopy
  testDirectory="${1}"
  receivedFileToCopy="${2}"
  testName="${testDirectory##*/}"

  approvedFile="${testDirectory}/results.approved.md"
  receivedFile="${testDirectory}/results.received.md"

  if [ -f "${approvedFile}" ]; then
    if diff --color -u "${approvedFile}" "${receivedFileToCopy}" 1>&2; then
      debug "🧪 ${testName}: OK, equal to approved file."
      rm -f "${receivedFile}" 2>/dev/null || true
      return 0
    else
      echo "${receivedFile} is different than ${approvedFile} (see above)" 1>&2
      warn "🧪 ${testName}: KO, differs from approved file (see difference above)." | tee >(cat >&2)
    fi
  else
    warn "🧪 ${testName}: KO, no approved file found." 1>&2
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

function setFdRedirection() {
  # redirect the standard output and error output to files
  exec 3>&1 1>"${_TEST_STANDARD_OUTPUT_FILE}"
  exec 4>&2 2>"${_TEST_STANDARD_ERROR_FILE}"
}

function resetFdRedirection() {
  # reset the standard output and error output
  exec 1>&3 3>&-
  exec 2>&4 4>&-
}

function setSimplerLogFunction() {
  if [ -z "${ORIGINAL_LOG_LINE_FUNCTION:-}" ]; then
    ORIGINAL_LOG_LINE_FUNCTION="${LOG_LINE_FUNCTION}"
    ORIGINAL_VALET_NO_COLOR="${VALET_NO_COLOR:-}"
  fi
  VALET_NO_COLOR="true"
  setLogColors
  VALET_NO_TIMESTAMP="true"
  VALET_NO_ICON="true"
  _COLUMNS=120
  createLogLineFunction
  eval "${LOG_LINE_FUNCTION}"
}

function resetLogLineFunction() {
  VALET_NO_COLOR="${ORIGINAL_VALET_NO_COLOR}"
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
