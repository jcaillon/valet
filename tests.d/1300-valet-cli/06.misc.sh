#!/usr/bin/env bash

builtin source ".before-test"

function testMainOptions() {
  # testing version option
  : > "${_TEST_TEMP_FILE}"
  echo "→ valet --version"
  ("${GLOBAL_VALET_HOME}/valet" --version 1> "${_TEST_TEMP_FILE}")
  if [[ -s "${_TEST_TEMP_FILE}" ]]; then
    echo "OK, we got a version."
  else
    echo "KO, we did not get a version."
  fi
  endTest "Testing version option" $?

  # testing unknown option, corrected with fuzzy match
  echo "→ valet -prof"
  ("${GLOBAL_VALET_HOME}/valet" -prof)
  endTest "Testing unknown option, corrected with fuzzy match" $?
}

function testCleaning() {
  # testing temp files/directories creation, cleaning and custom cleanUp
  echo "→ valet self mock1 create-temp-files"
  ("${GLOBAL_VALET_HOME}/valet" self mock1 create-temp-files)
  endTest "Testing temp files/directories creation, cleaning and custom cleanUp" $?
}

function testUserDirectory() {
  # testing with a non exising user directory
  local previousUserDirectory="${VALET_USER_DIRECTORY}"
  setTempFilesNumber 600
  io::createTempDirectory && export VALET_USER_DIRECTORY="${LAST_RETURNED_VALUE}/non-existing"

  echo "→ VALET_USER_DIRECTORY=non-existing self mock1 logging-level"
  ("${GLOBAL_VALET_HOME}/valet" self mock1 logging-level) || :
  endTest "Testing with a non existing user directory" 1

  export VALET_USER_DIRECTORY="${previousUserDirectory}"
}

function main() {
  testMainOptions
  testCleaning
  testUserDirectory
}

main

builtin source ".after-test"