#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-string
source string

function testString::bumpSemanticVersion() {

  echo "→ bumping 0.0.0 minor"
  string::bumpSemanticVersion "0.0.0" "minor" && echo "${RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 major"
  string::bumpSemanticVersion "1.2.3-alpha+zae345" "major" && echo "${RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 minor"
  string::bumpSemanticVersion "1.2.3-alpha+zae345" "minor" && echo "${RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 patch"
  string::bumpSemanticVersion "1.2.3-alpha+zae345" "patch" && echo "${RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 major false"
  string::bumpSemanticVersion "1.2.3-alpha+zae345" "major" "false" && echo "${RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha patch false"
  string::bumpSemanticVersion "1.2.156-alpha" "patch" "false" && echo "${RETURNED_VALUE}"

  echo
  echo "→ bumping aze patch false"
  (string::bumpSemanticVersion "aze" "patch" "false") || echo "Failed as expected"

  test::endTest "Testing string::bumpSemanticVersion" 0
}

function testString::camelCaseToSnakeCase() {

  echo "→ string::camelCaseToSnakeCase thisIsATest0"
  string::camelCaseToSnakeCase thisIsATest0 && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::camelCaseToSnakeCase AnotherTest"
  string::camelCaseToSnakeCase AnotherTest && echo "${RETURNED_VALUE}"

  test::endTest "Testing string::camelCaseToSnakeCase" 0

}

function testString::kebabCaseToSnakeCase() {

  echo "→ string::kebabCaseToSnakeCase this-is-a-test0"
  string::kebabCaseToSnakeCase this-is-a-test0 && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::kebabCaseToSnakeCase --another-test"
  string::kebabCaseToSnakeCase --another-test && echo "${RETURNED_VALUE}"

  test::endTest "Testing string::kebabCaseToSnakeCase" 0

}

function testString::kebabCaseToCamelCase() {

  echo "→ string::kebabCaseToCamelCase this-is-a-test0"
  string::kebabCaseToCamelCase this-is-a-test0 && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::kebabCaseToCamelCase --another-test"
  string::kebabCaseToCamelCase --another-test && echo "${RETURNED_VALUE}"

  test::endTest "Testing string::kebabCaseToCamelCase" 0

}

function testString::trimAll() {

  echo "→ string::trimAll '  a  super test  '"
  string::trimAll '  a  super test  ' && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::trimAll 'this is a command  '"
  string::trimAll 'this is a command  ' && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::trimAll '\t\nthis is a \tcommand  '"
  string::trimAll $'\t\n''this is a '$'\t''command  ' && echo "${RETURNED_VALUE}"

  test::endTest "Testing string::trimAll" 0

}

function testString::cutField() {
  echo "→ string::cutField \"field1 field2 field3\" 1 \" \""
  string::cutField "field1 field2 field3" 0 " " && echo "${RETURNED_VALUE}"
  echo

  echo "→ string::cutField \"field1 field2 field3\" 2 \" \""
  string::cutField "field1 field2 field3" 1 " " && echo "${RETURNED_VALUE}"
  echo

  echo "→ string::cutField \"field1 field2 field3\" 3 \" \""
  string::cutField "field1 field2 field3" 2 " " && echo "${RETURNED_VALUE}"
  echo

  echo "→ string::cutField \"field1 field2 field3\" 4 \" \""
  string::cutField "field1 field2 field3" 3 " " && echo "${RETURNED_VALUE}"
  echo

  echo "→ string::cutField \"line1 hm I wonder
line2 does it work on lines?
line3 seems so\" 2 \$'\n'"
  string::cutField "line1 hm I wonder
line2 does it work on lines?
line3 seems so" 2 $'\n' && echo "${RETURNED_VALUE}"

  test::endTest "Testing string::cutField" 0
}


function testString::indexOf() {
  echo "→ string::indexOf 'hello' 'l'"
  string::indexOf 'hello' 'l' && echo "2=${RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'hello' 'he'"
  string::indexOf 'hello' 'he' && echo "0=${RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'hello' 'he' 10"
  string::indexOf 'hello' 'he' 10 && echo "-1=${RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'yesyes' 'ye' 1"
  string::indexOf 'yesyes' 'ye' 1 && echo "3=${RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'yesyes' 'yes' 3"
  string::indexOf 'yesyes' 'yes' 3 && echo "3=${RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'yesyes' 'yes' 5"
  string::indexOf 'yesyes' 'yes' 5 && echo "-1=${RETURNED_VALUE}"
  echo
  test::endTest "Testing string::indexOf function" 0
}

