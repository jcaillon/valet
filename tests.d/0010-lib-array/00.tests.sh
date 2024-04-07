#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-interactive
source interactive

function testArray::sortArray() {

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
  echo "→ array::sortArray MYARRAY"
  array::sortArray MYARRAY

  declare -p MYARRAY

  endTest "testArray::ing array::sortArray" 0
}

function testArray::appendToArrayIfNotPresent() {

  declare -g MYARRAY=(
    breakdown
    constitutional
  )

  declare -p MYARRAY

  echo
  echo "→ array::appendToArrayIfNotPresent MYARRAY 'deliver'"
  array::appendToArrayIfNotPresent MYARRAY 'deliver'
  echo $?

  declare -p MYARRAY

  echo
  echo "→ array::appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday'"
  array::appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday'
  echo $?

  declare -p MYARRAY

  echo
  echo "→ array::appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday' 'economics'"
  array::appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday' 'economics'
  echo $?

  declare -p MYARRAY

  endTest "testArray::ing array::appendToArrayIfNotPresent" 0
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

function main() {
  testArray::sortArray
  testArray::appendToArrayIfNotPresent
  testArray::isInArray
  testArray::makeArraysSameSize
}

main