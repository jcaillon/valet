#!/usr/bin/env bash

function testString::wrapText() {
  local shortText

  shortText="You don't get better on the days when you feel like going. You get better on the days when you don't want to go, but you go anyway. If you can overcome the negative energy coming from your tired body or unmotivated mind, you will grow and become better. It won't be the best workout you have, you won't accomplish as much as what you usually do when you actually feel good, but that doesn't matter. Growth is a long term game, and the crappy days are more important.

As long as I focus on what I feel and don't worry about where I'm going, it works out. Having no expectations but being open to everything is what makes wonderful things happen. If I don't worry, there's no obstruction and life flows easily. It sounds impractical, but 'Expect nothing; be open to everything' is really all it is.


There were 2 new lines before this."

  echo "→ string::wrapText \"\${shortText}\" 30"
  echo "------------------------------"
  string::wrapText "${shortText}" 30 && echo "${LAST_RETURNED_VALUE}"
  endTest "Wrapping text at column 30 with no padding" 0

  echo "→ string::wrapText \"\${shortText}\" 90 4 false"
  echo "------------------------------------------------------------------------------------------"
  string::wrapText "${shortText}" 90 4 false && echo "${LAST_RETURNED_VALUE}"
  endTest "Wrapping text at column 90 with padding of 4 on new lines" 0

  echo "→ string::wrapText \"\${shortText}\" 90 2 true"
  echo "------------------------------------------------------------------------------------------"
  string::wrapText "${shortText}" 90 2 true && echo "${LAST_RETURNED_VALUE}"
  endTest "Wrapping text at column 90 with padding of 2 on all lines" 0
}

function testArray::fuzzyFilter() {
  lines=("this is a word"
    "very unbelievable"
    "unbelievable"
    "self mock1"
    "self mock2"
    "ublievable")

  declare -p lines

  echo
  echo "→ array::fuzzyFilter evle lines"
  array::fuzzyFilter "evle" lines
  declare -p LAST_RETURNED_ARRAY LAST_RETURNED_ARRAY2 LAST_RETURNED_ARRAY3

  echo
  echo "→ array::fuzzyFilter SC2 lines"
  array::fuzzyFilter "SC2" lines
  declare -p LAST_RETURNED_ARRAY LAST_RETURNED_ARRAY2 LAST_RETURNED_ARRAY3

  echo
  echo "→ array::fuzzyFilter u lines"
  array::fuzzyFilter "u" lines
  declare -p LAST_RETURNED_ARRAY LAST_RETURNED_ARRAY2 LAST_RETURNED_ARRAY3

  echo
  echo "→ array::fuzzyFilter seLf lines"
  array::fuzzyFilter "seLf" lines
  declare -p LAST_RETURNED_ARRAY LAST_RETURNED_ARRAY2 LAST_RETURNED_ARRAY3

  echo
  echo "→ array::fuzzyFilter nomatch lines"
  array::fuzzyFilter "nomatch" lines
  declare -p LAST_RETURNED_ARRAY LAST_RETURNED_ARRAY2 LAST_RETURNED_ARRAY3

  unset lines

  endTest "Testing array::fuzzyFilter" 0
}

function main() {
  testString::wrapText
  testArray::fuzzyFilter
}

main
