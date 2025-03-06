#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include array

function main() {
  local _myArray
  local _searchString

  mapfile -t _myArray <"scratchpad/f3"
  mapfile -t _myArray <"scratchpad/arrays/w"

  _searchString="s"

  time array::fuzzyFilterSort _myArray _searchString

  local IFS=$'\n'
  # echo "${RETURNED_ARRAY[*]}"
  echo "-> ${#RETURNED_ARRAY[@]} elements"

  array::sort _myArray
  echo "${_myArray[*]}"

  local RETURNED_ARRAY2
  local _ARRAY_FUZZY_FILTER_KEYS
  mapfile -t _ARRAY_FUZZY_FILTER_KEYS <"scratchpad/arrays/w3"
  eval "RETURNED_ARRAY2=( {0..$((${#_ARRAY_FUZZY_FILTER_KEYS[@]} - 1))} )"
  array::fuzzyFilterSortQuicksort 0 $((${#_ARRAY_FUZZY_FILTER_KEYS[@]} - 1))
  echo "${_ARRAY_FUZZY_FILTER_KEYS[*]}"

  # echo ----

  # mapfile -t _ARRAY_FUZZY_FILTER_KEYS <"scratchpad/arrays/w3"
  # array::sort _ARRAY_FUZZY_FILTER_KEYS
  # echo "${_ARRAY_FUZZY_FILTER_KEYS[*]}"

}

main
