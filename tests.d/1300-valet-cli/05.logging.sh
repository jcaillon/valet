#!/usr/bin/env bash

builtin source ".before-test"

function testLogging() {
  # testing log level
  echo "→ VALET_LOG_LEVEL=success valet self mock1 logging-level"
  export VALET_LOG_LEVEL="success"
  ("${_VALET_HOME}/valet" self mock1 logging-level)
  unset VALET_LOG_LEVEL
  endTest "Testing log with success level" 0

  echo "→ valet --log-level warning self mock1 logging-level"
  ("${_VALET_HOME}/valet" --log-level "warning" self mock1 logging-level)
  endTest "Testing log with warning level" 0

  echo "→ valet -v self mock1 logging-level"
  ("${_VALET_HOME}/valet" -v self mock1 logging-level)
  endTest "Testing log with debug level" 0

  # testing the different log options

  echo "→ valet self mock1 logging-level"
  resetLogOptions
  ("${_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing default logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true "${_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no color logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_ENABLE_CI_MODE=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_ENABLE_CI_MODE=true "${_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing CI MODE logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_LOG_TIMESTAMP=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_LOG_TIMESTAMP=true "${_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no timestamp logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_NERDFONT_ICONS=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_NERDFONT_ICONS=true "${_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no icon logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_LOG_WRAP=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_DISABLE_LOG_WRAP=true "${_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing no wrap logging" 0

  echo "→ VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_LOG_COLUMNS=80 valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_DISABLE_COLORS=true VALET_CONFIG_LOG_COLUMNS=80 "${_VALET_HOME}/valet" self mock1 logging-level 2> "${_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  endTest "Testing wrap at 80 logging" 0
}

function resetLogOptions() {
  unset VALET_CONFIG_DISABLE_COLORS
  unset VALET_CONFIG_DISABLE_LOG_TIMESTAMP
  unset VALET_CONFIG_DISABLE_NERDFONT_ICONS
  unset VALET_CONFIG_DISABLE_LOG_WRAP
  unset VALET_CONFIG_ENABLE_CI_MODE
  unset VALET_CONFIG_LOG_COLUMNS
  unset _COLUMNS
  export VALET_CONFIG_LOG_COLUMNS=120
}

function main() {
  testLogging
}

main

builtin source ".after-test"