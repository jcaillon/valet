#!/usr/bin/env bash
set -Eeu -o pipefail
# https://en.wikipedia.org/wiki/Sorting_algorithm
# shellcheck source=../../libraries.d/core
source "libraries.d/core"
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

function baseline() {
  KEYS=("${KEYS_ORIGINAL[@]}")
  VALUES=("${VALUES_ORIGINAL[@]}")
  quicksort 0 $(( ${#KEYS[@]} - 1 ))
}

function newImplementation1() {
  KEYS=("${KEYS_ORIGINAL[@]}")
  VALUES=("${VALUES_ORIGINAL[@]}")
  quicksort2 0 $(( ${#KEYS[@]} - 1 ))
}

mapfile -t KEYS_ORIGINAL <benchmarks/array/sort-test-keys
mapfile -t VALUES_ORIGINAL <benchmarks/array/sort-test-values

shopt -s nocasematch

# can't compare them cause they are unstable sorting algo

# IFS=$'\n'
# baseline
# echo "${VALUES[*]}" >file5
# newImplementation1
# echo "${VALUES[*]}" >file6

benchmark::run baseline newImplementation1
