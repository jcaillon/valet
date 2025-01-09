#!/usr/bin/env bash
set -Eeu -o pipefail
# https://en.wikipedia.org/wiki/Sorting_algorithm

#===============================================================
# >>> Source main functions
#===============================================================
# shellcheck source=../../libraries.d/core
source "libraries.d/core"

# shellcheck source=../../libraries.d/lib-benchmark
source benchmark
# shellcheck source=../../libraries.d/lib-array
source array

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

function smoothsort1() {
  local -i pp=1 rr=-1 ii tt=0

  # build the Leonardo heap
  local -a -i heap=()
  for ((ii = 0; ii < ${#KEYS[@]}; ii++)); do
    if ((pp & 3 == 3)); then
      heap+=(pp)
      heap+=($((pp + 1)))
      tt+=1
    elif ((pp & 1 == 1)); then
      if ((ii != 0)); then
        heap+=(rr)
      fi
      rr=pp
    fi
    pp=$((pp >> 1))
  done
  echo "HEAP: ${heap[*]}"
  # local -i tt=${#heap[@]}
  local -i jj

  local -i tmpKey
  local tmpValue

  while ((tt > 0)); do
    tt=$((tt - 1))
    ii=${heap[tt]}
    tmpKey=${KEYS[ii]}
    tmpValue="${VALUES[ii]}"
    while ((ii > 1)); do
      jj=$((ii - 2))
      if ((KEYS[jj] > tmpKey)); then
      echo "swapping ${KEYS[ii]} with ${KEYS[jj]}"
        KEYS[ii]=${KEYS[jj]}
        VALUES[ii]="${VALUES[jj]}"
        ii=jj
      else
        break
      fi
    done
    KEYS[ii]=${tmpKey}
    VALUES[ii]="${tmpValue}"
  done
}

function smoothsort2() {
  local -i pp=1 rr=-1 ii tt=0

  # build the Leonardo heap
  local -a -i heap=()
  for ((ii = 0; ii < ${#KEYS[@]}; ii++)); do
    if ((pp & 3 == 3)); then
      heap+=(pp)
      heap+=($((pp + 1)))
      tt+=1
    elif ((pp & 1 == 1)); then
      if ((ii != 0)); then
        heap+=(rr)
      fi
      rr=pp
    fi
    pp=$((pp >> 1))
  done
  echo "HEAP: ${heap[*]}"

  for ((ii = ${#heap[@]} - 1; ii >= 0; ii--)); do
    sift ${heap[ii]} ${#KEYS[@]}
  done

  # downward sifting
  for ((ii = ${#KEYS[@]} - 1; ii > 0; ii--)); do
    if ((${heap[tt - 1]} == ii)); then
      tt=$((tt - 1))
      sift ${heap[ii]} ${ii}
    else
      sift 1 ${ii}
    fi
    # swap the 0 and ii elements
    local tmpKey=${KEYS[0]}
    local tmpValue=${VALUES[0]}
    KEYS[0]=${KEYS[ii]}
    VALUES[0]=${VALUES[ii]}
    KEYS[ii]=${tmpKey}
    VALUES[ii]=${tmpValue}
  done
}

function sift() {
  local -i pp=${1}
  local -i nn=${2}
  while ((pp > 1)); do
    if ((${KEYS[pp - 2]} <= ${KEYS[pp - 1]})); then
      pp=$((pp - 1))
    else
      # swap the pp-2 and pp-1 elements
      local tmpKey=${KEYS[pp - 2]}
      local tmpValue=${VALUES[pp - 2]}
      KEYS[pp - 2]=${KEYS[pp - 1]}
      VALUES[pp - 2]=${VALUES[pp - 1]}
      KEYS[pp - 1]=${tmpKey}
      VALUES[pp - 1]=${tmpValue}
      pp=$((pp - 1 <= nn / 2 ? 2 * pp : 2 * (pp - 1)))
    fi
  done
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
