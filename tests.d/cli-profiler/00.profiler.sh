#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-io
source io

test::comment "The profiler is an excellent tool to debug your command. The following example shows what you would get when you enable it."$'\n\n'"Notice that the profiling file is cleaned up after the command execution to maximize readability."

function main() {
  io::createTempFile
  export VALET_CONFIG_COMMAND_PROFILING_FILE="${RETURNED_VALUE}"
  io::createTempFile
  export VALET_CONFIG_STARTUP_PROFILING_FILE="${RETURNED_VALUE}"

  test::comment "**Exported variables:**"
  test::revealVars VALET_CONFIG_COMMAND_PROFILING_FILE VALET_CONFIG_STARTUP_PROFILING_FILE


  test::title "Testing the profiler cli option"
  test::exec "${GLOBAL_VALET_HOME}/valet" -x self mock2 arg1 arg2
  test::exec io::cat "${VALET_CONFIG_COMMAND_PROFILING_FILE}"
  rm -f "${VALET_CONFIG_COMMAND_PROFILING_FILE}"


  test::title "Testing the profiler with cleanup using bash"
  test::exec VALET_CONFIG_LOG_CLEANUP_USING_BASH=true "${GLOBAL_VALET_HOME}/valet" -x self mock2 arg1 arg2
  test::exec io::cat "${VALET_CONFIG_COMMAND_PROFILING_FILE}"
  rm -f "${VALET_CONFIG_COMMAND_PROFILING_FILE}"


  test::title "Testing to enable the profiler on Valet startup"
  test::exec VALET_CONFIG_STARTUP_PROFILING=true "${GLOBAL_VALET_HOME}/valet" --log-level error -x self mock1 logging-level
  if [[ ! -s "${VALET_CONFIG_STARTUP_PROFILING_FILE}" ]]; then
    test::fail "The startup profiling file is empty."
  fi
}


function test::transformTextBeforeFlushing() {
  local line text=""
  local IFS=$'\n'
  while read -rd $'\n' line || [[ -n ${line:-} ]]; do
    text+="${line/*self-mock.sh:/00 00 00 0.0XXX 0.0XXX                    self-mock.sh:}"$'\n'
  done <<<"${_TEST_OUTPUT}"
  _TEST_OUTPUT="${text%$'\n'}"
}

main
