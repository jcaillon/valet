#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-system
source system

function testSystem::getOsName() {

  echo "→ OSTYPE=linux-bsd system::getOsName"
  OSTYPE=linux-bsd system::getOsName && echo "${RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=msys system::getOsName"
  OSTYPE=msys system::getOsName && echo "${RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=darwin-stuff system::getOsName"
  OSTYPE=darwin-stuff system::getOsName && echo "${RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=nop system::getOsName"
  OSTYPE=nop system::getOsName && echo "${RETURNED_VALUE}"
  echo

  endTest "Testing system::getOsName" 0
}

function main() {
  testSystem::getOsName
}

main