#!/usr/bin/env bash

function testLogging() {
  test::title "Passing logging level through an environment variable"

  test::exec printf '%s\n' 'coucou' 'hello 2nd'

  test::exec VALET_LOG_LEVEL=success "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level

  echo "→ valet --log-level warning self mock1 logging-level"
  ("${GLOBAL_VALET_HOME}/valet" --log-level "warning" self mock1 logging-level)
  test::endTest "Testing log with warning level" 0

  echo "→ valet -v self mock1 logging-level"
  (unset SECONDS; SECONDS=0; "${GLOBAL_VALET_HOME}/valet" -v self mock1 logging-level)
  test::endTest "Testing log with debug level" 0

  echo "→ valet -w self mock1 logging-level"
  (unset SECONDS; SECONDS=0; "${GLOBAL_VALET_HOME}/valet" -w self mock1 logging-level)
  test::endTest "Testing log with trace level" 0

  # testing the different log options

  echo "→ valet self mock1 logging-level"
  resetLogOptions
  ("${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${GLOBAL_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  test::endTest "Testing default logging" 0

  echo "→ VALET_CONFIG_ENABLE_COLORS=true VALET_CONFIG_ENABLE_NERDFONT_ICONS=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_ENABLE_COLORS=true VALET_CONFIG_ENABLE_NERDFONT_ICONS=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${GLOBAL_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  test::endTest "Testing color + icon logging" 0

  echo "→ VALET_CONFIG_LOG_DISABLE_WRAP=true VALET_CONFIG_LOG_DISABLE_TIME=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_LOG_DISABLE_WRAP=true VALET_CONFIG_LOG_DISABLE_TIME=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${GLOBAL_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  test::endTest "Testing no timestamp, no wrap logging" 0

  echo "→ VALET_CONFIG_LOG_ENABLE_TIMESTAMP= true VALET_CONFIG_LOG_COLUMNS=80 valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_LOG_ENABLE_TIMESTAMP=true VALET_CONFIG_LOG_COLUMNS=80 "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level 2> "${GLOBAL_TEST_TEMP_FILE}")
  echoTempFileWithTimeStampSubstitution 1>&2
  test::endTest "Testing enable log timestamp and wrap at 80 logging" 0
}

function testLog::printRawAndFile() {
  echo "→ VALET_CONFIG_LOG_DISABLE_TIME=true VALET_CONFIG_LOG_DISABLE_WRAP=false VALET_CONFIG_LOG_COLUMNS=80 valet self mock1 print-raw-and-file"
  (VALET_CONFIG_LOG_DISABLE_TIME=true VALET_CONFIG_LOG_DISABLE_WRAP=false VALET_CONFIG_LOG_COLUMNS=80 "${GLOBAL_VALET_HOME}/valet" self mock1 print-raw-and-file)

  test::endTest "Testing printing raw string and printing file" 0
}

function resetLogOptions() {
  export VALET_CONFIG_ENABLE_COLORS=false
  export VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
  export VALET_CONFIG_LOG_DISABLE_TIME=false
  export VALET_CONFIG_LOG_DISABLE_WRAP=false
  export VALET_CONFIG_LOG_ENABLE_TIMESTAMP=false
  export VALET_CONFIG_LOG_COLUMNS=120
  export GLOBAL_COLUMNS=120
}

function testFileLogging() {
  io::createTempDirectory
  logDirectory="${RETURNED_VALUE}"

  echo "→ VALET_CONFIG_LOG_TO_DIRECTORY=${logDirectory} VALET_CONFIG_LOG_DISABLE_TIME=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_LOG_TO_DIRECTORY="${logDirectory}" VALET_CONFIG_LOG_DISABLE_TIME=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level)
  echo
  echo "→ io::countArgs ${logDirectory}/*"
  io::countArgs "${logDirectory}"/*
  echo "${RETURNED_VALUE}"
  test::endTest "Testing that we can output the logs to a file additionally to console" 0

  echo "→ VALET_CONFIG_LOG_FILENAME_PATTERN='logFile=test.log' VALET_CONFIG_LOG_TO_DIRECTORY=${logDirectory} VALET_CONFIG_LOG_DISABLE_TIME=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_LOG_FILENAME_PATTERN='logFile=test.log' VALET_CONFIG_LOG_TO_DIRECTORY="${logDirectory}" VALET_CONFIG_LOG_DISABLE_TIME=true "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level)
  echo
  echo "→ cat ${logDirectory}/test.log"
  io::cat "${logDirectory}/test.log"
  test::endTest "Testing that we can output the logs to a specific file name additionally to console" 0

  echo "→ VALET_CONFIG_LOG_FD=${logDirectory}/test2.log VALET_CONFIG_LOG_DISABLE_TIME=true valet self mock1 logging-level"
  resetLogOptions
  (VALET_CONFIG_LOG_FD="${logDirectory}/test2.log" VALET_CONFIG_LOG_DISABLE_TIME=true  "${GLOBAL_VALET_HOME}/valet" self mock1 logging-level)
  echo
  echo "→ cat ${logDirectory}/test2.log"
  io::cat "${logDirectory}/test2.log"
  test::endTest "Testing that we can output the logs to a file directly instead of the console err stream" 0
}

function main() {
  testLogging
}

main
