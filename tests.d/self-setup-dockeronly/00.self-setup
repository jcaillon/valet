#!/usr/bin/env bash

command::sourceFunction "selfSetup"

# shellcheck source=../../libraries.d/lib-windows
source windows
# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test::title "✅ Testing self setup command"

  export OSTYPE="linux"

  VALET_CONFIG_FILE="${GLOBAL_TEST_TEMP_FILE}"

  test::exec rm -f "\"\${VALET_CONFIG_FILE}\""

  test::prompt "echo nn | selfSetup"
  test::setTerminalInputs n n
  selfSetup
  test::flush
  test::printVars VALET_CONFIG_ENABLE_COLORS VALET_CONFIG_ENABLE_NERDFONT_ICONS
  test::exec fs::head "${VALET_CONFIG_FILE}" 3

  test::exec rm -f "\"\${VALET_CONFIG_FILE}\""
  echo "→ echo yy | selfSetup"
  test::setTerminalInputs y y
  selfSetup
  test::flush
  test::printVars VALET_CONFIG_ENABLE_COLORS VALET_CONFIG_ENABLE_NERDFONT_ICONS
  test::exec fs::head "${VALET_CONFIG_FILE}" 3

  export OSTYPE="msys"
  log::setLevel warning

  echo "→ echo yyy | selfSetup"
  test::setTerminalInputs y y y
  selfSetup
  test::flush
}

function windows::runPs1() {
  echo "🙈 mocking windows::runPs1";
}

main
