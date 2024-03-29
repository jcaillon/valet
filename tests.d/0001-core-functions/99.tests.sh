#!/usr/bin/env bash

function testWrapText() {
  local shortText

  shortText="You don't get better on the days when you feel like going. You get better on the days when you don't want to go, but you go anyway. If you can overcome the negative energy coming from your tired body or unmotivated mind, you will grow and become better. It won't be the best workout you have, you won't accomplish as much as what you usually do when you actually feel good, but that doesn't matter. Growth is a long term game, and the crappy days are more important.

As long as I focus on what I feel and don't worry about where I'm going, it works out. Having no expectations but being open to everything is what makes wonderful things happen. If I don't worry, there's no obstruction and life flows easily. It sounds impractical, but 'Expect nothing; be open to everything' is really all it is.


There were 2 new lines before this."

  echo "→ wrapText \"\${shortText}\" 30"
  echo "------------------------------"
  wrapText "${shortText}" 30 && echo "${LAST_RETURNED_VALUE}"
  endTest "Wrapping text at column 30 with no padding" 0


  echo "→ wrapText \"\${shortText}\" 90 4 false"
  echo "------------------------------------------------------------------------------------------"
  wrapText "${shortText}" 90 4 false && echo "${LAST_RETURNED_VALUE}"
  endTest "Wrapping text at column 90 with padding of 4 on new lines" 0


  echo "→ wrapText \"\${shortText}\" 90 2 true"
  echo "------------------------------------------------------------------------------------------"
  wrapText "${shortText}" 90 2 true && echo "${LAST_RETURNED_VALUE}"
  endTest "Wrapping text at column 90 with padding of 2 on all lines" 0
}

function testCutF() {
  echo "→ cutF \"field1 field2 field3\" 1 \" \""
  cutF "field1 field2 field3" 1 " " && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ cutF \"field1 field2 field3\" 2 \" \""
  cutF "field1 field2 field3" 2 " " && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ cutF \"field1 field2 field3\" 3 \" \""
  cutF "field1 field2 field3" 3 " " && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ cutF \"field1 field2 field3\" 4 \" \""
  cutF "field1 field2 field3" 4 " " && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ cutF \"line1 hm I wonder
line2 does it work on lines?
line3 seems so\" 2 \$'\n'"
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

  echo "lines=\"${lines}\""

  echo
  echo "→ fuzzyMatch evle \"\${lines}\""
  fuzzyMatch "evle" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ fuzzyMatch sh2 \"\${lines}\""
  fuzzyMatch "sh2" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "# should prioritize lower index of u"
  echo "→ fuzzyMatch u \"\${lines}\""
  fuzzyMatch "u" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "# should be the first equal match"
  echo "→ fuzzyMatch showcase \"\${lines}\""
  fuzzyMatch "showcase" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "# should prioritize lower distance between letters"
  echo "→ fuzzyMatch lubl \"\${lines}\""
  fuzzyMatch "lubl" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing fuzzyMatch" 0
}

function testGetOsName() {
  echo "→ OSTYPE=linux-bsd getOsName"
  OSTYPE=linux-bsd getOsName && echo "${LAST_RETURNED_VALUE}"
  echo
  echo "→ OSTYPE=msys getOsName"
  OSTYPE=msys getOsName && echo "${LAST_RETURNED_VALUE}"
  echo
  echo "→ OSTYPE=darwin-stuff getOsName"
  OSTYPE=darwin-stuff getOsName && echo "${LAST_RETURNED_VALUE}"
  echo
  echo "→ OSTYPE=nop getOsName"
  OSTYPE=nop getOsName && echo "${LAST_RETURNED_VALUE}"
  echo
  endTest "Testing getOsName" 0
}

function main() {
  testWrapText
  testCutF
  testFuzzyMatch
  testGetOsName
}

main