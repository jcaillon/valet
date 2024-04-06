#!/usr/bin/env bash

builtin source ".before-test"

function testLogging() {
  # testing log level
  echo "→ VALET_LOG_LEVEL=success valet self test-core1 logging-level"
  export VALET_LOG_LEVEL="success"
  ("${VALET_HOME}/valet" self test-core1 logging-level)
  unset VALET_LOG_LEVEL
  endTest "Testing log with success level" 0

  echo "→ valet --log-level warning self test-core1 logging-level"
  ("${VALET_HOME}/valet" --log-level "warning" self test-core1 logging-level)
  endTest "Testing log with warning level" 0

  echo "→ valet -v self test-core1 logging-level"
  ("${VALET_HOME}/valet" -v self test-core1 logging-level)
  endTest "Testing log with debug level" 0

  # testing the different log options

  echo "→ valet self test-core1 logging-level"
  resetLogOptions
  ("${VALET_HOME}/valet" self test-core1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing default logging" 0

  echo "→ VALET_NO_COLOR=true valet self test-core1 logging-level"
  resetLogOptions
  (VALET_NO_COLOR=true "${VALET_HOME}/valet" self test-core1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no color logging" 0

  echo "→ VALET_NO_COLOR=true VALET_CI_MODE=true valet self test-core1 logging-level"
  resetLogOptions
  (VALET_NO_COLOR=true VALET_CI_MODE=true "${VALET_HOME}/valet" self test-core1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing CI MODE logging" 0

  echo "→ VALET_NO_COLOR=true VALET_NO_TIMESTAMP=true valet self test-core1 logging-level"
  resetLogOptions
  (VALET_NO_COLOR=true VALET_NO_TIMESTAMP=true "${VALET_HOME}/valet" self test-core1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no timestamp logging" 0

  echo "→ VALET_NO_COLOR=true VALET_NO_ICON=true valet self test-core1 logging-level"
  resetLogOptions
  (VALET_NO_COLOR=true VALET_NO_ICON=true "${VALET_HOME}/valet" self test-core1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no icon logging" 0

  echo "→ VALET_NO_COLOR=true VALET_NO_WRAP=true valet self test-core1 logging-level"
  resetLogOptions
  (VALET_NO_COLOR=true VALET_NO_WRAP=true "${VALET_HOME}/valet" self test-core1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no wrap logging" 0

  echo "→ VALET_NO_COLOR=true VALET_LOG_COLUMNS=80 valet self test-core1 logging-level"
  resetLogOptions
  (VALET_NO_COLOR=true VALET_LOG_COLUMNS=80 "${VALET_HOME}/valet" self test-core1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing wrap at 80 logging" 0
}

function resetLogOptions() {
  unset VALET_NO_COLOR
  unset VALET_NO_TIMESTAMP
  unset VALET_NO_ICON
  unset VALET_NO_WRAP
  unset VALET_CI_MODE
  unset VALET_LOG_COLUMNS
  unset _COLUMNS
  export VALET_LOG_COLUMNS=120
}

function main() {
  testLogging
}

main

builtin source ".after-test"