#!/usr/bin/env bash

command::sourceFunction "selfSetup"

function main() {
  test::title "✅ Testing self setup command"

  VALET_CONFIG_FILE="${GLOBAL_TEST_TEMP_FILE}"

  test::exec rm -f "\"\${VALET_CONFIG_FILE}\""

  test::prompt "echo nn | selfSetup"
  echo nn 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  selfSetup <"${GLOBAL_TEMPORARY_WORK_FILE}"
  test::flush
  test::printVars VALET_CONFIG_ENABLE_COLORS VALET_CONFIG_ENABLE_NERDFONT_ICONS
  test::exec fs::head "${VALET_CONFIG_FILE}" 3

  test::exec rm -f "\"\${VALET_CONFIG_FILE}\""
  echo "→ echo yy | selfSetup"
  echo yy 1>"${GLOBAL_TEMPORARY_WORK_FILE}"
  selfSetup <"${GLOBAL_TEMPORARY_WORK_FILE}"
  test::flush
  test::printVars VALET_CONFIG_ENABLE_COLORS VALET_CONFIG_ENABLE_NERDFONT_ICONS
  test::exec fs::head "${VALET_CONFIG_FILE}" 3
}

main
