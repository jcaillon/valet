#!/usr/bin/env bash

include kurl

function testKurlFile() {
  mkdir -p "${_TEMPORARY_DIRECTORY}" &>/dev/null
  local tmpFile="${_TEMPORARY_DIRECTORY}/kurl-test"
  local exitCode

  echo "→ kurlFile false '' \"\${tmpFile}\" --code 200 -curlOption1 --fakeOpt2 https://hello.com"
  kurlFile false '' "${tmpFile}" --code 200 -curlOption1 --fakeOpt2 https://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurlFile ${exitCode} "${tmpFile}"
  endTest "Testing kurlFile, should write to file" 0

  echo "→ kurlFile false '' \"\${tmpFile}\" --code 500 https://hello.com"
  kurlFile false '' "${tmpFile}" --code 500 https://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurlFile ${exitCode} "${tmpFile}"
  endTest "Testing kurlFile, http code 500 not acceptable return 1" 0

  echo "→ kurlFile true '' \"\${tmpFile}\" --code 500 https://hello.com"
  export ERROR_DISPLAY=1
  (kurlFile true '' "${tmpFile}" --code 500 https://hello.com)
  unset ERROR_DISPLAY
  endTest "Testing kurlFile, http code 500 not acceptable fails" 0

  echo "→ kurlFile false '300,500,999' \"\${tmpFile}\" --code 500 https://hello.com"
  kurlFile false '300,500,999' "${tmpFile}" --code 500 https://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurlFile ${exitCode} "${tmpFile}"
  endTest "Testing kurlFile, http code 500 is now acceptable return 0" 0

  # test debug mode
  echo "→ kurlFile false '' \"\${tmpFile}\" --code 400 --error https://hello.com/bla --otherOpt"
  setLogLevel debug
  kurlFile false '' "${tmpFile}" --code 400 --error https://hello.com/bla --otherOpt && exitCode=0 || exitCode=$?
  echoOutputKurlFile ${exitCode} "${tmpFile}"
  endTest "Testing kurlFile, testing debug mode https code 400" 0

  echo "→ kurlFile false '' \"\${tmpFile}\" --code 200 http://hello.com"
  setLogLevel debug
  kurlFile false '' "${tmpFile}" --code 200 http://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurlFile ${exitCode} "${tmpFile}"
  endTest "Testing kurlFile, testing debug mode http code 200" 0

}

function echoOutputKurlFile() {
  local exitCode filePath
  exitCode="${1}"
  filePath="${2}"

  local debugMessage
  debugMessage="kurlFile false function ended with exit code ⌈${exitCode}⌉."$'\n'
  debugMessage+="http return code was ⌈${LAST_RETURNED_VALUE2}⌉"$'\n'
  if [[ -s "${filePath}" ]]; then
    debugMessage+="Content of downloaded file:"$'\n'"⌈$(<"${filePath}")⌉"$'\n'
  fi
  debugMessage+="stderr:"$'\n'"⌈${LAST_RETURNED_VALUE}⌉"
  echo "${debugMessage}"
}

function testKurl() {
  local -i exitCode

  export NO_CURL_CONTENT=true

  echo "→ kurl false '' --code 200 http://hello.com"
  kurl false '' --code 200 http://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurl ${exitCode}
  endTest "Testing kurl, with no content http code 200" 0

  echo "→ kurl false '' --code 500 http://hello.com"
  (kurl true '' --code 500 http://hello.com)
  endTest "Testing kurl, with no content http code 500, fails" 0

  unset NO_CURL_CONTENT

  # test debug mode
  echo "→ kurl false '' --code 400 http://hello.com"
  setLogLevel debug
  kurl false '' --code 400 http://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurl ${exitCode}
  endTest "Testing kurl, debug mode, with content http code 400" 0

}

function echoOutputKurl() {
  local exitCode filePath
  exitCode="${1}"

  local debugMessage
  debugMessage="kurl function ended with exit code ⌈${exitCode}⌉."$'\n'
  debugMessage+="http return code was ⌈${LAST_RETURNED_VALUE3}⌉"$'\n'
  debugMessage+="stdout:"$'\n'"⌈${LAST_RETURNED_VALUE}⌉"$'\n'
  debugMessage+="stderr:"$'\n'"⌈${LAST_RETURNED_VALUE2}⌉"
  echo "${debugMessage}"
}

function main() {
  testKurlFile
  testKurl
}

# Override curl for tests
# shellcheck disable=SC2317
function curl() {
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
