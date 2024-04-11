#!/usr/bin/env bash

builtin source ".before-test"

function testLogging() {
  # testing log level
  echo "→ VALET_LOG_LEVEL=success valet self mock1 logging-level"
  export VALET_LOG_LEVEL="success"
  ("${GLOBAL_VALET_HOME}/valet" self mock1 logging-level)
  unset VALET_LOG_LEVEL
  endTest "Testing log with success level" 0

  echo "→ valet --log-level warning self mock1 logging-level"
  ("${GLOBAL_VALET_HOME}/valet" --log-level "warning" self mock1 logging-level)
  endTest "Testing log with warning level" 0

  echo "→ valet -v self mock1 logging-level"
  ("${GLOBAL_VALET_HOME}/valet" -v self mock1 logging-level)
  endTest "Testing log with debug level" 0

  # testing the different log options

  echo "→ VALET_CONFIG_DISABLE_COLORS=false valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=false "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing default logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no color logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_ENABLE_CI_MODE=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_ENABLE_CI_MODE=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing CI MODE logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_LOG_TIMESTAMP=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_LOG_TIMESTAMP=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no timestamp logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_NERDFONT_ICONS=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_NERDFONT_ICONS=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no icon logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_LOG_WRAP=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_LOG_WRAP=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no wrap logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_LOG_COLUMNS=80 valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_LOG_COLUMNS=80 "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing wrap at 80 logging" 0
}

function resetLogOptions() {
  unset VALET_CONFIG_DISABLE_COLORS \
    VALET_CONFIG_DISABLE_LOG_TIMESTAMP \
    VALET_CONFIG_DISABLE_NERDFONT_ICONS \
    VALET_CONFIG_DISABLE_LOG_WRAP \
    VALET_CONFIG_ENABLE_CI_MODE \
    VALET_CONFIG_LOG_COLUMNS \
    GLOBAL_COLUMNS
  export VALET_CONFIG_LOG_COLUMNS=120
}

function main() {
  testLogging
}

main

builtin source ".after-test"