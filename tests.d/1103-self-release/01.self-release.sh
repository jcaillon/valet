#!/usr/bin/env bash

core::sourceFunction "selfRelease"

function testSelfRelease() {
  local -i exitCode

  LAST_GIT_TAG="v1.2.3"
  echo "→ selfRelease -t token -b major --dry-run"
  selfRelease -t token -b major --dry-run && exitCode=0 || exitCode=$?
  test::endTest "Testing selfRelease, dry run major version" ${exitCode}

  log::setLevel debug
  echo "→ selfRelease -t token -b minor"
  selfRelease -t token -b minor && exitCode=0 || exitCode=$?
  test::endTest "Testing selfRelease, minor version" ${exitCode}
}

# need to override git, curl
function io::invokef5() {
  echo "▶ called io::invokef5 $*" 1>&2
  if [[ ${5} == "uname" ]]; then
    echo -n "x86_64" > "${GLOBAL_TEMPORARY_STDOUT_FILE}"
    RETURNED_VALUE="${GLOBAL_TEMPORARY_STDOUT_FILE}"
    RETURNED_VALUE2=""
    return 0
  fi
  RETURNED_VALUE=""
  RETURNED_VALUE2=""
}

function io::invoke() {
  echo "▶ called io::invoke $*" 1>&2
  if [[ ${1} == "git" ]]; then
    while [[ $# -gt 0 ]]; do
      case "${1}" in
      tag) RETURNED_VALUE="${LAST_GIT_TAG}"; return 0;;
      log) RETURNED_VALUE="✨ feature"$'\n'"🐞 fix"; return 0;;
      *) ;;
      esac
      shift
    done
  fi
  RETURNED_VALUE=""
  RETURNED_VALUE2=""
}

function interactive::promptYesNo() {
  return 0
}

function curl::toVar() {
  echo "▶ called curl::toVar $*" 1>&2
  RETURNED_VALUE='{ "upload_url": "https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets{?name,label}", "tag_name": "v1.2.3", "browser_download_url": "https:///fake" }'
  RETURNED_VALUE2=""
  RETURNED_VALUE3=200
}


function curl::toFile() {
  echo "▶ called curl::toFile $*" 1>&2
  RETURNED_VALUE=""
  RETURNED_VALUE2=200
}

function core::getVersion() {
  RETURNED_VALUE="1.2.3"
}

function main() {
  testSelfRelease
}

function io::writeToFile() {
  echo "▶ called io::writeToFile $1" 1>&2
}

function io::writeToFileFromRef() {
  echo "▶ called io::writeToFileFromRef $1" 1>&2
}

main

core::resetIncludedFiles
source io
source curl
