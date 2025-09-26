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

function exe::invoke() {
  local IFS=" "
  if [[ $* == *"docs/content/docs/"* ]]; then
    # since we list files here we can have diffs after a release; we don't display all the args here
    echo "🙈 mocked exe::invoke ${1} ${2} ..." 1>&2
    REPLY_CODE=0
    REPLY=""
    REPLY2=""
    return 0
  fi

  echo "🙈 mocked exe::invoke ${*}" 1>&2
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
  # shellcheck disable=SC2034
  REPLY_CODE=0
  REPLY=""
  REPLY2=""
}

function interactive::confirm() {
  echo "🙈 mocked interactive::confirm ${*}" 1>&2
  return 0
}

# shellcheck disable=SC2034
function curl::request() {
  echo "🙈 mocked curl::request ${*}" 1>&2
  REPLY_CODE=0
  REPLY='{ "upload_url": "https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets{?name,label}", "tag_name": "v1.2.3", "browser_download_url": "https:///fake" }'
  REPLY2=""
  REPLY3=200
}


# shellcheck disable=SC2034
function curl::download() {
  echo "🙈 mocked curl::download ${*}" 1>&2
  REPLY_CODE=0
  REPLY=""
  REPLY2=""
  REPLY3=200
}

function core::getVersion() {
  REPLY="1.2.3"
}

function fs::writeToFile() {
  if [[ $* == *"docs/content/docs/"* ]]; then
    # since we list files here we can have diffs after a release; we don't display all the args here
    echo "🙈 mocked fs::writeToFile ..." 1>&2
    return 0
  fi

  echo "🙈 mocked fs::writeToFile ${*}" 1>&2
}

# shellcheck disable=SC2317
function test::scrubOutput() {
  GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT// [0-9][0-9][0-9] functions/ xxx functions}"
}

main
