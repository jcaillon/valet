#!/usr/bin/env bash

include system

function testGetOsName() {

  echo "→ OSTYPE=linux-bsd getOsName"
  OSTYPE=linux-bsd getOsName && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=msys getOsName"
  OSTYPE=msys getOsName && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=darwin-stuff getOsName"
  OSTYPE=darwin-stuff getOsName && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=nop getOsName"
  OSTYPE=nop getOsName && echo "${LAST_RETURNED_VALUE}"
  echo

  endTest "Testing getOsName" 0
}

function main() {
  testGetOsName
}

main