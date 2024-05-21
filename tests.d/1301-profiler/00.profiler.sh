#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-io
source io

test::commentTest "The profiler is an excellent tool to debug your command. The following example shows what you would get when you enable it."$'\n\n'"Notice that the profiling file has been cleanup after the command execution to maximize readability."

function testProfiler() {
  # testing command profiling + startup
  io::createTempFile && export VALET_CONFIG_COMMAND_PROFILING_FILE="${RETURNED_VALUE}"
  io::createTempFile && export VALET_CONFIG_STARTUP_PROFILING_FILE="${RETURNED_VALUE}"
  export VALET_CONFIG_COMMAND_PROFILING_FILE
  export VALET_CONFIG_STARTUP_PROFILING_FILE

  echo "→ valet -x self mock2 arg1 arg2"

  echo
  echo "→ cat 'profiler.log'"
  ("${GLOBAL_VALET_HOME}/valet" -x self mock2 arg1 arg2)
  if [[ -s "${VALET_CONFIG_COMMAND_PROFILING_FILE}" ]]; then
    echoFileWithSubstitution "${VALET_CONFIG_COMMAND_PROFILING_FILE}"
  fi

  test::endTest "Testing profiling for command" 0

  echo "→ VALET_CONFIG_STARTUP_PROFILING=true valet --log-level error -x self mock1 logging-level"

  (VALET_CONFIG_STARTUP_PROFILING=true "${GLOBAL_VALET_HOME}/valet" --log-level error -x self mock1 logging-level)
  if [[ -s "${VALET_CONFIG_STARTUP_PROFILING_FILE}" ]]; then
    echo "A startup profiling file has been created to log everything happening from the start of Valet to the start of the chosen command."
  fi
  if [[ -s "${VALET_CONFIG_COMMAND_PROFILING_FILE}" ]]; then
    echo "A command profiling file has been created to log everything happening in the chosen command execution."
  fi

  test::endTest "Testing profiling for command and startup" 0

  unset VALET_CONFIG_STARTUP_PROFILING \
    VALET_CONFIG_COMMAND_PROFILING_FILE \
    VALET_CONFIG_STARTUP_PROFILING_FILE
}

function testCommandProfiler() {
  # testing command profiling
  io::createTempFile && export VALET_CONFIG_COMMAND_PROFILING_FILE="${RETURNED_VALUE}"
  export VALET_CONFIG_COMMAND_PROFILING_FILE

  unset VALET_CONFIG_COMMAND_PROFILING_FILE
}

function echoFileWithSubstitution() {
  local file="${1}"
  local line
  local IFS=$'\n'
  while read -rd $'\n' line || [[ -n ${line:-} ]]; do
    line="${line/*self-mock.sh:/00 00 00 0.0XXX 0.0XXX                    self-mock.sh:}"
    echo "${line}"
  done <"${file}"
}

function main() {
  testProfiler
  testCommandProfiler
}

main
