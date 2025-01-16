#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-string
source string

function test_string::cutField() {
  echo "→ string::cutField 'field1 field2 field3' 0 ' '"
  string::cutField 'field1 field2 field3' 0 ' ' && echo "${RETURNED_VALUE}"
  echo

  echo "→ string::cutField 'field1 field2 field3' 1 ' '"
  string::cutField 'field1 field2 field3' 1 ' ' && echo "${RETURNED_VALUE}"
  echo

  echo "→ string::cutField 'field1,field2,field3' 2 ','"
  string::cutField 'field1,field2,field3' 2 ',' && echo "${RETURNED_VALUE}"
  echo

  echo "→ string::cutField 'field1,field2,field3' 4 ','"
  string::cutField 'field1,field2,field3' 4 ',' && echo "${RETURNED_VALUE}"
  echo

  echo "→ string::cutField 'line1 hm I wonder
line2 does it work on lines?
line3 seems so' 2 \$'\n'"
  string::cutField "line1 hm I wonder
line2 does it work on lines?
line3 seems so" 2 $'\n' && echo "${RETURNED_VALUE}"

  test::endTest "Testing string::cutField" 0
}

function test_string::compareSemanticVersion() {
  echo "→ string::compareSemanticVersion '1.2.3' '1.2.3'"
  string::compareSemanticVersion '1.2.3' '1.2.3' && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '1.2.3-alpha' '1.2.4+az123'"
  string::compareSemanticVersion '1.2.3-alpha' '1.2.4+az123' && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '1.2.3' '1.2.2'"
  string::compareSemanticVersion '1.2.3' '1.2.2' && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '2.2.3' '1.2.3-alpha'"
  string::compareSemanticVersion '2.2.3' '1.2.3-alpha' && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '1.2.3+a1212' '1.3.3'"
  string::compareSemanticVersion '1.2.3+a1212' '1.3.3' && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '1.2.3-alpha+a123123' '1.2.3-alpha+123zer'"
  string::compareSemanticVersion '1.2.3-alpha+a123123' '1.2.3-alpha+123zer' && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::compareSemanticVersion '1.2a.3' '1.2.3derp'"
  (string::compareSemanticVersion '1.2a.3' '1.2.3derp') || echo "Failed as expected"

  test::endTest "Testing string::compareSemanticVersion function" 0
}

