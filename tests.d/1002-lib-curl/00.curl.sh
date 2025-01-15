#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-curl
source curl

function test_curl::toFile() {
  mkdir -p "${GLOBAL_TEMPORARY_DIRECTORY}" &>/dev/null
  local tmpFile="${GLOBAL_TEMPORARY_DIRECTORY}/curl-test"
  local exitCode

  echo "→ curl::toFile false '' \"\${tmpFile}\" --code 200 -curlOption1 --fakeOpt2 https://fuu"
  curl::toFile false '' "${tmpFile}" --code 200 -curlOption1 --fakeOpt2 https://fuu && exitCode=0 || exitCode=$?
  echoOutputCurlToFile ${exitCode} "${tmpFile}"
  test::endTest "Testing curl::toFile, should write to file" ${exitCode}

  echo "→ curl::toFile false '' \"\${tmpFile}\" --code 500 https://fuu"
  curl::toFile false '' "${tmpFile}" --code 500 https://fuu && exitCode=0 || exitCode=$?
  echoOutputCurlToFile ${exitCode} "${tmpFile}"
  test::endTest "Testing curl::toFile, http code 500 not acceptable return 1" ${exitCode}

  echo "→ curl::toFile true '' \"\${tmpFile}\" --code 500 https://fuu"
  export GLOBAL_ERROR_DISPLAYED=1
  (curl::toFile true '' "${tmpFile}" --code 500 https://fuu) && exitCode=0 || exitCode=$?
  unset GLOBAL_ERROR_DISPLAYED
  test::endTest "Testing curl::toFile, http code 500 not acceptable fails" ${exitCode}

  echo "→ curl::toFile false '300,500,999' \"\${tmpFile}\" --code 500 https://fuu"
  curl::toFile false '300,500,999' "${tmpFile}" --code 500 https://fuu && exitCode=0 || exitCode=$?
  echoOutputCurlToFile ${exitCode} "${tmpFile}"
  test::endTest "Testing curl::toFile, http code 500 is now acceptable return 0" ${exitCode}

  # test debug mode
  echo "→ curl::toFile false '' \"\${tmpFile}\" --code 400 --error https://fuu/bla --otherOpt"
  log::setLevel debug
  curl::toFile false '' "${tmpFile}" --code 400 --error https://fuu/bla --otherOpt && exitCode=0 || exitCode=$?
  echoOutputCurlToFile ${exitCode} "${tmpFile}"
  test::endTest "Testing curl::toFile, testing debug mode https code 400" ${exitCode}
  log::setLevel info

  echo "→ curl::toFile false '' \"\${tmpFile}\" --code 200 http://fuu"
  log::setLevel debug
  curl::toFile false '' "${tmpFile}" --code 200 http://fuu && exitCode=0 || exitCode=$?
  echoOutputCurlToFile ${exitCode} "${tmpFile}"
  test::endTest "Testing curl::toFile, testing debug mode http code 200" ${exitCode}
  log::setLevel info
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
  local -i exitCode

  export NO_CURL_CONTENT=true

  echo "→ curl::toVar false '' --code 200 http://hello.com"
  curl::toVar false '' --code 200 http://hello.com && exitCode=0 || exitCode=$?
  echoOutputCurlToVar ${exitCode}
  test::endTest "Testing curl, with no content http code 200" ${exitCode}

  echo "→ curl::toVar false '' --code 500 http://hello.com"
  export GLOBAL_ERROR_DISPLAYED=1
  (curl::toVar true '' --code 500 http://hello.com) && exitCode=0 || exitCode=$?
  unset GLOBAL_ERROR_DISPLAYED
  test::endTest "Testing curl, with no content http code 500, fails" ${exitCode}

  unset NO_CURL_CONTENT

  # test debug mode
  echo "→ curl::toVar false '' --code 400 http://hello.com"
  log::setLevel debug
  curl::toVar false '' --code 400 http://hello.com && exitCode=0 || exitCode=$?
  echoOutputCurlToVar ${exitCode}
  test::endTest "Testing curl, debug mode, with content http code 400" ${exitCode}
  log::setLevel info
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

function main() {
  test_curl::toFile
  test_curl::toVar
}

# Override curl for tests
# shellcheck disable=SC2317
function curl() {
  local IFS=" "
  echo "▶ called curl $*" 1>&2

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
        echo -n "Writing stuff to file because the --output option was given." >"${1}"
      fi
      ;;
    *) ;;
    esac
    shift
  done
}

main

unset curl
