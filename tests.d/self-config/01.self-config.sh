#!/usr/bin/env bash

command::sourceFunction "selfConfig"

# shellcheck disable=SC1091
source fs
# shellcheck disable=SC1091
source string

function main() {
  test_selfConfig::getFileContent
  test_self_config_command
}

function test_selfConfig::getFileContent() {
  test::title "✅ Testing selfConfig::getFileContent"

  # shellcheck disable=SC2034
  VALET_CONFIG_DIRECTORY="A value"
  test::exec selfConfig::getFileContent false
  local configContent="${RETURNED_VALUE}"
  test::func string::head configContent 80

  test::markdown "Testing selfConfig::getFileContent with exportCurrentValues:"
  test::exec selfConfig::getFileContent true
  configContent="${RETURNED_VALUE}"
  test::func string::head configContent 80
}

function test_self_config_command() {
  test::title "✅ Testing self config command"

  export EDITOR=myEditor

  # shellcheck disable=SC2086
  unset -v ${!VALET_CONFIG_*}
  # shellcheck disable=SC2034
  VALET_CONFIG_FILE="${GLOBAL_TEST_TEMP_FILE}"

  rm -f "${GLOBAL_TEST_TEMP_FILE}" &>/dev/null || :

  test::exec selfConfig
  test::exec fs::head "${GLOBAL_TEST_TEMP_FILE}" 3

  test::markdown "Testing selfConfig (should only open, file does not exist)"
  test::exec selfConfig

  test::markdown "Testing selfConfig override no edit"
  test::exec selfConfig --override --no-edit

  test::markdown "Testing to export the current values"
  export VALET_CONFIG_LOCALE="${GLOBAL_TEST_TEMP_FILE}"
  test::printVars VALET_CONFIG_LOCALE
  test::exec selfConfig --override --export-current-values
  fs::readFile "${GLOBAL_TEST_TEMP_FILE}"
  if [[ ${RETURNED_VALUE} == *"${GLOBAL_TEST_TEMP_FILE}"* ]]; then
    test::markdown "The path ${GLOBAL_TEST_TEMP_FILE} is in the config file as expected."
  fi
}

function myEditor() {
  echo "🙈 mocking myEditor: $*"
}

main