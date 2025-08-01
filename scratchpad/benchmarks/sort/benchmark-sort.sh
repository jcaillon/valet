#!/usr/bin/env bash
set -Eeu -o pipefail
# https://en.wikipedia.org/wiki/Sorting_algorithm
# shellcheck source=../../../libraries.d/main
source "$(valet --source)"
include benchmark array

#===============================================================
# >>> Run the main function
#===============================================================

quicksort1() {
  local -i low=${1}
  local -i high=${2}
  if ((low >= high)); then
    return 0
  fi

  # we choose a pivot here, we could also select a random element
  local pivot=${KEYS[$((low + SRANDOM % (high - low)))]}

  local -i i=${low}
  local -i j=${high}
  local tmpKey tempValue
  while ((i <= j)); do
    while ((KEYS[i] < pivot)); do
      i+=1
    done
    while ((KEYS[j] > pivot)); do
      j=$((j - 1))
    done
    if ((i <= j)); then
      tmpKey=${KEYS[i]}
      tempValue=${VALUES[i]}
      KEYS[i]=${KEYS[j]}
      VALUES[i]=${VALUES[j]}
      KEYS[j]=${tmpKey}
      VALUES[j]=${tempValue}
      i+=1
      j=$((j - 1))
    fi
  done
  # recursion
  if ((low < j)); then
    quicksort1 "${low}" "${j}"
  fi
  if ((i < high)); then
    quicksort1 "${i}" "${high}"
  fi
}

quicksort2() {
  local -i low=${1}
  local -i high=${2}

  if ((low >= high)); then
    return 0
  fi

  local tmpKey tempValue

  local -i pivotIndex=$((low + SRANDOM % (high - low)))

  if ((pivotIndex != high)); then
    # swap the pivot with the high element
    tmpKey=${KEYS[pivotIndex]}
    tempValue=${VALUES[pivotIndex]}
    KEYS[pivotIndex]=${KEYS[high]}
    VALUES[pivotIndex]=${VALUES[high]}
    KEYS[high]=${tmpKey}
    VALUES[high]=${tempValue}
  fi

  local pivot=${KEYS[high]}
  local -i ii=low jj

  for ((jj = low; jj < high; jj++)); do
    if ((KEYS[jj] <= pivot)); then
      # swap the ii and jj elements
      tmpKey=${KEYS[ii]}
      tempValue=${VALUES[ii]}
      KEYS[ii]=${KEYS[jj]}
      VALUES[ii]=${VALUES[jj]}
      KEYS[jj]=${tmpKey}
      VALUES[jj]=${tempValue}
      ii+=1
    fi
  done

  # swap the ii and high elements
  tmpKey=${KEYS[ii]}
  tempValue=${VALUES[ii]}
  KEYS[ii]=${KEYS[high]}
  VALUES[ii]=${VALUES[high]}
  KEYS[high]=${tmpKey}
  VALUES[high]=${tempValue}

  # apply quicksort to the left side subarray
  if ((low < ii - 1)); then
    quicksort2 ${low} $((ii - 1))
  fi
  if ((ii + 1 < high)); then
    quicksort2 $((ii + 1)) ${high}
  fi
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

mapfile -t KEYS_ORIGINAL <tests.d/1006-lib-array/sort-test-keys
mapfile -t VALUES_ORIGINAL <tests.d/1006-lib-array/sort-test-values

shopt -s nocasematch

# can't compare them cause they are unstable sorting algo

# IFS=$'\n'
# baseline
# echo "${VALUES[*]}" >file5
# newImplementation1
# echo "${VALUES[*]}" >file6

benchmark::run baseline newImplementation1
