#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-array
source array

function testarray::sort() {

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

  endTest "testArray::ing array::sort" 0
}

function testarray::appendIfNotPresent() {

  declare -g MYARRAY=(
    breakdown
    constitutional
  )

  declare -p MYARRAY

  echo
  echo "→ array::appendIfNotPresent MYARRAY 'deliver'"
  array::appendIfNotPresent MYARRAY 'deliver'
  echo $?

  declare -p MYARRAY

  echo
  echo "→ array::appendIfNotPresent MYARRAY 'deliver' 'holiday'"
  array::appendIfNotPresent MYARRAY 'deliver' 'holiday'
  echo $?

  declare -p MYARRAY

  echo
  echo "→ array::appendIfNotPresent MYARRAY 'deliver' 'holiday' 'economics'"
  array::appendIfNotPresent MYARRAY 'deliver' 'holiday' 'economics'
  echo $?

  declare -p MYARRAY

  endTest "testArray::ing array::appendIfNotPresent" 0
}

function testArray::isInArray() {

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

  endTest "testArray::ing array::isInArray" 0
}

function testArray::makeArraysSameSize {
  declare -g array1=("a" "b" "c")
  declare -g array2=("" "2")
  declare -g array3=("x" "y" "z" "w")

  declare -p array1 array2 array3

  echo
  echo "→ array::makeArraysSameSize array1 array2 array3 array4"
  array::makeArraysSameSize array1 array2 array3 array4

  declare -p array1 array2 array3 array4

  endTest "testArray::ing array::makeArraysSameSize" 0
}

function testArray::sortWithCriteria() {
  declare -g myArray=(   a b c d e f g )
  declare -g criteria1=( 3 2 2 1 1 4 0 )
  declare -g criteria2=( 1 3 2 5 0 2 9 )

  declare -p myArray criteria1 criteria2

  echo
  echo "→ array::sortWithCriteria myArray criteria1 criteria2"
  array::sortWithCriteria myArray criteria1 criteria2

  declare -p myArray
  echo "expected: g e d c b a f"

  endTest "testArray::ing array::sortWithCriteria" 0
}

function main() {
  testarray::sort
  testarray::appendIfNotPresent
  testArray::isInArray
  testArray::makeArraysSameSize
  testArray::sortWithCriteria
}

main