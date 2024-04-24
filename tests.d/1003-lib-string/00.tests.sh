#!/usr/bin/env bash

# shellcheck source=../../valet.d/lib-string
source string

function testString::bumpSemanticVersion() {

  echo "→ bumping 0.0.0 minor"
  string::bumpSemanticVersion "0.0.0" "minor" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 major"
  string::bumpSemanticVersion "1.2.3-alpha+zae345" "major" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 minor"
  string::bumpSemanticVersion "1.2.3-alpha+zae345" "minor" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 patch"
  string::bumpSemanticVersion "1.2.3-alpha+zae345" "patch" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 major false"
  string::bumpSemanticVersion "1.2.3-alpha+zae345" "major" "false" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha patch false"
  string::bumpSemanticVersion "1.2.156-alpha" "patch" "false" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing string::bumpSemanticVersion" 0
}

function testString::camelCaseToSnakeCase() {

  echo "→ string::camelCaseToSnakeCase thisIsATest0"
  string::camelCaseToSnakeCase thisIsATest0 && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ string::camelCaseToSnakeCase AnotherTest"
  string::camelCaseToSnakeCase AnotherTest && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing string::camelCaseToSnakeCase" 0

}

function testString::kebabCaseToSnakeCase() {

  echo "→ string::kebabCaseToSnakeCase this-is-a-test0"
  string::kebabCaseToSnakeCase this-is-a-test0 && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ string::kebabCaseToSnakeCase --another-test"
  string::kebabCaseToSnakeCase --another-test && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing string::kebabCaseToSnakeCase" 0

}

function testString::kebabCaseToCamelCase() {

  echo "→ string::kebabCaseToCamelCase this-is-a-test0"
  string::kebabCaseToCamelCase this-is-a-test0 && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ string::kebabCaseToCamelCase --another-test"
  string::kebabCaseToCamelCase --another-test && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing string::kebabCaseToCamelCase" 0

}

function testString::trimAll() {

  echo "→ string::trimAll '  a  super test  '"
  string::trimAll '  a  super test  ' && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ string::trimAll 'this is a command  '"
  string::trimAll 'this is a command  ' && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing string::trimAll" 0

}

function testString::cutField() {
  echo "→ string::cutField \"field1 field2 field3\" 1 \" \""
  string::cutField "field1 field2 field3" 0 " " && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ string::cutField \"field1 field2 field3\" 2 \" \""
  string::cutField "field1 field2 field3" 1 " " && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ string::cutField \"field1 field2 field3\" 3 \" \""
  string::cutField "field1 field2 field3" 2 " " && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ string::cutField \"field1 field2 field3\" 4 \" \""
  string::cutField "field1 field2 field3" 3 " " && echo "${LAST_RETURNED_VALUE}"
  echo

  echo "→ string::cutField \"line1 hm I wonder
line2 does it work on lines?
line3 seems so\" 2 \$'\n'"
  string::cutField "line1 hm I wonder
line2 does it work on lines?
line3 seems so" 2 $'\n' && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing string::cutField" 0
}


function testString::indexOf() {
  echo "→ string::indexOf 'hello' 'l'"
  string::indexOf 'hello' 'l' && echo "2=${LAST_RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'hello' 'he'"
  string::indexOf 'hello' 'he' && echo "0=${LAST_RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'hello' 'he' 10"
  string::indexOf 'hello' 'he' 10 && echo "-1=${LAST_RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'yesyes' 'ye' 1"
  string::indexOf 'yesyes' 'ye' 1 && echo "3=${LAST_RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'yesyes' 'yes' 3"
  string::indexOf 'yesyes' 'yes' 3 && echo "3=${LAST_RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'yesyes' 'yes' 5"
  string::indexOf 'yesyes' 'yes' 5 && echo "-1=${LAST_RETURNED_VALUE}"
  echo
  endTest "Testing string::indexOf function" 0
}

# This function test the string::extractBetween function
function testString::extractBetween() {
  echo "→ string::extractBetween 'hello' 'e' 'o'"
  string::extractBetween 'hello' 'e' 'o' && echo "ll=⌈${LAST_RETURNED_VALUE}⌉"
  echo
  echo "→ string::extractBetween 'hello' '' 'l'"
  string::extractBetween 'hello' '' 'l' && echo "he=⌈${LAST_RETURNED_VALUE}⌉"
  echo
  echo "→ string::extractBetween 'hello' 'e' ''"
  string::extractBetween 'hello' 'e' '' && echo "llo=⌈${LAST_RETURNED_VALUE}⌉"
  echo
  echo "→ string::extractBetween 'hello' 'a' ''"
  string::extractBetween 'hello' 'a' '' && echo "=⌈${LAST_RETURNED_VALUE}⌉"
  echo
  echo "→ string::extractBetween 'hello' 'h' 'a'"
  string::extractBetween 'hello' 'h' 'a' && echo "=⌈${LAST_RETURNED_VALUE}⌉"

  local multilinetext="1 line one
2 line two
3 line three
4 line four"
  echo
  echo "multilinetext=\"${multilinetext}\""
  echo
  echo "→ string::extractBetween \"\${multilinetext}\" \"one\"\$'\n' '4'"
  string::extractBetween "${multilinetext}" "one"$'\n' '4' && echo "line 2 and 3=⌈${LAST_RETURNED_VALUE}⌉"
  echo
  echo "→ string::extractBetween \"\${multilinetext}\" \"2 \" \$'\n'"
  string::extractBetween "${multilinetext}" "2 " $'\n' && echo "line two=⌈${LAST_RETURNED_VALUE}⌉"

  endTest "Testing string::extractBetween function" 0
}

function testString::count() {
  echo "→ string::count 'name,firstname,address' ','"
  string::count 'name,firstname,address' ',' && echo "2=${LAST_RETURNED_VALUE}"
  echo
  echo "→ string::count 'bonjour mon bon ami, bonne journée!' 'bo'"
  string::count 'bonjour mon bon ami, bonne journée!' 'bo' && echo "3=${LAST_RETURNED_VALUE}"

  endTest "Testing string::count function" 0
}

function testString::split() {
  local IFS=$'\n'

  echo "→ string:::split 'name:firstname:address' ':'"
  string::split "name:firstname:address" ":" && echo "${LAST_RETURNED_ARRAY[*]}"
  echo
  echo "→ string::split 'one:two:three' '\\n'"
  string::split "one"$'\n'"two"$'\n'"three" $'\n' && echo "${LAST_RETURNED_ARRAY[*]}"

  endTest "Testing string::split function" 0
}

function main() {
  testString::bumpSemanticVersion
  testString::kebabCaseToSnakeCase
  testString::kebabCaseToSnakeCase
  testString::kebabCaseToCamelCase
  testString::trimAll
  testString::cutField
  testString::indexOf
  testString::extractBetween
  testString::count
  testString::split
}

main