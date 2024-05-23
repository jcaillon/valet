#!/usr/bin/env bash

core::sourceFunction "selfExport"
# shellcheck disable=SC1091
source io

function testSelfExport() {
  echo "→ selfExport"
  selfExport 1>"${GLOBAL_TEST_TEMP_FILE}"

  if [[ -s "${GLOBAL_TEST_TEMP_FILE:-}" ]]; then
    echo "successfully output to file"
  fi
  test::endTest "Testing selfExport" 0

  echo "→ selfExport -a"
  selfExport -a 1>"${GLOBAL_TEST_TEMP_FILE}"

  if [[ -s "${GLOBAL_TEST_TEMP_FILE:-}" ]]; then
    echo "successfully output to file"
  fi
  test::endTest "Testing selfExport with libraries" 0
}

function main() {
  testSelfExport
}

main