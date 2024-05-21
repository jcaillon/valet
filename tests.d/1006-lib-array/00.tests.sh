#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-array
source array

function testArray::sort() {

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

  test::endTest "testArray::ing array::sort" 0
}

function testArray::appendIfNotPresent() {

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
  echo "→ array::appendIfNotPresent MYARRAY 'breakdown'"
  array::appendIfNotPresent MYARRAY 'breakdown' || echo "Failed as expected"
  echo $?

  declare -p MYARRAY

  echo
  echo "→ array::appendIfNotPresent MYARRAY 'holiday'"
  array::appendIfNotPresent MYARRAY 'holiday'
  echo $?

  declare -p MYARRAY

  test::endTest "testArray::ing array::appendIfNotPresent" 0
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

  test::endTest "testArray::ing array::isInArray" 0
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

  test::endTest "testArray::ing array::makeArraysSameSize" 0
}

function testArray::sortWithCriteria() {
  declare -g   myArray=(a b c d e f g)
  declare -g criteria1=(3 2 2 1 1 4 0)
  declare -g criteria2=(1 3 2 5 0 2 9)

  declare -p myArray criteria1 criteria2

  echo
  echo "→ array::sortWithCriteria myArray criteria1 criteria2"
  array::sortWithCriteria myArray criteria1 criteria2
  declare -p RETURNED_ARRAY myArray
  echo "expected: g e d c b a f"

  declare -a ARRAY_MATCHES=([0]="one the" [1]="the breakdown" [2]="holding the baby" [3]="the d day")
  declare -a ARRAY_INDEXES=([0]="4" [1]="0" [2]="8" [3]="0")
  declare -a ARRAY_DISTANCES=([0]="0" [1]="0" [2]="0" [3]="0")

  declare -p ARRAY_MATCHES ARRAY_INDEXES ARRAY_DISTANCES

  echo
  echo "→ array::sortWithCriteria ARRAY_MATCHES ARRAY_INDEXES ARRAY_DISTANCES"
  array::sortWithCriteria ARRAY_MATCHES ARRAY_INDEXES ARRAY_DISTANCES

  declare -p RETURNED_ARRAY ARRAY_MATCHES

  unset ARRAY_MATCHES ARRAY_INDEXES ARRAY_DISTANCES

  test::endTest "tesing array::sortWithCriteria" 0
}

function testArray::fuzzyFilterSort() {
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
  echo "→ array::fuzzyFilterSort the myArray"
  array::fuzzyFilterSort the myArray

  declare -p RETURNED_ARRAY RETURNED_ARRAY2

  echo
  echo "→ array::fuzzyFilterSort elv myArray ⌜ ⌝"
  array::fuzzyFilterSort elv myArray ⌜ ⌝

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
  echo "→ array::fuzzyFilterSort the myArray ⌜ ⌝ 6"
  array::fuzzyFilterSort the myArray ⌜ ⌝ 6

  declare -p RETURNED_ARRAY RETURNED_ARRAY2

  unset myArray

  test::endTest "testing array::fuzzyFilterSort" 0
}

function main() {
  testArray::sort
  testArray::appendIfNotPresent
  testArray::isInArray
  testArray::makeArraysSameSize
  testArray::sortWithCriteria
  testArray::fuzzyFilterSort
}

main
