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

  echo "→ valet self mock1 logging-level"
  resetLogOptions
  ("${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${GLOBAL_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing default logging" 0

  echo "→ VALET_CONFIG_ENABLE_COLORS=true VALET_CONFIG_ENABLE_NERDFONT_ICONS=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_ENABLE_COLORS=true VALET_CONFIG_ENABLE_NERDFONT_ICONS=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${GLOBAL_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing color + icon logging" 0

  echo "→ VALET_CONFIG_DISABLE_LOG_WRAP=true VALET_CONFIG_DISABLE_LOG_TIME=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_LOG_WRAP=true VALET_CONFIG_DISABLE_LOG_TIME=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${GLOBAL_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no timestamp, no wrap logging" 0

  echo "→ VALET_CONFIG_ENABLE_LOG_TIMESTAMP= true VALET_CONFIG_LOG_COLUMNS=80 valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_ENABLE_LOG_TIMESTAMP=true VALET_CONFIG_LOG_COLUMNS=80 "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${GLOBAL_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing enable log timestamp and wrap at 80 logging" 0
}

function resetLogOptions() {
  export VALET_CONFIG_ENABLE_COLORS=false
  export VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
  export VALET_CONFIG_DISABLE_LOG_TIME=false
  export VALET_CONFIG_DISABLE_LOG_WRAP=false
  export VALET_CONFIG_ENABLE_LOG_TIMESTAMP=false
  export VALET_CONFIG_LOG_COLUMNS=120
  export GLOBAL_COLUMNS=120
}

function main() {
  testLogging
}

main

builtin source ".after-test"