#!/usr/bin/env bash
# shellcheck source=../../libraries.d/lib-fs
source fs

# shellcheck disable=SC2034
function main() {
  test_log::saveFile
}

function test_log::saveFile() {
  test::title "✅ Testing log::saveFile"

  unset BASHPID
  export BASHPID=1234
  EPOCHSECONDS=548902800

  _OPTION_PATH_ONLY=true fs::createTempFile
  local originalFile="${RETURNED_VALUE}"
  echo "test" >"${originalFile}"

  test::exec log::saveFile "${originalFile}" "important"
  test::exec fs::cat "${RETURNED_VALUE}"

  test::title "✅ Testing log::saveFileString"

  local _myVar="test"
  test::exec log::saveFileString _myVar "important2"
  test::exec fs::cat "${RETURNED_VALUE}"
}

main
