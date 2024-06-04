#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-system
source system

function testSystem::os() {

  echo "→ OSTYPE=linux-bsd system::os"
  OSTYPE=linux-bsd system::os && echo "${RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=msys system::os"
  OSTYPE=msys system::os && echo "${RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=darwin-stuff system::os"
  OSTYPE=darwin-stuff system::os && echo "${RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=nop system::os"
  OSTYPE=nop system::os && echo "${RETURNED_VALUE}"
  echo

  test::endTest "Testing system::os" 0
}

function testSystem::env() {

  RETURNED_ARRAY=()
  echo "→ system::env"
  system::env
  if (( ${#RETURNED_ARRAY[*]} > 0 )); then
    echo "Found environment variables."
  fi

  test::endTest "Testing system::env" 0
}

function testSystem::date() {

  echo "→ system::date"
  system::date && echo "Returned date with length ${#RETURNED_VALUE}."
  echo

  echo "→ system::date %(%H:%M:%S)T"
  system::date '%(%H:%M:%S)T' && echo "Returned date with length ${#RETURNED_VALUE}."

  test::endTest "Testing system::date" 0
}

function main() {
  testSystem::os
  testSystem::env
  testSystem::date
}

main