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

function testSystem::getUndeclaredVariables() {

  echo "→ system::getUndeclaredVariables"
  if ! system::getUndeclaredVariables; then
    echo "No undeclared variables found.${RETURNED_ARRAY[*]}"
  fi

  echo
  local abc="ok"
  echo "→ system::getUndeclaredVariables GLOBAL_TEST_TEMP_FILE"
  system::getUndeclaredVariables GLOBAL_TEST_TEMP_FILE abc dfg NOP
  if system::getUndeclaredVariables GLOBAL_TEST_TEMP_FILE abc dfg NOP; then
    echo "Found undeclared variables: ⌜${RETURNED_ARRAY[*]}⌝."
  fi

  test::endTest "Testing system::date" 0
}

function main() {
  testSystem::os
  testSystem::env
  testSystem::date
  testSystem::getUndeclaredVariables
}

main