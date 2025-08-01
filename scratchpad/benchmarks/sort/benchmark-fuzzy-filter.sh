#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark array

function array::fuzzyFilterSort2() {
  local -n arrayToFilter="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"
  local -n filterSearchString="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"

  # nothing to filter
  if [[ -z ${filterSearchString} || ${#arrayToFilter[@]} -eq 0 ]]; then
    REPLY_ARRAY=("${arrayToFilter[@]}")
    eval "REPLY_ARRAY2=( {0..$((${#arrayToFilter[@]} - 1))} )"
    return 0
  fi

  # prepare the regex for the searched string
  # the -> '([^t]*)(t[^h]*h[^e]*e)'
  local patternRegex="^([^${filterSearchString:0:1}]*)(${filterSearchString:0:1}"
  local -i index
  for ((index = 1; index < ${#filterSearchString}; index++)); do
    patternRegex+="[^${filterSearchString:index:1}]*${filterSearchString:index:1}"
  done
  patternRegex+=")(.?)"
  local -i patternLength=${#filterSearchString}

  # will contain a key that allows to sort the items, it is a combination of the length before the pattern,
  # the length of the matched pattern and the initial position of the item
  _ARRAY_FUZZY_FILTER_KEYS=()
  # will contain the original indexes corresponding to the sorted array
  REPLY_ARRAY2=()

  local value
  index=0
  for value in "${arrayToFilter[@]}"; do
    if [[ ${value} =~ ${patternRegex} ]]; then
      if ((${#BASH_REMATCH[3]} == 0 && patternLength == ${#BASH_REMATCH[0]})); then
        _ARRAY_FUZZY_FILTER_KEYS+=($((index)))
      else
        _ARRAY_FUZZY_FILTER_KEYS+=($((${#BASH_REMATCH[1]} * 10000000 + ${#BASH_REMATCH[2]} * 10000 + index)))
      fi
      REPLY_ARRAY2+=($((index)))
    fi
    index+=1
  done

  array::fuzzyFilterSortQuicksort 0 $((${#_ARRAY_FUZZY_FILTER_KEYS[@]} - 1))

  # will contain the matched lines, sorted
  REPLY_ARRAY=()
  for ((index = 0; index < ${#REPLY_ARRAY2[@]}; index++)); do
    REPLY_ARRAY+=("${arrayToFilter[REPLY_ARRAY2[index]]}")
  done
  unset -v _ARRAY_FUZZY_FILTER_KEYS
}

FILTER_STRING=ea

function baseline() {
  array::fuzzyFilterSort VALUES_ORIGINAL FILTER_STRING
}

function newImplementation1() {
  array::fuzzyFilterSort2 VALUES_ORIGINAL FILTER_STRING
}

# shellcheck disable=SC2034
mapfile -t VALUES_ORIGINAL <benchmark/array/sort-test-values

shopt -s nocasematch

# assert both implementations are the same
echo "Running the baseline..."
baseline
BASELINE_ARRAY=("${REPLY_ARRAY[@]}")
BASELINE_ARRAY2=("${REPLY_ARRAY2[@]}")
echo "Running the new implementation..."
newImplementation1
NEW_ARRAY=("${REPLY_ARRAY[@]}")
NEW_ARRAY2=("${REPLY_ARRAY2[@]}")

if [[ ${BASELINE_ARRAY[*]} != "${NEW_ARRAY[*]}" || ${BASELINE_ARRAY2[*]} != "${NEW_ARRAY2[*]}" ]]; then
  echo "The results are different!"
  echo "BASELINE_ARRAY: ${BASELINE_ARRAY[*]}"
  echo "NEW_ARRAY: ${NEW_ARRAY[*]}"
  echo
  echo "BASELINE_ARRAY2: ${BASELINE_ARRAY2[*]}"
  echo "NEW_ARRAY2: ${NEW_ARRAY2[*]}"

  IFS=$'\n'
  echo "${BASELINE_ARRAY[*]}" >file5
  echo "${NEW_ARRAY[*]}" >file6
  exit 1
else
  echo "The results are the same!"
fi

# IFS=$'\n'
# baseline
# echo "${VALUES[*]}" >file5
# newImplementation1
# echo "${VALUES[*]}" >file6

benchmark::run baseline newImplementation1
