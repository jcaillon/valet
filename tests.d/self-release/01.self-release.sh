#!/usr/bin/env bash

command::sourceFunction "selfRelease"

function main() {
  test::title "✅ Testing self release command"

  LAST_GIT_TAG="v1.2.3"

  test::markdown "Testing selfRelease, dry run major version"
  test::exec selfRelease -t token -b major --dry-run

  test::markdown "Testing selfRelease, minor version"
  test::exec selfRelease -t token -b minor
}

# need to override git, curl
function exe::invokef5() {
  echo "🙈 mocked exe::invokef5 $*" 1>&2
  REPLY=""
  REPLY2=""
}

function exe::invoke() {
  echo "🙈 mocked exe::invoke $*" 1>&2
  if [[ ${1} == "git" ]]; then
    while [[ $# -gt 0 ]]; do
      case "${1}" in
      tag) REPLY="${LAST_GIT_TAG}"; return 0;;
      log) REPLY="✨ feature"$'\n'"🐞 fix"; return 0;;
      *) ;;
      esac
      shift
    done
  fi
  REPLY=""
  REPLY2=""
}

function interactive::promptYesNo() {
  echo "🙈 mocked interactive::promptYesNo $*" 1>&2
  return 0
}

function curl::request() {
  echo "🙈 mocked curl::request $*" 1>&2
  REPLY='{ "upload_url": "https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets{?name,label}", "tag_name": "v1.2.3", "browser_download_url": "https:///fake" }'
  REPLY2=""
  REPLY3=200
}


function curl::download() {
  echo "🙈 mocked curl::download $*" 1>&2
  REPLY=""
  REPLY2=200
}

function core::getVersion() {
  REPLY="1.2.3"
}

function fs::writeToFile() {
  echo "🙈 mocked fs::writeToFile $1" 1>&2
}

# shellcheck disable=SC2317
function test::scrubOutput() {
  _TEST_OUTPUT="${_TEST_OUTPUT// [0-9][0-9][0-9] functions/ xxx functions}"
}

main
