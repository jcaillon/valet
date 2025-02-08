#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-array
source array
# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_array::sort
  test_array::sortWithCriteria
  test_array::appendIfNotPresent
  test_array::checkIfPresent
  test_array::makeArraysSameSize
  test_array::fuzzyFilterSort
  test_array::fuzzyFilterSortFileWithGrepAndGawk
}

function test_array::sort() {
  test::title "✅ Testing array::sort"

  declare -g MY_ARRAY=(
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

  declare -g MY_ARRAY=(a b c d e f g)
  declare -g MY_CRITERIA1=(3 2 2 1 1 4 0)
  declare -g MY_CRITERIA2=(1 3 2 5 0 2 9)

  test::printVars MY_ARRAY MY_CRITERIA1 MY_CRITERIA2
  test::func array::sortWithCriteria MY_ARRAY MY_CRITERIA1 MY_CRITERIA2
  test::printVars MY_ARRAY
  echo "got:      ${MY_ARRAY[*]}"
  echo "expected: g e d c b a f"
  test::flush
}

function test_array::appendIfNotPresent() {
  test::title "✅ Testing array::appendIfNotPresent"

  declare -g MY_ARRAY=(
    breakdown
    constitutional
  )

  test::printVars MY_ARRAY
  test::func MY_VALUE='deliver' array::appendIfNotPresent MY_ARRAY MY_VALUE
  test::printVars MY_ARRAY

  test::func MY_VALUE='breakdown' array::appendIfNotPresent MY_ARRAY MY_VALUE
  test::printVars MY_ARRAY
}

function test_array::checkIfPresent() {
  test::title "✅ Testing array::checkIfPresent"

  declare -g MY_ARRAY=(
    breakdown
    deliver
    economics
  )

  test::printVars MY_ARRAY
  test::func MY_VALUE='deliver' array::checkIfPresent MY_ARRAY MY_VALUE
  test::printVars MY_ARRAY

  test::func MY_VALUE='holiday' array::checkIfPresent MY_ARRAY MY_VALUE
  test::printVars MY_ARRAY
}

# shellcheck disable=SC2034
function test_array::makeArraysSameSize {
  test::title "✅ Testing array::makeArraysSameSize"

  declare -g MY_ARRAY1=("a" "b" "c")
  declare -g MY_ARRAY2=("" "2")
  declare -g MY_ARRAY3=("x" "y" "z" "w")

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

function test_array::fuzzyFilterSortFileWithGrepAndGawk() {
  test::title "✅ Testing array::fuzzyFilterSortFileWithGrepAndGawk"

  mapfile -t _MY_ARRAY <words
  shopt -s nocasematch
  # shellcheck disable=SC2034
  local SEARCH_STRING=ea
  array::fuzzyFilterSort _MY_ARRAY SEARCH_STRING
  shopt -u nocasematch

  test::prompt "SEARCH_STRING=ea array::fuzzyFilterSortFileWithGrepAndGawk /words SEARCH_STRING /out1 /out2"
  test::prompt "fs::head /out1 10"
  local value
  local -i nb=0
  for value in "${RETURNED_ARRAY[@]}"; do
    echo "${value}"
    nb+=1
    if ((nb >= 10)); then
      break
    fi
  done
  test::flush


  fs::createTempFile
  local outputFilteredFile="${RETURNED_VALUE}"
  fs::createTempFile
  local outputCorrespondenceFile="${RETURNED_VALUE}"

  if ! command -v grep &>/dev/null || ! command -v gawk &>/dev/null; then
    test::markdown "> The result is the same as the pure bash implementation."
    return 0
  fi

  array::fuzzyFilterSortFileWithGrepAndGawk words SEARCH_STRING "${outputFilteredFile}" "${outputCorrespondenceFile}"

  fs::readFile "${outputFilteredFile}"
  local awkLines="${RETURNED_VALUE%$'\n'}"
  fs::readFile "${outputCorrespondenceFile}"
  local awkCorrespondences="${RETURNED_VALUE%$'\n'}"

  local IFS=$'\n'
  local bashLines="${RETURNED_ARRAY[*]}"
  # shellcheck disable=SC2153
  local bashCorrespondences="${RETURNED_ARRAY2[*]}"

  # check that the lines are the same
  if [[ "${awkLines}" != "${bashLines}" ]]; then
    echo "Outputs are different!"
    echo "awkLines:"
    echo "${awkLines}"
    echo
    echo "bashLines:"
    echo "${bashLines}"
    exit 1
  fi
  if [[ "${awkCorrespondences}" != "${bashCorrespondences}" ]]; then
    echo "Correspondences are different!"
    echo "awkCorrespondences:"
    echo "${awkCorrespondences}"
    echo
    echo "bashCorrespondences:"
    echo "${bashCorrespondences}"
    exit 1
  fi

  test::markdown "> The result is the same as the pure bash implementation."
}

main
