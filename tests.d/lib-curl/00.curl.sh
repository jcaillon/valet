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
  test::func curl::download true 200 "${GLOBAL_TEST_TEMP_FILE}" --code 200 https://fuu
  test::exec fs::cat "${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Getting a 500 error with fail mode on:"
  test::exit curl::download true 200 "${GLOBAL_TEST_TEMP_FILE}" --code 500 https://fuu

  test::markdown "Getting a 500 error with fail mode off:"
  test::func curl::download false 200 "${GLOBAL_TEST_TEMP_FILE}" --code 500 https://fuu

  test::markdown "Getting an acceptable 400 error with fail mode:"
  test::func curl::download true '200,400,401' "${GLOBAL_TEST_TEMP_FILE}" --code 400 https://fuu

  test::markdown "Getting an acceptable 201 with debug mode on"
  test::exec log::setLevel debug
  test::func curl::download false \'\' "${GLOBAL_TEST_TEMP_FILE}" --code 201 https://fuu
  test::exec log::setLevel info
}

function echoOutputCurlToFile() {
  local exitCode filePath
  exitCode="${1}"
  filePath="${2}"

  local debugMessage
  debugMessage="curl::download false function ended with exit code ⌈${exitCode}⌉."$'\n'
  debugMessage+="http return code was ⌈${REPLY2}⌉"$'\n'
  if [[ -s "${filePath}" ]]; then
    debugMessage+="Content of downloaded file:"$'\n'"⌈$(<"${filePath}")⌉"$'\n'
  fi
  debugMessage+="stderr:"$'\n'"⌈${REPLY}⌉"
  echo "${debugMessage}"
}

function test_curl::request() {
  test::title "✅ Testing curl::request"
  local -i exitCode

  test::markdown "Getting 200:"
  test::func curl::request true 200 "${GLOBAL_TEST_TEMP_FILE}" --code 200 https://fuu

  test::markdown "Getting 500 with fail mode off:"
  test::exit curl::request false \'\' "${GLOBAL_TEST_TEMP_FILE}" --code 500 https://fuu

  test::markdown "Getting 500 with fail mode on:"
  test::exit curl::request true 200 "${GLOBAL_TEST_TEMP_FILE}" --code 500 https://fuu

  export NO_CURL_CONTENT=true

  test::markdown "Getting 200 with no content and debug mode on:"
  test::exec log::setLevel debug
  test::func curl::request true 200 "${GLOBAL_TEST_TEMP_FILE}" --code 200 https://fuu
  test::exec log::setLevel info

  unset NO_CURL_CONTENT
}

function echoOutputCurlToVar() {
  local exitCode filePath
  exitCode="${1}"

  local debugMessage
  debugMessage="curl::request function ended with exit code ⌈${exitCode}⌉."$'\n'
  debugMessage+="http return code was ⌈${REPLY3}⌉"$'\n'
  debugMessage+="stdout:"$'\n'"⌈${REPLY}⌉"$'\n'
  debugMessage+="stderr:"$'\n'"⌈${REPLY2}⌉"
  echo "${debugMessage}"
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
