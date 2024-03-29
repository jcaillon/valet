#!/usr/bin/env bash

function testIndexOf() {
  echo "→ indexOf 'hello' 'l'"
  indexOf 'hello' 'l' && echo "2=${LAST_RETURNED_VALUE}"
  echo
  echo "→ indexOf 'hello' 'he'"
  indexOf 'hello' 'he' && echo "0=${LAST_RETURNED_VALUE}"
  echo
  echo "→ indexOf 'hello' 'he' 10"
  indexOf 'hello' 'he' 10 && echo "-1=${LAST_RETURNED_VALUE}"
  echo
  echo "→ indexOf 'yesyes' 'ye' 1"
  indexOf 'yesyes' 'ye' 1 && echo "3=${LAST_RETURNED_VALUE}"
  echo
  echo "→ indexOf 'yesyes' 'yes' 3"
  indexOf 'yesyes' 'yes' 3 && echo "3=${LAST_RETURNED_VALUE}"
  echo
  echo "→ indexOf 'yesyes' 'yes' 5"
  indexOf 'yesyes' 'yes' 5 && echo "-1=${LAST_RETURNED_VALUE}"
  echo
  endTest "Testing indexOf function" 0
}

# This function test the extractBetween function
function testExtractBetween() {
  echo "→ extractBetween 'hello' 'e' 'o'"
  extractBetween 'hello' 'e' 'o' && echo "ll=⌜${LAST_RETURNED_VALUE}⌝"
  echo
  echo "→ extractBetween 'hello' '' 'l'"
  extractBetween 'hello' '' 'l' && echo "he=⌜${LAST_RETURNED_VALUE}⌝"
  echo
  echo "→ extractBetween 'hello' 'e' ''"
  extractBetween 'hello' 'e' '' && echo "llo=⌜${LAST_RETURNED_VALUE}⌝"
  echo
  echo "→ extractBetween 'hello' 'a' ''"
  extractBetween 'hello' 'a' '' && echo "=⌜${LAST_RETURNED_VALUE}⌝"
  echo
  echo "→ extractBetween 'hello' 'h' 'a'"
  extractBetween 'hello' 'h' 'a' && echo "=⌜${LAST_RETURNED_VALUE}⌝"

  local multilinetext="1 line one
2 line two
3 line three
4 line four"
  echo
  echo "multilinetext=\"$multilinetext\""
  echo
  echo "→ extractBetween \"\$multilinetext\" \"one\"\$'\n' '4'"
  extractBetween "${multilinetext}" "one"$'\n' '4' && echo "line 2 and 3=⌜${LAST_RETURNED_VALUE}⌝"
  echo
  echo "→ extractBetween \"\$multilinetext\" \"2 \" \$'\n'"
  extractBetween "${multilinetext}" "2 " $'\n' && echo "line two=⌜${LAST_RETURNED_VALUE}⌝"

  endTest "Testing extractBetween function" 0
}


function main() {
  testIndexOf
  testExtractBetween
}

main

