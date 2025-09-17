#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-array
source array
# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_array::reverse
  test_array::sort
  test_array::sortWithCriteria
  test_array::appendIfNotPresent
  test_array::contains
  test_array::remove
  test_array::makeArraysSameSize
  test_array::fuzzyFilterSort
}

function test_array::reverse() {
  test::title "✅ Testing array::reverse"

  MY_ARRAY=(
    breakdown
    constitutional
    conventional
    baby
    holiday
    abundant
    deliver
    position
    economics
  )

  test::printVars MY_ARRAY
  test::exec array::reverse MY_ARRAY
  test::printVars MY_ARRAY

  test::markdown "Testing with an empty array:"
  MY_ARRAY=()
  test::func array::reverse MY_ARRAY
  test::printVars MY_ARRAY
}

function test_array::sort() {
  test::title "✅ Testing array::sort"

  MY_ARRAY=(
    breakdown
    constitutional
    conventional
    baby
    holiday
    abundant
    deliver
    position
    economics
  )

  test::printVars MY_ARRAY
  test::func array::sort MY_ARRAY
  test::printVars MY_ARRAY

  test::markdown "Testing with an empty array:"
  MY_ARRAY=()
  test::func array::sort MY_ARRAY
  test::printVars MY_ARRAY
}

# shellcheck disable=SC2034
function test_array::sortWithCriteria() {
  test::title "✅ Testing array::sortWithCriteria"

  MY_ARRAY=(a b c d e f g)
  MY_CRITERIA1=(3 2 2 1 1 4 0)
  MY_CRITERIA2=(1 3 2 5 0 2 9)

  test::printVars MY_ARRAY MY_CRITERIA1 MY_CRITERIA2
  test::func array::sortWithCriteria MY_ARRAY MY_CRITERIA1 MY_CRITERIA2
  test::printVars MY_ARRAY
  echo "got:      ${MY_ARRAY[*]}"
  echo "expected: g e d c b a f"
  test::flush
}

function test_array::appendIfNotPresent() {
  test::title "✅ Testing array::appendIfNotPresent"

  MY_ARRAY=(
    breakdown
    constitutional
  )

  test::printVars MY_ARRAY
  test::func MY_VALUE='deliver' array::appendIfNotPresent MY_ARRAY MY_VALUE
  test::printVars MY_ARRAY

  test::func MY_VALUE='breakdown' array::appendIfNotPresent MY_ARRAY MY_VALUE
  test::printVars MY_ARRAY
}

function test_array::contains() {
  test::title "✅ Testing array::contains"

  MY_ARRAY=(
    breakdown
    deliver
    economics
  )

  test::printVars MY_ARRAY
  test::func MY_VALUE='deliver' array::contains MY_ARRAY MY_VALUE
  test::printVars MY_ARRAY

  test::func MY_VALUE='holiday' array::contains MY_ARRAY MY_VALUE
  test::printVars MY_ARRAY
}

function test_array::remove() {
  test::title "✅ Testing array::remove"

  MY_ARRAY=(
    breakdown
    deliver
    economics
  )

  test::printVars MY_ARRAY
  test::func MY_VALUE='deliver' array::remove MY_ARRAY MY_VALUE
  test::printVars MY_ARRAY

  test::func MY_VALUE='holiday' array::remove MY_ARRAY MY_VALUE
  test::printVars MY_ARRAY


  # shellcheck disable=SC2034
  declare -A MY_ASSOCIATIVE_ARRAY
  MY_ASSOCIATIVE_ARRAY[breakdown]=1
  MY_ASSOCIATIVE_ARRAY[deliver]=2
  MY_ASSOCIATIVE_ARRAY[economics]=3

  test::printVars MY_ASSOCIATIVE_ARRAY
  test::func MY_VALUE='1' array::remove MY_ASSOCIATIVE_ARRAY MY_VALUE
  test::printVars MY_ASSOCIATIVE_ARRAY
}

# shellcheck disable=SC2034
function test_array::makeArraysSameSize {
  test::title "✅ Testing array::makeArraysSameSize"

  MY_ARRAY1=("a" "b" "c")
  MY_ARRAY2=("" "2")
  MY_ARRAY3=("x" "y" "z" "w")

  test::printVars MY_ARRAY1 MY_ARRAY2 MY_ARRAY3
  test::func array::makeArraysSameSize MY_ARRAY1 MY_ARRAY2 MY_ARRAY3 MY_ARRAY4
  test::printVars MY_ARRAY1 MY_ARRAY2 MY_ARRAY3 MY_ARRAY4
}

function test_array::fuzzyFilterSort() {
  test::title "✅ Testing array::fuzzyFilterSort"

  MY_ARRAY=(
    "one the"
    "the breakdown"
    "constitutional"
    "conventional"
    "hold the baby"
    "holiday inn"
    "deliver"
    "eLv1"
    "eLv"
    "abundant"
    "make a living"
    "the d day"
    "elevator"
  )

  test::printVars MY_ARRAY
  test::func SEARCH_STRING=the array::fuzzyFilterSort MY_ARRAY SEARCH_STRING

  test::prompt "shopt -s nocasematch"
  shopt -s nocasematch
  test::func SEARCH_STRING=ELV array::fuzzyFilterSort MY_ARRAY SEARCH_STRING
  shopt -u nocasematch
}

main
