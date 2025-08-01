#!/usr/bin/env bash
set -Eeu -o pipefail
# https://en.wikipedia.org/wiki/Sorting_algorithm
# shellcheck source=../../../libraries.d/main
source "$(valet --source)"
include benchmark array

#===============================================================
# >>> Run the main function
#===============================================================

function quicksort() {
  local -i low=${1}
  local -i high=${2}

  if ((low >= high)); then
    return 0
  fi

  local pivot="${_myArray[low + (high - low) / 2]}"

  local -i left=$((low - 1))
  local -i right=$((high + 1))

  local -i partitionPoint
  local tempValue

  while true; do
    left+=1
    right=$((right - 1))

    while [[ ${_myArray[left]} < "${pivot}" ]]; do
      left+=1
    done
    while [[ ${pivot} < "${_myArray[right]}" ]]; do
      right=$((right - 1))
    done

    if ((left >= right)); then
      partitionPoint=${right}
      break;
    fi

    tempValue="${_myArray[left]}"
    _myArray[left]="${_myArray[right]}"
    _myArray[right]="${tempValue}"
  done

  quicksort ${low} ${partitionPoint}
  quicksort $((partitionPoint + 1)) ${high}
}

function quicksort2() {
  local tempValue pivot="${_myArray[${1} + (${2} - ${1}) / 2]}"
  local -i left=${1} right=${2}
  while :; do
    while [[ ${_myArray[left]} < "${pivot}" ]]; do
      left+=1
    done
    while [[ ${pivot} < "${_myArray[right]}" ]]; do
      right=$((right - 1))
    done
    if ((left >= right)); then
      break;
    fi
    tempValue="${_myArray[left]}"
    _myArray[left]="${_myArray[right]}"
    _myArray[right]="${tempValue}"
    left+=1
    right=$((right - 1))
  done
  if ((${1} < ${right})); then
    quicksort2 ${1} ${right}
  fi
  if (($((right + 1)) < ${2})); then
    quicksort2 $((right + 1)) ${2}
  fi
}

function baseline() {
  _myArray=("${VALUES_ORIGINAL[@]}")
  quicksort 0 $(( ${#_myArray[@]} - 1 ))
}

function newImplementation1() {
  _myArray=("${VALUES_ORIGINAL[@]}")
  quicksort2 0 $(( ${#_myArray[@]} - 1 ))
}

mapfile -t VALUES_ORIGINAL <benchmarks/array/sort-test-values

# IFS=$'\n'
# baseline
# echo "${VALUES[*]}" >file5
# newImplementation1
# echo "${VALUES[*]}" >file6

benchmark::run baseline newImplementation1
