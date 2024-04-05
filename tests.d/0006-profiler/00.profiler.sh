#!/usr/bin/env bash

include io

commentTest "The profiler is an excellent tool to debug your command. The following example shows what you would get when you enable it."$'\n\n'"Notice that the profiling file has been cleanup after the command execution to maximize readability."

function testProfiler() {
  # testing command profiling + startup
  if [[ TEMPORARY_DIRECTORY_NUMBER -lt 100 ]]; then TEMPORARY_DIRECTORY_NUMBER=100; fi
  if [[ TEMPORARY_FILE_NUMBER -lt 100 ]]; then TEMPORARY_FILE_NUMBER=100; fi
  createTempFile && export VALET_COMMAND_PROFILING_FILE="${LAST_RETURNED_VALUE}"
  createTempFile && export VALET_STARTUP_PROFILING_FILE="${LAST_RETURNED_VALUE}"
  export VALET_COMMAND_PROFILING_FILE
  export VALET_STARTUP_PROFILING_FILE

  echo "→ valet -x showcase command1 arg1 arg2"

  echo
  echo "→ cat 'profiler.log'"
  ("${VALET_HOME}/valet" -x showcase command1 arg1 arg2)
  if [[ -s "${VALET_COMMAND_PROFILING_FILE}" ]]; then
    echoFileWithSubstitution "${VALET_COMMAND_PROFILING_FILE}"
  fi

  endTest "Testing profiling for command" 0

  echo "→ VALET_STARTUP_PROFILING=true valet --log-level error -x self test-core --logging-level"

  (VALET_STARTUP_PROFILING=true "${VALET_HOME}/valet" --log-level error -x self test-core --logging-level)
  if [[ -s "${VALET_STARTUP_PROFILING_FILE}" ]]; then
    echo "A startup profiling file has been created to log everything happening from the start of Valet to the start of the chosen command."
  fi
  if [[ -s "${VALET_COMMAND_PROFILING_FILE}" ]]; then
    echo "A command profiling file has been created to log everything happening in the chosen command execution."
  fi

  endTest "Testing profiling for command and startup" 0

  unset VALET_LOG_LEVEL
  unset VALET_STARTUP_PROFILING
  unset VALET_COMMAND_PROFILING_FILE
  unset VALET_STARTUP_PROFILING_FILE
}

function testCommandProfiler() {
  # testing command profiling
  createTempFile && export VALET_COMMAND_PROFILING_FILE="${LAST_RETURNED_VALUE}"
  export VALET_COMMAND_PROFILING_FILE


  unset VALET_LOG_LEVEL
  unset VALET_COMMAND_PROFILING_FILE
}

function echoFileWithSubstitution() {
  local file="${1}"
  local line
  local IFS=$'\n'
  while read -rd $'\n' line; do
    line="${line/*showcase.sh:/00 00 00 0.0XXX 0.0XXX                     showcase.sh:}"
    echo "${line}"
  done <"${file}"
}

function main() {
  testProfiler
  testCommandProfiler
}

main
