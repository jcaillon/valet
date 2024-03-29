#!/usr/bin/env bash

function testSelfRelease() {
  local -i exitCode

  LAST_GIT_TAG="v1.2.3"
  echo "→ selfRelease -t token -b major --dry-run"
  selfRelease -t token -b major --dry-run && exitCode=0 || exitCode=$?
  endTest "Testing selfRelease, dry run major version" $exitCode

  echo "→ LOG_LEVEL_INT=0 selfRelease -t token -b minor"
  LOG_LEVEL_INT=0 selfRelease -t token -b minor && exitCode=0 || exitCode=$?
  endTest "Testing selfRelease, minor version" $exitCode
}

# need to override git, curl
function invoke5() {
  echo "▶ called invoke5 $*" 1>&2
  if [[ "${5}" == "uname" ]]; then
    echo -n "x86_64" > "${_TEMPORARY_STDOUT_FILE}"
    LAST_RETURNED_VALUE="${_TEMPORARY_STDOUT_FILE}"
    LAST_RETURNED_VALUE2=""
    return 0
  fi
  LAST_RETURNED_VALUE=""
  LAST_RETURNED_VALUE2=""
}

function invoke() {
  echo "▶ called invoke $*" 1>&2
  if [[ "${1}" == "git" ]]; then
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

function kurl() {
  echo "▶ called kurl $*" 1>&2
  echo -n 200
  if [[ "$*" == *"tag_name"* ]]; then
    # post on the release endpoint
    LAST_RETURNED_VALUE='{ "upload_url": "https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets{?name,label}" }'
    return 0
  fi
  LAST_RETURNED_VALUE=""
}


function kurlFile() {
  echo "▶ called kurlFile $*" 1>&2
  echo -n 200
  LAST_RETURNED_VALUE=""
}

function main() {
  # make sure to source the file in which these known functions are defined
  sourceForFunction "selfRelease" 2> /dev/null

  createTempFile && local tmpFile="${LAST_RETURNED_VALUE}"
  cp -f "${VALET_HOME}/valet.d/version" "${tmpFile}"
  echo -n "1.2.3" > "${VALET_HOME}/valet.d/version"

  testSelfRelease

  mv -f "${tmpFile}" "${VALET_HOME}/valet.d/version"
}

main