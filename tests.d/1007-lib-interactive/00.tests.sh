#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-interactive
source interactive

function main() {
  echo "echo y | interactive::promptYesNo 'Do you see this message?'"
  echo y | interactive::promptYesNo 'Do you see this message?'

  endTest "test interactive::promptYesNo with yes" 0

  echo
  echo "echo n | interactive::promptYesNo 'Do you see this message?'"
  echo n | interactive::promptYesNo 'Do you see this message?' || true

  endTest "Testing interactive::promptYesNo" 0
}

main