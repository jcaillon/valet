#!/usr/bin/env bash

if [[ -z "${_TEST_0000_COMMON_UTILS:-}" ]]; then
  source ".common-utils"
fi

function testMainOptions() {
  # testing version option
  : > "${_TEST_TEMP_FILE}"
  "${VALET_HOME}/valet" --version 1> "${_TEST_TEMP_FILE}"
  if ! isFileEmpty "${_TEST_TEMP_FILE}"; then
    echo "OK, we got a version."
  else
    echo "KO, we did not get a version."
  fi
  endTest "Testing version option" $?

  # testing unknown option, corrected with fuzzy match
  "${VALET_HOME}/valet" -prof
  endTest "Testing unknown option, corrected with fuzzy match" $?
}

function testCleaning() {
  # testing temp files/directories creation, cleaning and custom cleanUp
  ("${VALET_HOME}/valet" self test-core --create-temp-files) 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endTest "Testing temp files/directories creation, cleaning and custom cleanUp" $?
}

function testUserDirectory() {
  # testing with a non exising user directory
  export VALET_USER_DIRECTORY="${VALET_HOME}/non-existing"
  "${VALET_HOME}/valet" self test-core --logging-level 2> "${_TEST_TEMP_FILE}"
  echoTempFileWithSubstitution 1>&2
  endTest "Testing with a non existing user directory" $?

  export VALET_USER_DIRECTORY="${VALET_HOME}/examples.d"
}

function main() {
  testMainOptions
  testCleaning
  testUserDirectory
}

main

source ".cleanup"