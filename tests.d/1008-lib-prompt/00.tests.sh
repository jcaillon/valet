#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-array
source array
# shellcheck source=../../libraries.d/lib-string
source string
# shellcheck source=../../libraries.d/lib-prompt
source prompt

function test_prompt::fuzzyFilterSort() {
  myArray=(
    "one the"
    "the breakdown"
    "constitutional"
    "conventional"
    "hold the baby"
    "holiday inn"
    "deliver"
    "abundant"
    "make a living"
    "the d day"
    "elevator"
  )

  declare -p myArray

  echo
  echo "→ prompt::fuzzyFilterSort the myArray"
  prompt::fuzzyFilterSort the myArray

  declare -p RETURNED_ARRAY RETURNED_ARRAY2

  echo
  echo "→ prompt::fuzzyFilterSort elv myArray ⌜ ⌝"
  prompt::fuzzyFilterSort elv myArray ⌜ ⌝

  declare -p RETURNED_ARRAY RETURNED_ARRAY2

  echo
  myArray=(
    "On the"
    "One of the most beautiful"
    "One of this happy end"
    "thaerty"
    "thazrerty"
  )

  declare -p myArray

  echo
  echo "→ prompt::fuzzyFilterSort the myArray ⌜ ⌝ 6"
  prompt::fuzzyFilterSort the myArray ⌜ ⌝ 6

  declare -p RETURNED_ARRAY RETURNED_ARRAY2

  unset myArray

  test::endTest "testing prompt::fuzzyFilterSort" 0
}

function main() {
  test_prompt::fuzzyFilterSort
}

main
