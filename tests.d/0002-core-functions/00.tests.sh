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

function testString::fuzzyMatch() {
  local lines="l1 this is a word
l2 very unbelievable
l2 unbelievable
l3 self test-core1
l4 self test-core2
l5 ublievable"

  echo "lines=\"${lines}\""

  echo
  echo "→ string::fuzzyMatch evle \"\${lines}\""
  string::fuzzyMatch "evle" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ string::fuzzyMatch sh2 \"\${lines}\""
  string::fuzzyMatch "sc2" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "# should prioritize lower index of u"
  echo "→ string::fuzzyMatch u \"\${lines}\""
  string::fuzzyMatch "u" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "# should be the first equal match"
  echo "→ string::fuzzyMatch self \"\${lines}\""
  string::fuzzyMatch "self" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "# should prioritize lower distance between letters"
  echo "→ string::fuzzyMatch lubl \"\${lines}\""
  string::fuzzyMatch "lubl" "${lines}" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing string::fuzzyMatch" 0
}

function main() {
  testString::wrapText
  testString::fuzzyMatch
}

main