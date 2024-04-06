#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-interactive
source interactive

function testSortArray() {

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
  echo "→ sortArray MYARRAY"
  sortArray MYARRAY

  declare -p MYARRAY

  endTest "Testing sortArray" 0
}

function testAppendToArrayIfNotPresent() {

  declare -g MYARRAY=(
    breakdown
    constitutional
  )

  declare -p MYARRAY

  echo
  echo "→ appendToArrayIfNotPresent MYARRAY 'deliver'"
  appendToArrayIfNotPresent MYARRAY 'deliver'
  echo $?

  declare -p MYARRAY

  echo
  echo "→ appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday'"
  appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday'
  echo $?

  declare -p MYARRAY

  echo
  echo "→ appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday' 'economics'"
  appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday' 'economics'
  echo $?

  declare -p MYARRAY

  endTest "Testing appendToArrayIfNotPresent" 0
}

function testIsInArray() {

  declare -g MYARRAY=(
    breakdown
    constitutional
    deliver
    position
    economics
  )

  declare -p MYARRAY

  echo
  echo "→ isInArray MYARRAY 'deliver'"
  isInArray MYARRAY 'deliver' && echo "$?"

  echo
  echo "→ isInArray MYARRAY 'holiday'"
  isInArray MYARRAY 'holiday' || echo "$?"

  endTest "Testing isInArray" 0
}

function testMakeArraysSameSize {
  declare -g array1=("a" "b" "c")
  declare -g array2=("" "2")
  declare -g array3=("x" "y" "z" "w")

  declare -p array1 array2 array3

  echo
  echo "→ makeArraysSameSize array1 array2 array3 array4"
  makeArraysSameSize array1 array2 array3 array4

  declare -p array1 array2 array3 array4

  endTest "Testing makeArraysSameSize" 0
}

function main() {
  testSortArray
  testAppendToArrayIfNotPresent
  testIsInArray
  testMakeArraysSameSize
}

main