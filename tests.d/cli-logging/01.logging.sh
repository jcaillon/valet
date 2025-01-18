#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-io
source io

function main() {
  test_logLevelOptions
  test_logDisplayOptions
  test_logOutputOptions
}

function test_logLevelOptions() {
  test::title "✅ Logging level through an environment variable"
  test::exec VALET_LOG_LEVEL=success "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level


  test::title "✅ Logging level with --log-level option"
  test::exec "${GLOBAL_VALET_HOME}/valet" --log-level warning self mock1 logging-level


  # shellcheck disable=SC2317
  function test::transformTextBeforeFlushing() { _TEST_OUTPUT="${_TEST_OUTPUT//after ?s/after 0s}"; }


  test::title "✅ Logging level with --verbose option"
  test::exec "${GLOBAL_VALET_HOME}/valet" -v self mock1 logging-level


  test::title "✅ Logging level with --very-verbose option"
  test::exec "${GLOBAL_VALET_HOME}/valet" -w self mock1 logging-level


  unset -f test::transformTextBeforeFlushing
}


function test_logDisplayOptions() {
  test::title "✅ Testing that we can change the log display options"
  test::exec VALET_CONFIG_ENABLE_COLORS=true VALET_CONFIG_ENABLE_NERDFONT_ICONS=true VALET_CONFIG_LOG_DISABLE_WRAP=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level
}


function test_logOutputOptions() {
  io::createTempDirectory
  local logDir="${RETURNED_VALUE}"

  test::title "✅ Testing that we can output the logs to a directory additionally to console"
  test::exec VALET_CONFIG_LOG_TO_DIRECTORY="${logDir}" "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level
  # shellcheck disable=SC2317
  function test::transformTextBeforeFlushing() { _TEST_OUTPUT="${_TEST_OUTPUT//????-??-??_??h??m??s.log/2025-01-17_21h29m41s.log}" ; }
  test::func io::listFiles "${logDir}"
  unset -f test::transformTextBeforeFlushing


  test::title "✅ Testing that we can output the logs to a specific file name additionally to console"
  test::exec VALET_CONFIG_LOG_FILENAME_PATTERN='logFile=test.log' VALET_CONFIG_LOG_TO_DIRECTORY="${logDir}" "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level
  test::exec io::cat "${logDir}/test.log"


  test::title "✅ Testing that we can output the logs to a specific file descriptor"
  test::exec VALET_CONFIG_LOG_FD="${logDir}/test2.log" "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 3>&1
  test::exec io::cat "${logDir}/test2.log"
}

main
