#!/usr/bin/env bash

core::sourceForFunction "selfConfig"
# shellcheck disable=SC1091
source io

function testSelfConfig() {
  local -i exitCode
  local originalConfigFile="${VALET_CONFIG_FILE}"
  local configFile
  setTempFilesNumber 400
  io::createTempFile && configFile="${LAST_RETURNED_VALUE}"
  VALET_CONFIG_FILE="${configFile}"

  rm -f "${configFile}"

  echo "→ selfConfig"
  selfConfig && exitCode=0 || exitCode=$?
  echo
  echo "cat \${configFile}"
  io::readFile "${configFile}" && echo "${LAST_RETURNED_VALUE}"
  endTest "Testing selfConfig" ${exitCode}

  echo "→ selfConfig"
  selfConfig && exitCode=0 || exitCode=$?
  endTest "Testing selfConfig (should only open, file exists)" ${exitCode}

  echo "→ selfConfig --override --no-edit"
  selfConfig --override --no-edit && exitCode=0 || exitCode=$?
  endTest "Testing selfConfig override no edit" ${exitCode}

  echo "→ (selfConfig --override --export-current-values)"
  (
    unset ${!VALET_CONFIG_*} VALET_USER_DIRECTORY
    export VALET_CONFIG_FILE="${configFile}"
    export VALET_CONFIG_COLOR_DEBUG=$'\e[44m'
    export VALET_CONFIG_LOGGLOBAL_COLUMNS=20
    export VALET_CONFIG_ENABLE_CI_MODE=true
    selfConfig --override --export-current-values
  ) && exitCode=0 || exitCode=$?
  echo
  echo "cat \${configFile}"
  io::readFile "${configFile}" && echo "${LAST_RETURNED_VALUE}"
  endTest "Testing selfConfig override export" ${exitCode}

  VALET_CONFIG_FILE="${originalConfigFile}"
}

function myEditor() {
  echo "▶ called myEditor: $*"
}

function main() {
  testSelfConfig
}

EDITOR=myEditor

main