function test_string::bumpSemanticVersion() {

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

function test_string::camelCaseToSnakeCase() {

  echo "→ string::camelCaseToSnakeCase thisIsATest0"
  string::camelCaseToSnakeCase thisIsATest0 && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::camelCaseToSnakeCase AnotherTest"
  string::camelCaseToSnakeCase AnotherTest && echo "${RETURNED_VALUE}"

  test::endTest "Testing string::camelCaseToSnakeCase" 0

}

function test_string::kebabCaseToSnakeCase() {

  echo "→ string::kebabCaseToSnakeCase this-is-a-test0"
  string::kebabCaseToSnakeCase this-is-a-test0 && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::kebabCaseToSnakeCase --another-test"
  string::kebabCaseToSnakeCase --another-test && echo "${RETURNED_VALUE}"

  test::endTest "Testing string::kebabCaseToSnakeCase" 0

}

function test_string::kebabCaseToCamelCase() {

  echo "→ string::kebabCaseToCamelCase this-is-a-test0"
  string::kebabCaseToCamelCase this-is-a-test0 && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::kebabCaseToCamelCase --another-test"
  string::kebabCaseToCamelCase --another-test && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::kebabCaseToSnakeCase --last--"
  string::kebabCaseToCamelCase --last-- && echo "${RETURNED_VALUE}"

  test::endTest "Testing string::kebabCaseToCamelCase" 0

}

function test_string::trimAll() {

  echo "→ string::trimAll '  a  super test  '"
  string::trimAll '  a  super test  ' && echo "⌜${RETURNED_VALUE}⌝"

  echo
  echo "→ string::trimAll 'this is a command  '"
  string::trimAll 'this is a command  ' && echo "⌜${RETURNED_VALUE}⌝"

  echo
  echo "→ string::trimAll '\t\nthis is a \tcommand  '"
  string::trimAll $'\t\n''this is a '$'\t''command  ' && echo "⌜${RETURNED_VALUE}⌝"

  test::endTest "Testing string::trimAll" 0

}

function test_string::trim() {
  echo "→ string::trim '  hello  world  '"
  string::trim '  hello  world  ' && echo "⌜${RETURNED_VALUE}⌝"

  echo
  echo "→ string::trim 'hello  '"
  string::trim 'hello  ' ' ' && echo "⌜${RETURNED_VALUE}⌝"

  echo
  echo "→ string::trim '  hello'"
  string::trim '  hello' && echo "⌜${RETURNED_VALUE}⌝"

  echo
  # shellcheck disable=SC2028
  echo "→ string::trim $'\n'$'\t''  hello'$'\n'$'\t'' '"
  string::trim $'\n'$'\t''  hello'$'\n'$'\t'' ' && echo "⌜${RETURNED_VALUE}⌝"

  test::endTest "Testing string::trim function" 0
}

function test_string::indexOf() {
  echo "→ string::indexOf 'hello' 'l'"
  string::indexOf 'hello' 'l' && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'hello' 'he'"
  string::indexOf 'hello' 'he' && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'hello' 'he' 10"
  string::indexOf 'hello' 'he' 10 && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'yesyes' 'ye' 1"
  string::indexOf 'yesyes' 'ye' 1 && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'yesyes' 'yes' 3"
  string::indexOf 'yesyes' 'yes' 3 && echo "${RETURNED_VALUE}"
  echo
  echo "→ string::indexOf 'yesyes' 'yes' 5"
  string::indexOf 'yesyes' 'yes' 5 && echo "${RETURNED_VALUE}"
  echo
  test::endTest "Testing string::indexOf function" 0
}

function test_string::extractBetween() {
  echo "→ string::extractBetween 'hello' 'e' 'o'"
  string::extractBetween 'hello' 'e' 'o' && echo "⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::extractBetween 'hello' '' 'l'"
  string::extractBetween 'hello' '' 'l' && echo "⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::extractBetween 'hello' 'e' ''"
  string::extractBetween 'hello' 'e' '' && echo "⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::extractBetween 'hello' 'a' ''"
  string::extractBetween 'hello' 'a' '' && echo "⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::extractBetween 'hello' 'h' 'a'"
  string::extractBetween 'hello' 'h' 'a' && echo "⌜${RETURNED_VALUE}⌝"

  local multilinetext="1 line one
2 line two
3 line three
4 line four"
  echo
  echo "multilinetext=\"${multilinetext}\""
  echo
  echo "→ string::extractBetween \"\${multilinetext}\" \"one\"\$'\n' '4'"
  string::extractBetween "${multilinetext}" "one"$'\n' '4' && echo "⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::extractBetween \"\${multilinetext}\" \"2 \" \$'\n'"
  string::extractBetween "${multilinetext}" "2 " $'\n' && echo "⌜${RETURNED_VALUE}⌝"

  test::endTest "Testing string::extractBetween function" 0
}

function test_string::count() {
  echo "→ string::count 'name,firstname,address' ','"
  string::count 'name,firstname,address' ',' && echo "⌜${RETURNED_VALUE}⌝"
  echo
  echo "→ string::count 'bonjour mon bon ami, bonne journée!' 'bo'"
  string::count 'bonjour mon bon ami, bonne journée!' 'bo' && echo "⌜${RETURNED_VALUE}⌝"

  test::endTest "Testing string::count function" 0
}

function test_string::split() {
  local IFS=$'\n'

  echo "→ string:::split 'name:firstname:address' ':'"
  string::split "name:firstname:address" ":" && echo "${RETURNED_ARRAY[*]}"
  echo
  echo "→ string::split 'one\\ntwo\\nthree' '\\n'"
  string::split "one"$'\n'"two"$'\n'"three" $'\n' && echo "${RETURNED_ARRAY[*]}"

  test::endTest "Testing string::split function" 0
}

function test_string::regexGetFirst() {
  echo "→ string::regexGetFirst 'name: julien' 'name:[[:space:]]*([[:alnum:]]*)'"
  string::regexGetFirst 'name: julien' 'name:[[:space:]]*([[:alnum:]]*)'
  echo "${RETURNED_VALUE}"

  test::endTest "Testing string::regexGetFirst function" 0
}

function test_string::microsecondsToHuman() {
  local -i ms=$((234 + 1000 * 2 + 1000000 * 3 + 1000000 * 60 * 4 + 1000000 * 60 * 60 * 5))
  local format="Hours: %HH
Minutes: %MM
Seconds: %SS
Milliseconds: %LL
Microseconds: %UU

Hours: %h
Minutes: %m
Seconds: %s
Milliseconds: %l
Microseconds: %u

Total minutes: %M
Total seconds: %S
Total milliseconds: %L
Total microseconds: %U"
  echo "→ string::microsecondsToHuman ${ms} '${format}'"
  string::microsecondsToHuman ${ms} "${format}"
  echo
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

function test_string::wrapText() {
  local shortText="You don't [36m[36m[36mget better[39m[39m[39m on the days when you feel like going. You get better on the days when you don't want to go, but you go anyway. If you can [34movercome the negative energy[39m coming from your tired body or unmotivated mind, you will grow and become better. It won't be the best workout you have, you won't accomplish as much as what you usually do when you actually feel good, but that doesn't matter. Growth is a long term game, and the crappy days are more important.

As long as I focus on what I feel and don't worry about where I'm going, it works out. Having no expectations but being open to everything is what makes wonderful things happen. If I don't worry, there's no obstruction and life flows easily. It sounds impractical, but 'Expect nothing; be open to everything' is really all it is. 01234567890123456789 on new line 01234567890123456789234 line new line.

https://en.wikipedia.org/wiki/Veganism

There were 2 new lines before this."

  echo "→ string::wrapText \"\${shortText}\" 20"
  echo "------------------------------"
  string::wrapText "${shortText}" 20 && echo "${RETURNED_VALUE}"
  test::endTest "Wrapping text at column 30 with no padding" 0

  echo "→ string::wrapText \"\${shortText}\" 90 '    '"
  echo "------------------------------------------------------------------------------------------"
  string::wrapText "${shortText}" 50 '    ' && echo "${RETURNED_VALUE}"
  test::endTest "Wrapping text at column 50 with padding of 4 on new lines" 0

  echo "→ string::wrapText \"\${shortText}\" 90 '  ' 88"
  echo "------------------------------------------------------------------------------------------"
  string::wrapText "${shortText}" 20 '   ' 17 && echo "  $ {RETURNED_VALUE}"
  test::endTest "Wrapping text at column 20 with padding of 3 on all lines" 0

  echo "→ string::wrapText 'A message.' 80"
  string::wrapText 'A message.' 80 && echo "${RETURNED_VALUE}"
  test::endTest "Wrapping words, shortcut because the message is a short single line" 0

  echo "→ string::wrapText 'A message.' 80 '' 5"
  string::wrapText 'A message.' 80 '' 5 && echo "${RETURNED_VALUE}"
  test::endTest "Wrapping words, no shortcut!" 0

  # shellcheck disable=SC2028
  echo "→ string::wrapText 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10"
  string::wrapText 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10 && echo "[36m░░░[0m${RETURNED_VALUE}"
  test::endTest "Wrapping words" 0
}

function test_string::wrapCharacters() {
  local shortText="You don't [36m[36m[36mget better[39m[39m[39m on the days when you feel like going. You get better on the days when you don't want to go, but you go anyway. If you can [34movercome the negative energy[39m coming from your tired body or unmotivated mind, you will grow and become better. It won't be the best workout you have, you won't accomplish as much as what you usually do when you actually feel good, but that doesn't matter. Growth is a long term game, and the crappy days are more important.

As long as I focus on what I feel and don't worry about where I'm going, it works out. Having no expectations but being open to everything is what makes wonderful things happen. If I don't worry, there's no obstruction and life flows easily. It sounds impractical, but 'Expect nothing; be open to everything' is really all it is. 01234567890123456789 on new line 01234567890123456789234 line new line.

https://en.wikipedia.org/wiki/Veganism

There were 2 new lines before this."

  echo "→ string::wrapCharacters \"\${shortText}\" 20 \"   \"" 17
  echo "--------------------"
  string::wrapCharacters "${shortText}" 20 "   " 17 && echo "   ${RETURNED_VALUE}"
  test::endTest "Wrapping characters at column 20 with padding of 3 on all lines" 0

  echo "→ string::wrapCharacters \"\${shortText}\" 20"
  echo "--------------------"
  string::wrapCharacters "${shortText}" 20 && echo "${RETURNED_VALUE}"
  test::endTest "Wrapping characters at 20, no other options" 0

  echo "→ string::wrapCharacters 01234567890123456789234 17 '   ' 1"
  echo "-----------------"
  string::wrapCharacters 01234567890123456789234 17 '   ' 1 && echo "                ${RETURNED_VALUE}"
  test::endTest "Wrapping characters" 0

  # shellcheck disable=SC2028
  echo "→ string::wrapCharacters 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10"
  string::wrapCharacters 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10 && echo "[36m░░░[0m${RETURNED_VALUE}"
  test::endTest "Wrapping characters" 0

  # shellcheck disable=SC2028
  echo "→ string::wrapCharacters '  Start With spaces that must be kept! Other spaces can be ignored at wrapping.'$'\n''  Also start with spaces' 17 '   ' 1"
  echo "-----------------"
  string::wrapCharacters '  Start With spaces that must be kept! Other spaces can be ignored at wrapping.'$'\n''  Also start with spaces' 17 '   ' 14 && echo "   ${RETURNED_VALUE}"
  test::endTest "Wrapping characters, spaces at the beginning of the line are kept" 0
}

function test_string::highlight() {

  echo "→ string::highlight 'This is a text to highlight.' 'ttttt'"
  string::highlight 'This is a Text to highlight.' 'ttttt' && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::highlight 'This is a text to highlight.' 'TTTTT' '>' '<'"
  string::highlight 'This is a texT to highlight.' 'TTTTT' '>' '<' && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::highlight '' 'ttttt'"
  string::highlight '' 'ttttt' && echo "${RETURNED_VALUE}"

  echo
  echo "→ string::highlight 'This is a text to highlight.' ''"
  string::highlight 'This is a text to highlight.' '' && echo "${RETURNED_VALUE}"

  test::endTest "Testing string::highlight" 0
}

function main() {
  test_string::cutField
  test_string::compareSemanticVersion
  test_string::bumpSemanticVersion
  test_string::kebabCaseToSnakeCase
  test_string::kebabCaseToSnakeCase
  test_string::kebabCaseToCamelCase
  test_string::trimAll
  test_string::trim
  test_string::indexOf
  test_string::extractBetween
  test_string::count
  test_string::split
  test_string::regexGetFirst
  test_string::microsecondsToHuman
  test_string::wrapText
  test_string::wrapCharacters
  test_string::highlight
}

main