# This function test the string::extractBetween function
function testString::extractBetween() {
  echo "→ string::extractBetween 'hello' 'e' 'o'"
  string::extractBetween 'hello' 'e' 'o' && echo "ll=⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::extractBetween 'hello' '' 'l'"
  string::extractBetween 'hello' '' 'l' && echo "he=⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::extractBetween 'hello' 'e' ''"
  string::extractBetween 'hello' 'e' '' && echo "llo=⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::extractBetween 'hello' 'a' ''"
  string::extractBetween 'hello' 'a' '' && echo "=⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::extractBetween 'hello' 'h' 'a'"
  string::extractBetween 'hello' 'h' 'a' && echo "=⌜${RETURNED_VALUE}⌝"

  local multilinetext="1 line one
2 line two
3 line three
4 line four"
  echo
  echo "multilinetext=\"${multilinetext}\""
  echo
  echo "→ string::extractBetween \"\${multilinetext}\" \"one\"\$'\n' '4'"
  string::extractBetween "${multilinetext}" "one"$'\n' '4' && echo "line 2 and 3=⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::extractBetween \"\${multilinetext}\" \"2 \" \$'\n'"
  string::extractBetween "${multilinetext}" "2 " $'\n' && echo "line two=⌜${RETURNED_VALUE}⌝"

  test::endTest "Testing string::extractBetween function" 0
}

function testString::count() {
  echo "→ string::count 'name,firstname,address' ','"
  string::count 'name,firstname,address' ',' && echo "2=${RETURNED_VALUE}"
  echo
  echo "→ string::count 'bonjour mon bon ami, bonne journée!' 'bo'"
  string::count 'bonjour mon bon ami, bonne journée!' 'bo' && echo "3=${RETURNED_VALUE}"

  test::endTest "Testing string::count function" 0
}

function testString::split() {
  local IFS=$'\n'

  echo "→ string:::split 'name:firstname:address' ':'"
  string::split "name:firstname:address" ":" && echo "${RETURNED_ARRAY[*]}"
  echo
  echo "→ string::split 'one:two:three' '\\n'"
  string::split "one"$'\n'"two"$'\n'"three" $'\n' && echo "${RETURNED_ARRAY[*]}"

  test::endTest "Testing string::split function" 0
}

function testString::regexGetFirst() {
  echo "→ string::regexGetFirst 'name: julien' 'name:[[:space:]]*([[:alnum:]]*)'"
  string::regexGetFirst 'name: julien' 'name:[[:space:]]*([[:alnum:]]*)'
  echo "${RETURNED_VALUE}"

  test::endTest "Testing string::regexGetFirst function" 0
}

function testString::trim() {
  echo "→ string::trim '  hello  world  '"
  string::trim '  hello  world  ' && echo "hello  world=⌜${RETURNED_VALUE}⌝"

  echo
  echo "→ string::trim 'hello  '"
  string::trim 'hello  ' ' ' && echo "hello=⌜${RETURNED_VALUE}⌝"

  echo
  echo "→ string::trim '  hello'"
  string::trim '  hello' && echo "hello=⌜${RETURNED_VALUE}⌝"

  echo
  # shellcheck disable=SC2028
  echo "→ string::trim $'\n'$'\t''  hello'$'\n'$'\t'' '"
  string::trim $'\n'$'\t''  hello'$'\n'$'\t'' ' && echo "hello=⌜${RETURNED_VALUE}⌝"

  test::endTest "Testing string::trim function" 0
}

function testString::compareSemanticVersion() {
  echo "→ string::compareSemanticVersion '1.2.3' '1.2.3'"
  string::compareSemanticVersion '1.2.3' '1.2.3' && echo "0=${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '1.2.3-alpha' '1.2.4+az123'"
  string::compareSemanticVersion '1.2.3-alpha' '1.2.4+az123' && echo "-1=${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '1.2.3' '1.2.2'"
  string::compareSemanticVersion '1.2.3' '1.2.2' && echo "1=${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '2.2.3' '1.2.3-alpha'"
  string::compareSemanticVersion '2.2.3' '1.2.3-alpha' && echo "1=${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '1.2.3+a1212' '1.3.3'"
  string::compareSemanticVersion '1.2.3+a1212' '1.3.3' && echo "-1=${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '1.2.3-alpha+a123123' '1.2.3-alpha+123zer'"
  string::compareSemanticVersion '1.2.3-alpha+a123123' '1.2.3-alpha+123zer' && echo "0=${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '1.2a.3' '1.2.3derp'"
  (string::compareSemanticVersion '1.2a.3' '1.2.3derp') || echo "Failed as expected"

  test::endTest "Testing string::compareSemanticVersion function" 0
}

function testString::microsecondsToHuman() {
  local -i ms=$((234 + 1000 * 2 + 1000000 * 3 + 1000000 * 60 * 4 + 1000000 * 60 * 60 * 5))
  echo "→ string::microsecondsToHuman ${ms}"
  string::microsecondsToHuman ${ms} "Hours: %HH
Minutes: %MM
Seconds: %SS
Milliseconds: %LL

Hours: %h
Minutes: %m
Seconds: %s
Milliseconds: %l
Microseconds: %u

Total minutes: %M
Total seconds: %S
Total milliseconds: %L
Total microseconds: %U"
  echo "${RETURNED_VALUE}"

  echo
  echo "→ string::microsecondsToHuman ${ms}"
  string::microsecondsToHuman ${ms}
  echo "${RETURNED_VALUE}"

  echo
  echo "→ _OPTION_FORMAT='%U' string::microsecondsToHuman ${ms}"
  _OPTION_FORMAT='%U' string::microsecondsToHuman ${ms}
  echo "${RETURNED_VALUE}"

  test::endTest "Testing string::microsecondsToHuman function" 0
}


