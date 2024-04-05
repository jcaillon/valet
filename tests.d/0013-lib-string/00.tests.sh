#!/usr/bin/env bash

include string

function testBumpSemanticVersion() {

  echo "→ bumping 0.0.0 minor"
  bumpSemanticVersion "0.0.0" "minor" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 major"
  bumpSemanticVersion "1.2.3-alpha+zae345" "major" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 minor"
  bumpSemanticVersion "1.2.3-alpha+zae345" "minor" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 patch"
  bumpSemanticVersion "1.2.3-alpha+zae345" "patch" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 major false"
  bumpSemanticVersion "1.2.3-alpha+zae345" "major" "false" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha patch false"
  bumpSemanticVersion "1.2.156-alpha" "patch" "false" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing bumpSemanticVersion" 0
}

function testCamelCaseToSnakeCase() {

  echo "→ camelCaseToSnakeCase thisIsATest0"
  camelCaseToSnakeCase thisIsATest0 && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ camelCaseToSnakeCase AnotherTest"
  camelCaseToSnakeCase AnotherTest && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing camelCaseToSnakeCase" 0

}

function testKebabCaseToSnakeCase() {

  echo "→ kebabCaseToSnakeCase this-is-a-test0"
  kebabCaseToSnakeCase this-is-a-test0 && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ kebabCaseToSnakeCase --another-test"
  kebabCaseToSnakeCase --another-test && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing kebabCaseToSnakeCase" 0

}

function testKebabCaseToCamelCase() {

  echo "→ kebabCaseToCamelCase this-is-a-test0"
  kebabCaseToCamelCase this-is-a-test0 && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ kebabCaseToCamelCase --another-test"
  kebabCaseToCamelCase --another-test && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing kebabCaseToCamelCase" 0

}

function testTrimAll() {

  echo "→ trimAll '  a  super test  '"
  trimAll '  a  super test  ' && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ trimAll 'this is a command  '"
  trimAll 'this is a command  ' && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing trimAll" 0

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
  extractBetween 'hello' 'e' 'o' && echo "ll=⌈${LAST_RETURNED_VALUE}⌉"
  echo
  echo "→ extractBetween 'hello' '' 'l'"
  extractBetween 'hello' '' 'l' && echo "he=⌈${LAST_RETURNED_VALUE}⌉"
  echo
  echo "→ extractBetween 'hello' 'e' ''"
  extractBetween 'hello' 'e' '' && echo "llo=⌈${LAST_RETURNED_VALUE}⌉"
  echo
  echo "→ extractBetween 'hello' 'a' ''"
  extractBetween 'hello' 'a' '' && echo "=⌈${LAST_RETURNED_VALUE}⌉"
  echo
  echo "→ extractBetween 'hello' 'h' 'a'"
  extractBetween 'hello' 'h' 'a' && echo "=⌈${LAST_RETURNED_VALUE}⌉"

  local multilinetext="1 line one
2 line two
3 line three
4 line four"
  echo
  echo "multilinetext=\"${multilinetext}\""
  echo
  echo "→ extractBetween \"\${multilinetext}\" \"one\"\$'\n' '4'"
  extractBetween "${multilinetext}" "one"$'\n' '4' && echo "line 2 and 3=⌈${LAST_RETURNED_VALUE}⌉"
  echo
  echo "→ extractBetween \"\${multilinetext}\" \"2 \" \$'\n'"
  extractBetween "${multilinetext}" "2 " $'\n' && echo "line two=⌈${LAST_RETURNED_VALUE}⌉"

  endTest "Testing extractBetween function" 0
}

function main() {
  testBumpSemanticVersion
  testKebabCaseToSnakeCase
  testKebabCaseToSnakeCase
  testKebabCaseToCamelCase
  testTrimAll
  testCutF
  testIndexOf
  testExtractBetween
}

main