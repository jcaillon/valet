#!/usr/bin/env bash

core::sourceForFunction "selfSetup"

function testselfSetup() {
  local -i exitCode
  local originalConfigFile="${VALET_CONFIG_FILE}"
  local configFile
  setTempFilesNumber 800
  io::createTempFile && configFile="${LAST_RETURNED_VALUE}"
  VALET_CONFIG_FILE="${configFile}"

  rm -f "${configFile}"

  # shellcheck disable=SC2317
  function awk() { return 0; }
  # shellcheck disable=SC2317
  function diff() { return 0; }
  # shellcheck disable=SC2317
  function curl() { return 0; }
  export -f awk diff curl

  echo "→ echo nny | selfSetup"
  echo nny | selfSetup && exitCode=0 || exitCode=$?
  endTest "Testing selfSetup 1" ${exitCode}

  rm -f "${configFile}"
  unset -f awk diff curl
  local originalPath="${PATH}"
  export PATH=""

  echo "→ echo nny | selfSetup"
  echo yyo | selfSetup && exitCode=0 || exitCode=$?
  endTest "Testing selfSetup 2" ${exitCode}

  export PATH="${originalPath}"
  VALET_CONFIG_FILE="${originalConfigFile}"
}

function main() {

  testselfSetup

}

main
