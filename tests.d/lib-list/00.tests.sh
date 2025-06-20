#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-list
source list

function main() {
  test_list::getItemDisplayedString
  test_list_fuzzyFilterSortFileWithGrepAndGawk
}

function test_list::getItemDisplayedString() {
  test::title "✅ Testing list::getItemDisplayedString"

  local FG_CYAN=$'\033[36m'
  local FG_RESET=$'\033[0m'

  shopt -s nocasematch

  _LIST_COLOR_LETTER_HIGHLIGHT=">"
  _LIST_COLOR_LETTER_HIGHLIGHT_RESET="<"
  _LIST_ITEM_WIDTH=5
  _LIST_FILTER_STRING="eLor"
  _LIST_ITEM_DISPLAYED="HellO wOrld"

  test::printVars _LIST_COLOR_LETTER_HIGHLIGHT _LIST_COLOR_LETTER_HIGHLIGHT_RESET _LIST_ITEM_WIDTH _LIST_FILTER_STRING _LIST_ITEM_DISPLAYED
  test::func list::getItemDisplayedString
  test::markdown "\`${_LIST_ITEM_DISPLAYED}\`"

  _LIST_ITEM_DISPLAYED="HellO wOrld"
  _LIST_ITEM_WIDTH=15
  test::printVars _LIST_ITEM_WIDTH _LIST_ITEM_DISPLAYED
  test::func list::getItemDisplayedString
  test::markdown "\`${_LIST_ITEM_DISPLAYED}\`"


  _LIST_ITEM_DISPLAYED="${FG_CYAN}HellO${FG_RESET} wOrld"
  _LIST_ITEM_WIDTH=10

  test::printVars _LIST_ITEM_WIDTH _LIST_ITEM_DISPLAYED
  test::func list::getItemDisplayedString
  test::markdown "\`${_LIST_ITEM_DISPLAYED}\`"

  _LIST_ITEM_DISPLAYED="${FG_CYAN}HellO${FG_RESET} wOrld"
  _LIST_ITEM_WIDTH=11

  test::printVars _LIST_ITEM_WIDTH _LIST_ITEM_DISPLAYED
  test::func list::getItemDisplayedString
  test::markdown "\`${_LIST_ITEM_DISPLAYED}\`"

  _LIST_COLOR_LETTER_HIGHLIGHT=$'\033[4m'
  _LIST_COLOR_LETTER_HIGHLIGHT_RESET=$'\033[24m'
  _LIST_ITEM_DISPLAYED='[7m[35md[27m[39m[7m[35mi[27m[39msable the [93mmonitor mode to avoid[39m the "Terminated" message with exit code once the spinner is stopped'
  _LIST_FILTER_STRING="abomamwesspp"
  _LIST_ITEM_WIDTH=71

  test::printVars _LIST_COLOR_LETTER_HIGHLIGHT _LIST_COLOR_LETTER_HIGHLIGHT_RESET _LIST_ITEM_WIDTH _LIST_FILTER_STRING _LIST_ITEM_DISPLAYED
  test::func list::getItemDisplayedString
  test::markdown "\`${_LIST_ITEM_DISPLAYED}\`"

  shopt -u nocasematch
}

function test_list_fuzzyFilterSortFileWithGrepAndGawk() {
  test::title "✅ Testing fuzzy filtering with external programs"

  include array

  mapfile -t _MY_ARRAY <words
  shopt -s nocasematch
  # shellcheck disable=SC2034
  local SEARCH_STRING=ea
  array::fuzzyFilterSort _MY_ARRAY SEARCH_STRING
  shopt -u nocasematch

  test::prompt "SEARCH_STRING=ea array::fuzzyFilterSort _MY_ARRAY SEARCH_STRING"
  test::prompt "fs::head /out1 10"
  local value
  local -i nb=0
  for value in "${RETURNED_ARRAY[@]}"; do
    echo "${value}"
    nb+=1
    if ((nb >= 10)); then
      break
    fi
  done
  test::flush

  test::title "✅ Testing list_fuzzyFilterSortFileWithGrepAndGawk"
  test::prompt "SEARCH_STRING=ea list_fuzzyFilterSortFileWithGrepAndGawk /words SEARCH_STRING /out1 /out2"
  test::prompt "fs::head /out1 10"

  _OPTION_PATH_ONLY=true fs::createTempFile
  local outputFilteredFile="${RETURNED_VALUE}"
  _OPTION_PATH_ONLY=true fs::createTempFile
  local outputCorrespondenceFile="${RETURNED_VALUE}"

  if ! command -v grep &>/dev/null || ! command -v gawk &>/dev/null; then
    test::markdown "> The result is the same as the pure bash implementation."
    return 0
  fi

  list_fuzzyFilterSortFileWithGrepAndGawk words SEARCH_STRING "${outputFilteredFile}" "${outputCorrespondenceFile}"

  fs::readFile "${outputFilteredFile}"
  local awkLines="${RETURNED_VALUE%$'\n'}"
  fs::readFile "${outputCorrespondenceFile}"
  local awkCorrespondences="${RETURNED_VALUE%$'\n'}"

  local IFS=$'\n'
  local bashLines="${RETURNED_ARRAY[*]}"
  # shellcheck disable=SC2153
  local bashCorrespondences="${RETURNED_ARRAY2[*]}"

  # check that the lines are the same
  if [[ "${awkLines}" != "${bashLines}" ]]; then
    echo "Outputs are different!"
    echo "awkLines:"
    echo "${awkLines}"
    echo
    echo "bashLines:"
    echo "${bashLines}"
    test::fail "The result is different from the pure bash implementation."
  fi
  if [[ "${awkCorrespondences}" != "${bashCorrespondences}" ]]; then
    echo "Correspondences are different!"
    echo "awkCorrespondences:"
    echo "${awkCorrespondences}"
    echo
    echo "bashCorrespondences:"
    echo "${bashCorrespondences}"
    test::fail "The result is different from the pure bash implementation."
  fi

  test::markdown "> The result is the same as the pure bash implementation."
}

main
