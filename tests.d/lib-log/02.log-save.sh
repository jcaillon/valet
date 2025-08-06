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

  test::exec log::saveFile "${originalFile}" suffix="important"
  test::exec fs::cat "${REPLY}"

  test::func log::saveFile "${originalFile}" suffix="important" logPath=true

  test::title "✅ Testing log::saveFileString"

  local _myVar="test"
  test::exec log::saveFileString _myVar suffix="important2"
  test::exec fs::cat "${REPLY}"

  test::func log::saveFileString _myVar suffix="important" logPath=true
}

main
