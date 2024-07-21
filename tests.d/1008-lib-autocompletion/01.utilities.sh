#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-autocompletion
source autocompletion


function testAutocompletionComputeSize() {
  echo "GLOBAL_LINES=10"
  echo "GLOBAL_COLUMNS=10"
  GLOBAL_LINES=10
  GLOBAL_COLUMNS=10

  echo "autocompletionComputeSize '' '' 1 1 20 20"
  autocompletionComputeSize '' '' 1 1 20 20
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  echo "autocompletionComputeSize 2 '' 1 1 20 20"
  autocompletionComputeSize 2 '' 1 1 20 20
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  echo
  echo "autocompletionComputeSize '' '' 1 1 5 5"
  autocompletionComputeSize '' '' 1 1 5 5
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  echo
  echo "autocompletionComputeSize '' '' 5 5 6 9"
  autocompletionComputeSize '' '' 5 5 6 9
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  echo
  echo "autocompletionComputeSize '' '' 7 7 10 4"
  autocompletionComputeSize '' '' 7 7 10 4
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  echo
  echo "autocompletionComputeSize '' true 7 7 10 10"
  autocompletionComputeSize '' true 7 7 10 10
  echo "${AUTOCOMPLETION_WIDTH} x ${AUTOCOMPLETION_HEIGHT} at ${AUTOCOMPLETION_LEFT}:${AUTOCOMPLETION_TOP}"

  test::endTest "Testing autocompletionComputeSize" 0
}

function main() {
  testAutocompletionComputeSize
}

main
