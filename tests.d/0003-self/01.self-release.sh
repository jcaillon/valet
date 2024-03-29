#!/usr/bin/env bash

function testSelfRelease() {
  local -i exitCode

  LAST_GIT_TAG="v1.2.3"
  echo "→ selfRelease -t token -b major --dry-run"
  selfRelease -t token -b major --dry-run && exitCode=0 || exitCode=$?
  endTest "Testing selfRelease, dry run major version" $exitCode
}

# need to override git, curl
function git() {
  echo "▶ called git $*" 1>&2
  while [[ $# -gt 0 ]]; do
    case "${1}" in
    tag) echo "${LAST_GIT_TAG}."; return 0;;
    log) echo "✨ feature"$'\n'"🐞 fix"; return 0;;
    *) ;;
    esac
    shift
  done
}
function curl() {
  echo "▶ called curl $*" 1>&2
  if [[ "$*" == *"tag_name"* ]]; then
    # post on the release endpoint
    echo '{ "upload_url": "https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets{?name,label}" }'
  fi
}

function main() {
  # make sure to source the file in which these known functions are defined
  sourceForFunction "selfRelease" 2> /dev/null

  testSelfRelease
}

main