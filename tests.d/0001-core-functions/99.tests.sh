#!/usr/bin/env bash

function testWrapText() {
  local shortText

  shortText="You don't get better on the days when you feel like going. You get better on the days when you don't want to go, but you go anyway. If you can overcome the negative energy coming from your tired body or unmotivated mind, you will grow and become better. It won't be the best workout you have, you won't accomplish as much as what you usually do when you actually feel good, but that doesn't matter. Growth is a long term game, and the crappy days are more important.

As long as I focus on what I feel and don't worry about where I'm going, it works out. Having no expectations but being open to everything is what makes wonderful things happen. If I don't worry, there's no obstruction and life flows easily. It sounds impractical, but 'Expect nothing; be open to everything' is really all it is.


There were 2 new lines before this."

  echo "------------------------------"
  wrapText "${shortText}" 30 && echo "${LAST_RETURNED_VALUE}"
  endTest "Wrapping text at column 30 with no padding" 0


  echo "------------------------------------------------------------------------------------------"
  wrapText "${shortText}" 90 4 false && echo "${LAST_RETURNED_VALUE}"
  endTest "Wrapping text at column 90 with padding of 4 on new lines" 0


  echo "------------------------------------------------------------------------------------------"
  wrapText "${shortText}" 90 2 true && echo "${LAST_RETURNED_VALUE}"
  endTest "Wrapping text at column 90 with padding of 2 on all lines" 0
}

function testCutF() {
  echo "--- extracting f1 ---"
  cutF "field1 field2 field3" 1 " " && echo "${LAST_RETURNED_VALUE}"

  echo "--- extracting f2 ---"
  cutF "field1 field2 field3" 2 " " && echo "${LAST_RETURNED_VALUE}"

  echo "--- extracting f3 ---"
  cutF "field1 field2 field3" 3 " " && echo "${LAST_RETURNED_VALUE}"

  echo "--- extracting f4 which does not exist ---"
  cutF "field1 field2 field3" 4 " " && echo "${LAST_RETURNED_VALUE}"

  echo "--- extracting line 2 ---"
  cutF "line1 hm I wonder
line2 does it work on lines?
line3 seems so" 2 $'\n' && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing cutF" 0
}

function testFuzzyMatch() {
  local lines="l1 this is a word
l2 very unbelievable
l2 unbelievable
l3 showcase command1
l4 showcase command2
l5 ublievable"

  echo "--- matching pattern 'evle' ---"
  fuzzyMatch "evle" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo "--- matching pattern 'sh2' ---"
  fuzzyMatch "sh2" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo "--- matching pattern 'u', should prioritize lower index of u ---"
  fuzzyMatch "u" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo "--- matching pattern 'showcase', should be the first equal match ---"
  fuzzyMatch "showcase" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo "--- matching pattern 'lubl', should prioritize lower distance between letters ---"
  fuzzyMatch "lubl" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing fuzzyMatch" 0
}

function testIsFileEmpty() {
  createTempFile && local file="${LAST_RETURNED_VALUE}"

  : > "${file}"
  if isFileEmpty "${file}"; then echo "OK, the file is empty"; else echo "KO"; fi

  echo -n "content" > "${file}"

  if ! isFileEmpty "${file}"; then echo "OK, the file has content"; else echo "KO"; fi

  endTest "Testing isFileEmpty" 0
}


function main() {
  testWrapText
  testCutF
  testFuzzyMatch
  testIsFileEmpty
}

main