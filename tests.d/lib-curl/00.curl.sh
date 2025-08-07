#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-curl
source curl
# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_curl::download
  test_curl::request
}

function test_curl::download() {
  test::title "✅ Testing curl::download"

  test::markdown "Writing to an output file:"
  test::func curl::download https://fuu --code 200 --- failOnError=true acceptableCodes=200 output="${GLOBAL_TEST_TEMP_FILE}"
  test::exec fs::cat "${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Downloading to a temp file:"
  test::func curl::download https://fuu --code 200 --- failOnError=true acceptableCodes=200

  test::markdown "Getting a 500 error with fail mode on:"
  test::exit curl::download https://fuu --code 500 --- failOnError=true acceptableCodes=200 output="${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Getting a 500 error with fail mode off:"
  test::func curl::download https://fuu --code 500 --- acceptableCodes=200 output="${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Getting an acceptable 400 error with fail mode:"
  test::func curl::download https://fuu --code 400 --- failOnError=true acceptableCodes='200,400,401' output="${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Getting an acceptable 201 with debug mode on"
  test::exec log::setLevel debug
  test::func curl::download https://fuu --code 201 --- failOnError=false output="${GLOBAL_TEST_TEMP_FILE}"
  test::exec log::setLevel info
}

function test_curl::request() {
  test::title "✅ Testing curl::request"
  local -i exitCode

  test::markdown "Getting 200:"
  test::func curl::request https://fuu --code 200 --- failOnError=true acceptableCodes=200

  test::markdown "Getting 500 with fail mode off:"
  test::func curl::request https://fuu --code 500 --- failOnError=false

  test::markdown "Getting 500 with fail mode on:"
  test::exit curl::request https://fuu --code 500 --- failOnError=true acceptableCodes=200

  export NO_CURL_CONTENT=true

  test::markdown "Getting 200 with no content and debug mode on:"
  test::exec log::setLevel debug
  test::func curl::request https://fuu --code 200 --- failOnError=true acceptableCodes=200
  test::exec log::setLevel info

  unset NO_CURL_CONTENT
}

# Override curl for tests
# shellcheck disable=SC2317
function curl() {
  local IFS=" "
  echo "(curl logs) mocking curl $*" 1>&2

  while [[ $# -gt 0 ]]; do
    case "${1}" in
    --error)
      echo "Returning 1 from curl." 1>&2
      return 1
      ;;
    --code)
      shift
      echo -n "${1}"
      ;;
    -o | --output)
      shift
      if [[ "${NO_CURL_CONTENT:-}" != true ]]; then
        echo -n "(request body response) Writing stuff to file because the --output option was given." >"${1}"
      fi
      ;;
    *) ;;
    esac
    shift
  done
}

main
