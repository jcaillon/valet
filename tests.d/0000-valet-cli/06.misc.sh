#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".before-test"
fi

function testMainOptions() {
  # testing version option
  : > "${_TEST_TEMP_FILE}"
  echo "→ valet --version"
  ("${VALET_HOME}/valet" --version 1> "${_TEST_TEMP_FILE}")
  if [[ -s "${_TEST_TEMP_FILE}" ]]; then
    echo "OK, we got a version."
  else
    echo "KO, we did not get a version."
  fi
  endTest "Testing version option" $?

  # testing unknown option, corrected with fuzzy match
  echo "→ valet -prof"
  ("${VALET_HOME}/valet" -prof)
  endTest "Testing unknown option, corrected with fuzzy match" $?
}

function testCleaning() {
  # testing temp files/directories creation, cleaning and custom cleanUp
  echo "→ valet self test-core --create-temp-files"
  ("${VALET_HOME}/valet" self test-core --create-temp-files)
  endTest "Testing temp files/directories creation, cleaning and custom cleanUp" $?
}

function testUserDirectory() {
  # testing with a non exising user directory
  echo "→ VALET_USER_DIRECTORY=non-existing self test-core --logging-level"
  export VALET_USER_DIRECTORY="${VALET_HOME}/non-existing"
  ("${VALET_HOME}/valet" self test-core --logging-level)
  endTest "Testing with a non existing user directory" $?

  export VALET_USER_DIRECTORY="${VALET_HOME}/examples.d"
}

function main() {
  testMainOptions
  testCleaning
  testUserDirectory
}

main

source ".after-test"