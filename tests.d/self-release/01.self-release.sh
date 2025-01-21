#!/usr/bin/env bash

core::sourceFunction "selfRelease"

function main() {
  test::title "✅ Testing self release command"

  LAST_GIT_TAG="v1.2.3"

  test::markdown "Testing selfRelease, dry run major version"
  test::exec selfRelease -t token -b major --dry-run

  test::markdown "Testing selfRelease, minor version"
  test::exec selfRelease -t token -b minor
}

# need to override git, curl
function io::invokef5() {
  echo "🙈 mocked io::invokef5 $*" 1>&2
  RETURNED_VALUE=""
  RETURNED_VALUE2=""
}

function io::invoke() {
  echo "🙈 mocked io::invoke $*" 1>&2
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
  echo "🙈 mocked interactive::promptYesNo $*" 1>&2
  return 0
}

function curl::toVar() {
  echo "🙈 mocked curl::toVar $*" 1>&2
  RETURNED_VALUE='{ "upload_url": "https://uploads.github.com/repos/jcaillon/valet/releases/xxxx/assets{?name,label}", "tag_name": "v1.2.3", "browser_download_url": "https:///fake" }'
  RETURNED_VALUE2=""
  RETURNED_VALUE3=200
}


function curl::toFile() {
  echo "🙈 mocked curl::toFile $*" 1>&2
  RETURNED_VALUE=""
  RETURNED_VALUE2=200
}

function core::getVersion() {
  RETURNED_VALUE="1.2.3"
}

function io::writeToFile() {
  echo "🙈 mocked io::writeToFile $1" 1>&2
}

function io::writeToFileFromRef() {
  echo "🙈 mocked io::writeToFileFromRef $1" 1>&2
}

main
