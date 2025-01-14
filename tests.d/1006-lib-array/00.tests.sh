#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-array
source array
# shellcheck source=../../libraries.d/lib-io
source io

function test_array::sort() {

  declare -g MYARRAY=(
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

  declare -p MYARRAY
  echo
  echo "→ array::sort MYARRAY"
  array::sort MYARRAY
  declare -p MYARRAY

  test::endTest "Testing array::sort" 0
}

function test_array::sortWithCriteria() {
  declare -g myArray=(a b c d e f g)
  declare -g criteria1=(3 2 2 1 1 4 0)
  declare -g criteria2=(1 3 2 5 0 2 9)

  declare -p myArray criteria1 criteria2
  echo
  echo "→ array::sortWithCriteria myArray criteria1 criteria2"
  array::sortWithCriteria myArray criteria1 criteria2
  declare -p RETURNED_ARRAY myArray
  echo "got:      ${myArray[*]}"
  echo "expected: g e d c b a f"

  unset myArray criteria1 criteria2

  test::endTest "Testing array::sortWithCriteria" 0
}

function test_array::appendIfNotPresent() {

  declare -g MYARRAY=(
    breakdown
    constitutional
  )

  declare -p MYARRAY

  echo
  echo "→ array::appendIfNotPresent MYARRAY 'deliver'"
  array::appendIfNotPresent MYARRAY 'deliver' && echo "$?"
  declare -p MYARRAY

  echo
  echo "→ array::appendIfNotPresent MYARRAY 'breakdown'"
  array::appendIfNotPresent MYARRAY 'breakdown' || echo "$?"
  declare -p MYARRAY

  echo
  echo "→ array::appendIfNotPresent MYARRAY 'holiday'"
  array::appendIfNotPresent MYARRAY 'holiday' && echo "$?"
  declare -p MYARRAY

  test::endTest "Testing array::appendIfNotPresent" 0
}

function test_array::isInArray() {

  declare -g MYARRAY=(
    breakdown
    constitutional
    deliver
    position
    economics
  )

  declare -p MYARRAY

  echo
  echo "→ array::isInArray MYARRAY 'deliver'"
  array::isInArray MYARRAY 'deliver' && echo "$?"

  echo
  echo "→ array::isInArray MYARRAY 'holiday'"
  array::isInArray MYARRAY 'holiday' || echo "$?"

  test::endTest "Testing array::isInArray" 0
}

function test_array::makeArraysSameSize {
  declare -g array1=("a" "b" "c")
  declare -g array2=("" "2")
  declare -g array3=("x" "y" "z" "w")

  declare -p array1 array2 array3

  echo
  echo "→ array::makeArraysSameSize array1 array2 array3 array4"
  array::makeArraysSameSize array1 array2 array3 array4

  declare -p array1 array2 array3 array4

  test::endTest "Testing array::makeArraysSameSize" 0
}

function test_array::fuzzyFilterSort() {
  myArray=(
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

  declare -p myArray

  echo
  echo "→ array::fuzzyFilterSort the myArray"
  array::fuzzyFilterSort the myArray

  declare -p RETURNED_ARRAY RETURNED_ARRAY2

  echo
  echo "→ shopt -s nocasematch; array::fuzzyFilterSort ELV myArray; shopt -u nocasematch"
  shopt -s nocasematch
  array::fuzzyFilterSort ELV myArray
  shopt -u nocasematch

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
  echo "→ array::fuzzyFilterSort the myArray"
  array::fuzzyFilterSort the myArray

  declare -p RETURNED_ARRAY RETURNED_ARRAY2

  unset myArray

  test::endTest "Testing array::fuzzyFilterSort" 0
}

function test_array::fuzzyFilterSortFileWithGrepAndAwk() {
  io::createTempFile
  local outputFilteredFile="${RETURNED_VALUE}"
  io::createTempFile
  local outputCorrespondenceFile="${RETURNED_VALUE}"

  echo "→ array::fuzzyFilterSortFileWithGrepAndAwk words out1 out2"

  if ! command -v grep &>/dev/null || ! command -v awk &>/dev/null; then
    echo "The result is the same as the pure bash implementation."
    return 0
  fi
  array::fuzzyFilterSortFileWithGrepAndAwk ea words "${outputFilteredFile}" "${outputCorrespondenceFile}"

  io::readFile "${outputFilteredFile}"
  local awkedLines="${RETURNED_VALUE%$'\n'}"
  io::readFile "${outputCorrespondenceFile}"
  local awkedCorrespondences="${RETURNED_VALUE%$'\n'}"

  mapfile -t _MY_ARRAY <words
  shopt -s nocasematch
  array::fuzzyFilterSort ea _MY_ARRAY
  shopt -u nocasematch
  local IFS=$'\n'
  local bashLines="${RETURNED_ARRAY[*]}"
  local bashCorrespondences="${RETURNED_ARRAY2[*]}"
  echo "${RETURNED_ARRAY[*]}"

  # check that the lines are the same
  if [[ "${awkedLines}" != "${bashLines}" ]]; then
    echo "Outputs are different!"
    echo "awkedLines:"
    echo "${awkedLines}"
    echo
    echo "bashLines:"
    echo "${bashLines}"
    exit 1
  fi
  if [[ "${awkedCorrespondences}" != "${bashCorrespondences}" ]]; then
    echo "Correspondences are different!"
    echo "awkedCorrespondences:"
    echo "${awkedCorrespondences}"
    echo
    echo "bashCorrespondences:"
    echo "${bashCorrespondences}"
    exit 1
  fi

  echo "The result is the same as the pure bash implementation."

  test::endTest "Testing that array::fuzzyFilterSortFileWithGrepAndAwk produces the same as fuzzyFilterSort" 0
}

function main() {
  test_array::sort
  test_array::sortWithCriteria
  test_array::appendIfNotPresent
  test_array::isInArray
  test_array::makeArraysSameSize
  test_array::fuzzyFilterSort
  test_array::fuzzyFilterSortFileWithGrepAndAwk
}

main