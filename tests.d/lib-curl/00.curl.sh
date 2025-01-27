#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-curl
source curl
# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_curl::toFile
  test_curl::toVar
}

function test_curl::toFile() {
  test::title "✅ Testing curl::toFile"

  test::markdown "Writing to an output file:"
  test::func curl::toFile true 200 "${GLOBAL_TEST_TEMP_FILE}" --code 200 https://fuu
  test::exec fs::cat "${GLOBAL_TEST_TEMP_FILE}"

  test::markdown "Getting a 500 error with fail mode on:"
  test::exit curl::toFile true 200 "${GLOBAL_TEST_TEMP_FILE}" --code 500 https://fuu

  test::markdown "Getting a 500 error with fail mode off:"
  test::func curl::toFile false 200 "${GLOBAL_TEST_TEMP_FILE}" --code 500 https://fuu

  test::markdown "Getting an acceptable 400 error with fail mode:"
  test::func curl::toFile true '200,400,401' "${GLOBAL_TEST_TEMP_FILE}" --code 400 https://fuu

  test::markdown "Getting an acceptable 201 with debug mode on"
  test::exec log::setLevel debug
  test::func curl::toFile false \'\' "${GLOBAL_TEST_TEMP_FILE}" --code 201 https://fuu
  test::exec log::setLevel info
}

function echoOutputCurlToFile() {
  local exitCode filePath
  exitCode="${1}"
  filePath="${2}"

  local debugMessage
  debugMessage="curl::toFile false function ended with exit code ⌈${exitCode}⌉."$'\n'
  debugMessage+="http return code was ⌈${RETURNED_VALUE2}⌉"$'\n'
  if [[ -s "${filePath}" ]]; then
    debugMessage+="Content of downloaded file:"$'\n'"⌈$(<"${filePath}")⌉"$'\n'
  fi
  debugMessage+="stderr:"$'\n'"⌈${RETURNED_VALUE}⌉"
  echo "${debugMessage}"
}

function test_curl::toVar() {
  test::title "✅ Testing curl::toVar"
  local -i exitCode

  test::markdown "Getting 200:"
  test::func curl::toVar true 200 "${GLOBAL_TEST_TEMP_FILE}" --code 200 https://fuu

  test::markdown "Getting 500 with fail mode off:"
  test::exit curl::toVar false \'\' "${GLOBAL_TEST_TEMP_FILE}" --code 500 https://fuu

  test::markdown "Getting 500 with fail mode on:"
  test::exit curl::toVar true 200 "${GLOBAL_TEST_TEMP_FILE}" --code 500 https://fuu

  export NO_CURL_CONTENT=true

  test::markdown "Getting 200 with no content and debug mode on:"
  test::exec log::setLevel debug
  test::func curl::toVar true 200 "${GLOBAL_TEST_TEMP_FILE}" --code 200 https://fuu
  test::exec log::setLevel info

  unset NO_CURL_CONTENT
}

function echoOutputCurlToVar() {
  local exitCode filePath
  exitCode="${1}"

  local debugMessage
  debugMessage="curl::toVar function ended with exit code ⌈${exitCode}⌉."$'\n'
  debugMessage+="http return code was ⌈${RETURNED_VALUE3}⌉"$'\n'
  debugMessage+="stdout:"$'\n'"⌈${RETURNED_VALUE}⌉"$'\n'
  debugMessage+="stderr:"$'\n'"⌈${RETURNED_VALUE2}⌉"
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
