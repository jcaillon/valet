#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-kurl
source kurl

function testKurl::toFile() {
  mkdir -p "${GLOBAL_TEMPORARY_DIRECTORY}" &>/dev/null
  local tmpFile="${GLOBAL_TEMPORARY_DIRECTORY}/kurl-test"
  local exitCode

  echo "→ kurl::toFile false '' \"\${tmpFile}\" --code 200 -curlOption1 --fakeOpt2 https://hello.com"
  kurl::toFile false '' "${tmpFile}" --code 200 -curlOption1 --fakeOpt2 https://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurlToFile ${exitCode} "${tmpFile}"
  endTest "Testing kurl::toFile, should write to file" ${exitCode}

  echo "→ kurl::toFile false '' \"\${tmpFile}\" --code 500 https://hello.com"
  kurl::toFile false '' "${tmpFile}" --code 500 https://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurlToFile ${exitCode} "${tmpFile}"
  endTest "Testing kurl::toFile, http code 500 not acceptable return 1" ${exitCode}

  echo "→ kurl::toFile true '' \"\${tmpFile}\" --code 500 https://hello.com"
  export GLOBAL_ERROR_DISPLAYED=1
  (kurl::toFile true '' "${tmpFile}" --code 500 https://hello.com) && exitCode=0 || exitCode=$?
  unset GLOBAL_ERROR_DISPLAYED
  endTest "Testing kurl::toFile, http code 500 not acceptable fails" ${exitCode}

  echo "→ kurl::toFile false '300,500,999' \"\${tmpFile}\" --code 500 https://hello.com"
  kurl::toFile false '300,500,999' "${tmpFile}" --code 500 https://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurlToFile ${exitCode} "${tmpFile}"
  endTest "Testing kurl::toFile, http code 500 is now acceptable return 0" ${exitCode}

  # test debug mode
  echo "→ kurl::toFile false '' \"\${tmpFile}\" --code 400 --error https://hello.com/bla --otherOpt"
  log::setLevel debug
  kurl::toFile false '' "${tmpFile}" --code 400 --error https://hello.com/bla --otherOpt && exitCode=0 || exitCode=$?
  echoOutputKurlToFile ${exitCode} "${tmpFile}"
  endTest "Testing kurl::toFile, testing debug mode https code 400" ${exitCode}
  log::setLevel info

  echo "→ kurl::toFile false '' \"\${tmpFile}\" --code 200 http://hello.com"
  log::setLevel debug
  kurl::toFile false '' "${tmpFile}" --code 200 http://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurlToFile ${exitCode} "${tmpFile}"
  endTest "Testing kurl::toFile, testing debug mode http code 200" ${exitCode}
  log::setLevel info
}

function echoOutputKurlToFile() {
  local exitCode filePath
  exitCode="${1}"
  filePath="${2}"

  local debugMessage
  debugMessage="kurl::toFile false function ended with exit code ⌈${exitCode}⌉."$'\n'
  debugMessage+="http return code was ⌈${LAST_RETURNED_VALUE2}⌉"$'\n'
  if [[ -s "${filePath}" ]]; then
    debugMessage+="Content of downloaded file:"$'\n'"⌈$(<"${filePath}")⌉"$'\n'
  fi
  debugMessage+="stderr:"$'\n'"⌈${LAST_RETURNED_VALUE}⌉"
  echo "${debugMessage}"
}

function testKurl::toVar() {
  local -i exitCode

  export NO_CURL_CONTENT=true

  echo "→ kurl::toVar false '' --code 200 http://hello.com"
  kurl::toVar false '' --code 200 http://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurlToVar ${exitCode}
  endTest "Testing kurl, with no content http code 200" ${exitCode}

  echo "→ kurl::toVar false '' --code 500 http://hello.com"
  export GLOBAL_ERROR_DISPLAYED=1
  (kurl::toVar true '' --code 500 http://hello.com) && exitCode=0 || exitCode=$?
  unset GLOBAL_ERROR_DISPLAYED
  endTest "Testing kurl, with no content http code 500, fails" ${exitCode}

  unset NO_CURL_CONTENT

  # test debug mode
  echo "→ kurl::toVar false '' --code 400 http://hello.com"
  log::setLevel debug
  kurl::toVar false '' --code 400 http://hello.com && exitCode=0 || exitCode=$?
  echoOutputKurlToVar ${exitCode}
  endTest "Testing kurl, debug mode, with content http code 400" ${exitCode}
  log::setLevel info
}

function echoOutputKurlToVar() {
  local exitCode filePath
  exitCode="${1}"

  local debugMessage
  debugMessage="kurl::toVar function ended with exit code ⌈${exitCode}⌉."$'\n'
  debugMessage+="http return code was ⌈${LAST_RETURNED_VALUE3}⌉"$'\n'
  debugMessage+="stdout:"$'\n'"⌈${LAST_RETURNED_VALUE}⌉"$'\n'
  debugMessage+="stderr:"$'\n'"⌈${LAST_RETURNED_VALUE2}⌉"
  echo "${debugMessage}"
}

function main() {
  testKurl::toFile
  testKurl::toVar
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
