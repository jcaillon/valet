#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-fs
source fs

test::markdown "The profiler is an excellent tool to debug your command. The following example shows what you would get when you enable it."$'\n\n'"Notice that the profiling file is cleaned up after the command execution to maximize readability."

function main() {
  _OPTION_PATH_ONLY=true fs::createTempFile
  export VALET_CONFIG_COMMAND_PROFILING_FILE="${RETURNED_VALUE}"
  _OPTION_PATH_ONLY=true fs::createTempFile
  export VALET_CONFIG_STARTUP_PROFILING_FILE="${RETURNED_VALUE}"

  test::markdown "**Exported variables:**"
  test::printVars VALET_CONFIG_COMMAND_PROFILING_FILE VALET_CONFIG_STARTUP_PROFILING_FILE


  test::title "✅ Testing the profiler cli option"
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/valet" -x self mock2 arg1 arg2
  test::exec fs::cat "${VALET_CONFIG_COMMAND_PROFILING_FILE}"
  rm -f "${VALET_CONFIG_COMMAND_PROFILING_FILE}"


  test::title "✅ Testing the profiler with cleanup using bash"
  test::exec VALET_CONFIG_STRICT_PURE_BASH=true "${GLOBAL_INSTALLATION_DIRECTORY}/valet" -x self mock2 arg1 arg2
  test::exec fs::cat "${VALET_CONFIG_COMMAND_PROFILING_FILE}"
  rm -f "${VALET_CONFIG_COMMAND_PROFILING_FILE}"


  test::title "✅ Testing to enable the profiler on Valet startup"
  test::exec VALET_CONFIG_STARTUP_PROFILING=true "${GLOBAL_INSTALLATION_DIRECTORY}/valet" --log-level error -x self mock1 logging-level
  test::exec fs::head "${VALET_CONFIG_STARTUP_PROFILING_FILE}" 1
}


function test::transformTextBeforeFlushing() {
  local line text=""
  local IFS=$'\n'
  for line in ${_TEST_OUTPUT}; do
    text+="${line/*self-mock.sh:/00 00 00 0.0XXX 0.0XXX                    self-mock.sh:}"$'\n'
  done
  _TEST_OUTPUT="${text%$'\n'}"
}

main