function test_string::fitStringInScreen() {
  _PROMPT_STRING_WIDTH=5
  echo "_PROMPT_STRING_WIDTH=${_PROMPT_STRING_WIDTH}"

  test_string_fitStringInScreen 5 ""       0 "" 0
  test_string_fitStringInScreen 5 "a"      1 "a" 1
  test_string_fitStringInScreen 5 "ab"     2 "ab" 2
  test_string_fitStringInScreen 5 "abc"    3 "abc" 3
  test_string_fitStringInScreen 5 "abcd"   4 "abcd" 4
  test_string_fitStringInScreen 5 "abcde"  0 "abcde" 0
  test_string_fitStringInScreen 5 "abcdef" 4 "…cdef" 3
  test_string_fitStringInScreen 5 "abcdef" 3 "abcd…" 3
  test_string_fitStringInScreen 5 "abcdef" 1 "abcd…" 1
  #                                               012345

  test_string_fitStringInScreen 5 "abcde"  5 "…cde" 4
  test_string_fitStringInScreen 5 "abcdef" 6 "…def" 4
  test_string_fitStringInScreen 5 "abcdef" 5 "…cdef" 4
  test_string_fitStringInScreen 5 "abcdef" 4 "…cdef" 3
  test_string_fitStringInScreen 5 "abcdef" 3 "abcd…" 3
  #                                               012345
  test_string_fitStringInScreen 5 "abcdefghij" 6 "…efg…" 3
  #                                               0123456789
  #                                               012345
  test_string_fitStringInScreen 5 "abcdefghij" 3 "abcd…" 3
  test_string_fitStringInScreen 5 "abcdefghij" 4 "…cde…" 3
  test_string_fitStringInScreen 5 "abcdefghij" 5 "…def…" 3

  test_string_fitStringInScreen 10 "This is a long string that will be displayed in the screen." 20 "…g string…" 8

  _PROMPT_STRING_WIDTH=4
  echo "_PROMPT_STRING_WIDTH=${_PROMPT_STRING_WIDTH}"
  test_string_fitStringInScreen 4 "bl" 0 "bl" 0
  test::endTest "Testing string::fitStringInScreen" 0
}

function test_string_fitStringInScreen() {
  echo "string::fitStringInScreen '${2}' '${3}' '${1}'"
  string::fitStringInScreen "${2}" "${3}" "${1}"
  echo " ░${RETURNED_VALUE}░ ${RETURNED_VALUE2}"

  if [[ "░${RETURNED_VALUE}░ ${RETURNED_VALUE2}" != "░${4}░ ${5}" ]]; then
    echo "Expected: ░${4}░ ${5}"
    exit 1
  fi
}

function test_string::truncateVisibleCharacters() {
  local FG_CYAN=$'\033[36m'
  local FG_RESET=$'\033[0m'

  echo "string::truncateVisibleCharacters '\${AC__FG_CYAN}Hello\${AC__FG_RESET}world' 5"
  string::truncateVisibleCharacters "${FG_CYAN}Hello${FG_RESET} world" 5
  echo "${RETURNED_VALUE}"
  echo
  echo "string::truncateVisibleCharacters '\${AC__FG_CYAN}Hello\${AC__FG_RESET}world' 10"
  string::truncateVisibleCharacters "${FG_CYAN}Hello${FG_RESET} world" 10
  echo "${RETURNED_VALUE}"
  echo
  echo "string::truncateVisibleCharacters '\${AC__FG_CYAN}Hello\${AC__FG_RESET}world' 11"
  string::truncateVisibleCharacters "${FG_CYAN}Hello${FG_RESET} world" 11
  echo "${RETURNED_VALUE}"
  echo
  echo "string::truncateVisibleCharacters '\${AC__FG_CYAN}Hello\${AC__FG_RESET}world' 12"
  string::truncateVisibleCharacters "${FG_CYAN}Hello${FG_RESET} world" 12
  echo "${RETURNED_VALUE}"
  echo
  echo "string::truncateVisibleCharacters '[7m[35md[27m[39m[7m[35mi[27m[39msable the [93mmonitor mode to avoid[39m the \"Terminated\" message with exit code once the spinner is stopped' 71"
  string::truncateVisibleCharacters '[7m[35md[27m[39m[7m[35mi[27m[39msable the [93mmonitor mode to avoid[39m the "Terminated" message with exit code once the spinner is stopped' 71
  echo "${RETURNED_VALUE}"
  echo

  test::endTest "Testing string::truncateVisibleCharacters" 0
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
  testString::regexGetFirst
  testString::trim
  testString::compareSemanticVersion
  testString::microsecondsToHuman
  test_string::fitStringInScreen
  test_string::truncateVisibleCharacters
}

main