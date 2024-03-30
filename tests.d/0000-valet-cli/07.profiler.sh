#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".before-test"
fi

function testProfiler() {
  # testing command profiling + startup
  createTempFile && export VALET_CMD_PROFILING_FILE="${LAST_RETURNED_VALUE}"
  createTempFile && export VALET_STARTUP_PROFILING_FILE="${LAST_RETURNED_VALUE}"
  export VALET_CMD_PROFILING_FILE
  export VALET_STARTUP_PROFILING_FILE
  export VALET_LOG_LEVEL="warning"

  export VALET_STARTUP_PROFILING="true"
  echo "→ valet --log-level error -x self test-core --logging-level"

  ("${VALET_HOME}/valet" --log-level error -x self test-core --logging-level)
  if [[ -s "${VALET_CMD_PROFILING_FILE}" ]]; then
    echo "OK, command profiling file is not empty."
  else
    echo "KO, command profiling file should not be empty."
  fi
  if [[ -s "${VALET_STARTUP_PROFILING_FILE}" ]]; then
    echo "OK, startup profiling file is not empty."
  else
    echo "KO, startup profiling file should not be empty."
  fi

  endTest "Testing profiling for command and startup" 0

  unset VALET_LOG_LEVEL
  unset VALET_STARTUP_PROFILING
  unset VALET_CMD_PROFILING_FILE
  unset VALET_STARTUP_PROFILING_FILE
}

function main() {
  testProfiler
}

main

source ".after-test"