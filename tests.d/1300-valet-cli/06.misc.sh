#!/usr/bin/env bash

builtin source ".before-test"

function testMainOptions() {
  # testing version option
  : > "${GLOBAL_TEST_TEMP_FILE}"
  echo "→ valet --version"
  ("${GLOBAL_VALET_HOME}/valet" --version 1> "${GLOBAL_TEST_TEMP_FILE}")
  if [[ -s "${GLOBAL_TEST_TEMP_FILE}" ]]; then
    echo "OK, we got a version."
  else
    echo "KO, we did not get a version."
  fi
  test::endTest "Testing version option" $?

  # testing unknown single letter flag
  echo "→ valet -prof"
  ("${GLOBAL_VALET_HOME}/valet" -prof) || echo "Failed as expected."
  test::endTest "Testing unknown single letter" 1

  # testing option corrected with fuzzy match
  echo "→ valet --versin"
  ("${GLOBAL_VALET_HOME}/valet" --versin 1>/dev/null)
  test::endTest "Testing option corrected with fuzzy match" 0

  # testing group of single letter options
  echo "→ valet -vwvw --versin"
  ("${GLOBAL_VALET_HOME}/valet" -vwvw --versin 1>/dev/null)
  test::endTest "Testing option corrected with fuzzy match" 0
}

function testCleaning() {
  # testing temp files/directories creation, cleaning and custom cleanUp
  echo "→ valet self mock1 create-temp-files"
  ("${GLOBAL_VALET_HOME}/valet" self mock1 create-temp-files)
  test::endTest "Testing temp files/directories creation, cleaning and custom cleanUp" $?
}

function testUserDirectory() {
  # testing with a non exising user directory
  local previousUserDirectory="${VALET_USER_DIRECTORY:-}"
  io::createTempDirectory && export VALET_USER_DIRECTORY="${RETURNED_VALUE}/non-existing"

  echo "→ VALET_USER_DIRECTORY=non-existing self mock1 logging-level"
  ("${GLOBAL_VALET_HOME}/valet" self mock1 logging-level) || :
  test::endTest "Testing with a non existing user directory" 1

  export VALET_USER_DIRECTORY="${previousUserDirectory}"
}

function main() {
  testMainOptions
  testCleaning
  testUserDirectory
}

main

builtin source ".after-test"