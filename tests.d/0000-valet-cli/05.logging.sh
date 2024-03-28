#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".before-test"
fi

function testLogging() {
  # testing log level
  echo "→ VALET_LOG_LEVEL=success valet self test-core --logging-level"
  export VALET_LOG_LEVEL="success"
  ("${VALET_HOME}/valet" self test-core --logging-level)
  unset VALET_LOG_LEVEL
  endTest "Testing log with success level" 0

  echo "→ valet --log-level warn self test-core --logging-level"
  ("${VALET_HOME}/valet" --log-level "warn" self test-core --logging-level)
  endTest "Testing log with warn level" 0

  echo "→ valet -v self test-core --logging-level"
  ("${VALET_HOME}/valet" -v self test-core --logging-level)
  endTest "Testing log with debug level" 0

  # testing the different log options
  unset VALET_NO_COLOR
  unset VALET_NO_TIMESTAMP
  unset VALET_NO_ICON
  unset VALET_NO_WRAP
  unset VALET_CI_MODE

  echo "→ valet self test-core --logging-level"
  ("${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing default logging" 0

  export VALET_NO_COLOR="true"

  echo "→ VALET_NO_COLOR=true valet self test-core --logging-level"
  ("${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no color logging" 0

  echo "→ VALET_NO_COLOR=true VALET_CI_MODE=true valet self test-core --logging-level"
  export VALET_CI_MODE="true"
  ("${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_CI_MODE
  endTest "Testing CI MODE logging" 0

  echo "→ VALET_NO_COLOR=true VALET_NO_TIMESTAMP=true valet self test-core --logging-level"
  export VALET_NO_TIMESTAMP="true"
  ("${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_NO_TIMESTAMP
  endTest "Testing no timestamp logging" 0

  echo "→ VALET_NO_COLOR=true VALET_NO_ICON=true valet self test-core --logging-level"
  export VALET_NO_ICON="true"
  ("${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_NO_ICON
  endTest "Testing no icon logging" 0

  echo "→ VALET_NO_COLOR=true VALET_NO_WRAP=true valet self test-core --logging-level"
  export VALET_NO_WRAP="true"
  ("${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_NO_WRAP
  endTest "Testing no wrap logging" 0

  echo "→ VALET_NO_COLOR=true VALET_LOG_COLUMNS=80 valet self test-core --logging-level"
  export VALET_LOG_COLUMNS="80"
  ("${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  unset VALET_LOG_COLUMNS
  endTest "Testing wrap at 80 logging" 0

  unset VALET_CI_MODE
  export VALET_NO_COLOR="true"
  export VALET_NO_TIMESTAMP="true"
  export VALET_NO_ICON="true"
  export VALET_NO_WRAP="true"
  export _COLUMNS=120
}

function main() {
  testLogging
}

main

source ".after-test"