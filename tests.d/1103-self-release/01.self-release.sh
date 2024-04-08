#!/usr/bin/env bash

core::sourceForFunction "selfRelease"

function testSelfRelease() {
  local -i exitCode

  LAST_GIT_TAG="v1.2.3"
  echo "→ selfRelease -t token -b major --dry-run"
  selfRelease -t token -b major --dry-run && exitCode=0 || exitCode=$?
  endTest "Testing selfRelease, dry run major version" ${exitCode}

  log::setLevel debug
  echo "→ selfRelease -t token -b minor"
  selfRelease -t token -b minor && exitCode=0 || exitCode=$?
  endTest "Testing selfRelease, minor version" ${exitCode}
}

# need to override git, kurl
function io::invoke5() {
  echo "▶ called io::invoke5 $*" 1>&2
  if [[ ${5} == "uname" ]]; then
    echo -n "x86_64" > "${_TEMPORARY_STDOUT_FILE}"
    LAST_RETURNED_VALUE="${_TEMPORARY_STDOUT_FILE}"
    LAST_RETURNED_VALUE2=""
    return 0
  fi
  LAST_RETURNED_VALUE=""
  LAST_RETURNED_VALUE2=""
}

function io::invoke() {
  echo "▶ called io::invoke $*" 1>&2
  if [[ ${1} == "git" ]]; then
    while [[ $# -gt 0 ]]; do
      case "${1}" in
      tag) LAST_RETURNED_VALUE="${LAST_GIT_TAG}"; return 0;;
      log) LAST_RETURNED_VALUE="✨ feature"$'\n'"🐞 fix"; return 0;;
      *) ;;
      esac
      shift
    done
  fi
  LAST_RETURNED_VALUE=""
  LAST_RETURNED_VALUE2=""
}

function kurl::toVar() {
  echo "▶ called kurl::toVar $*" 1>&2
  echo -n 200
  if [[ $* == *"tag_name"* ]]; then
    # post on the release endpoint
    LAST_RETURNED_VALUE='{ "upload_url": "https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets{?name,label}" }'
    return 0
  fi
  LAST_RETURNED_VALUE=""
}


function kurl::toFile() {
  echo "▶ called kurl::toFile $*" 1>&2
  echo -n 200
  LAST_RETURNED_VALUE=""
}

function main() {
  setTempFilesNumber 100
  io::createTempFile && local tmpFile="${LAST_RETURNED_VALUE}"
  cp -f "${_VALET_HOME}/valet.d/version" "${tmpFile}"
  echo -n "1.2.3" > "${_VALET_HOME}/valet.d/version"

  testSelfRelease

  mv -f "${tmpFile}" "${_VALET_HOME}/valet.d/version"
}

main

core::resetIncludedFiles