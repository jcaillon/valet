#!/usr/bin/env bash
# shellcheck source=../../libraries.d/lib-fs
source fs

# shellcheck disable=SC2034
function main() {
  test_log::saveFile
}

function test_log::saveFile() {
  test::title "✅ Testing log::saveFile"

  fs::createTempFile pathOnly=true
  local originalFile="${REPLY}"
  echo "test" >"${originalFile}"

  test::exec log::saveFile "${originalFile}" "important"
  test::exec fs::cat "${REPLY}"

  test::func log::saveFile "${originalFile}" "important" logPath=false

  test::title "✅ Testing log::saveFileString"

  local _myVar="test"
  test::exec log::saveFileString _myVar "important2"
  test::exec fs::cat "${REPLY}"

  test::func log::saveFileString _myVar "important" logPath=false
}

main
