#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".before-test"
fi

function testLogging() {
  # testing log level
  echo "---- level success with variable ----" 1>&2
  export VALET_LOG_LEVEL="success"
  "${VALET_HOME}/valet" self test-core --logging-level
  unset VALET_LOG_LEVEL
  echo "---- level warn with option ----" 1>&2
  "${VALET_HOME}/valet" --log-level "warn" self test-core --logging-level
  echo "---- level debug with verbose option ----" 1>&2
  "${VALET_HOME}/valet" -v self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endTest "Testing log level" 0

  # testing the different log options
  unset VALET_NO_COLOR
  unset VALET_NO_TIMESTAMP
  unset VALET_NO_ICON
  unset VALET_NO_WRAP
  unset VALET_CI_MODE

  echo "---- normal output ----" 1>&2
  "${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2

  echo "---- CI mode ----" 1>&2
  export VALET_CI_MODE="true"
  "${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_CI_MODE

  echo "---- normal, no timestamp ----" 1>&2
  export VALET_NO_TIMESTAMP="true"
  "${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_NO_TIMESTAMP

  echo "---- normal, no icons ----" 1>&2
  export VALET_NO_ICON="true"
  "${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_NO_ICON

  echo "---- normal, no wrap ----" 1>&2
  export VALET_NO_WRAP="true"
  "${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_NO_WRAP

  echo "---- normal, wrapping at 80 ----" 1>&2
  export VALET_LOG_COLUMNS="80"
  "${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_LOG_COLUMNS

  endTest "Testing log options" 0

  unset VALET_NO_WRAP
  unset VALET_CI_MODE
  export VALET_NO_COLOR="true"
  export VALET_NO_TIMESTAMP="true"
  export VALET_NO_ICON="true"
}

function main() {
  testLogging
}

main

source ".after-test"