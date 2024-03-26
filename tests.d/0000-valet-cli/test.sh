#!/usr/bin/env bash

# we will run valet commands so we need to set the correct user directory
export VALET_USER_DIRECTORY="${VALET_HOME}/examples.d"

# setting up valet to minimize output difference between 2 runs
export VALET_NO_COLOR="true"
export VALET_NO_TIMESTAMP="true"
export VALET_NO_ICON="true"
export VALET_NO_WRAP="true"
export _COLUMNS=180

function main() {
  testEventHandlers
  testLogging
  testMainOptions
  testCleaning
}

function testEventHandlers() {
  # testing error handling (a statement returns != 0)
  valet self test-core --error 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endSubTest "Testing error handling" $?

  # testing exit code (exit 5) and custom exit function
  valet self test-core --exit
  endSubTest "Testing exit message --exit" $?

  # testing the fail function
  valet self test-core --fail
  endSubTest "Testing fail function --fail" $?

  # testing the unknown command handler
  valet self test-core --unknown-command 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endSubTest "Testing unknown command handling" $?

  # testing kill
  # valet self test-core --wait-indefinitely &
  # processId=$!
  # kill -TERM ${processId}
  # wait ${processId} || true
  # endSubTest "Testing kill" $?
}

function testLogging() {
  # testing log level
  echo "---- level success with variable ----" 1>&2
  export VALET_LOG_LEVEL="success"
  valet self test-core --logging-level
  unset VALET_LOG_LEVEL
  echo "---- level warn with option ----" 1>&2
  valet --log-level "warn" self test-core --logging-level
  echo "---- level debug with verbose option ----" 1>&2
  valet -v self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endSubTest "Testing log level" 0

  # testing the different log options
  unset VALET_NO_COLOR
  unset VALET_NO_TIMESTAMP
  unset VALET_NO_ICON
  unset VALET_NO_WRAP
  unset VALET_CI_MODE

  echo "---- normal output ----" 1>&2
  valet self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2

  echo "---- CI mode ----" 1>&2
  export VALET_CI_MODE="true"
  valet self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_CI_MODE

  echo "---- normal, no timestamp ----" 1>&2
  export VALET_NO_TIMESTAMP="true"
  valet self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_NO_TIMESTAMP

  echo "---- normal, no icons ----" 1>&2
  export VALET_NO_ICON="true"
  valet self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_NO_ICON

  echo "---- normal, no wrap ----" 1>&2
  export VALET_NO_WRAP="true"
  valet self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_NO_WRAP

  echo "---- normal, wrapping at 80 ----" 1>&2
  export VALET_LOG_COLUMNS="80"
  valet self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_LOG_COLUMNS

  endSubTest "Testing log options" 0

  unset VALET_NO_WRAP
  unset VALET_CI_MODE
  export VALET_NO_COLOR="true"
  export VALET_NO_TIMESTAMP="true"
  export VALET_NO_ICON="true"
}

function echoTempFileWithTimeStampSubstitution() {
  local file="${_TEST_TEMP_FILE}"
  local line
  local IFS=$'\n'
  while read -rd $'\n' line; do
    line="${line//??:??:??/HH:MM:SS}"
    line="${line//????-??-??/YYYY:MM:DD}"
    echo "${line}"
  done < "${file}"
}

function testMainOptions() {
  # testing profiling
  createTempFile && export VALET_CMD_PROFILING_FILE="${LAST_RETURNED_VALUE}"
  createTempFile && export VALET_STARTUP_PROFILING_FILE="${LAST_RETURNED_VALUE}"
  export VALET_CMD_PROFILING_FILE
  export VALET_STARTUP_PROFILING_FILE
  export VALET_LOG_LEVEL="warn"

  # testing command profiling + startup
  export VALET_STARTUP_PROFILING="true"
  valet --log-level "fail" -x self test-core --logging-level
  if ! isFileEmpty "${VALET_CMD_PROFILING_FILE}"; then
    echo "OK, command profiling file is not empty."
  else
    echo "KO, command profiling file should not be empty."
  fi
  if ! isFileEmpty "${VALET_STARTUP_PROFILING_FILE}"; then
    echo "OK, startup profiling file is not empty."
  else
    echo "KO, startup profiling file should not be empty."
  fi
  endSubTest "Testing profiling for command and startup" 0

  unset VALET_LOG_LEVEL
  unset VALET_STARTUP_PROFILING
  unset VALET_CMD_PROFILING_FILE
  unset VALET_STARTUP_PROFILING_FILE

  # testing version option
  : > "${_TEST_TEMP_FILE}"
  valet --version 1> "${_TEST_TEMP_FILE}"
  if ! isFileEmpty "${_TEST_TEMP_FILE}"; then
    echo "OK, we got a version."
  else
    echo "KO, we did not get a version."
  fi
  endSubTest "Testing version option" $?

}

function testCleaning() {
  # testing temp files/directories creation, cleaning and custom cleanUp
  (valet self test-core --create-temp-files) 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endSubTest "Testing temp files/directories creation, cleaning and custom cleanUp" $?
}

main
