#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-string
source string

function main() {
  test_string::cutField
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
  test_string::head
}

function test_string::cutField() {
  test::title "✅ Testing string::cutField"

  test::func string::cutField 'field1 field2 field3' 0 ' '
  test::func string::cutField 'field1 field2 field3' 1 ' '
  test::func string::cutField 'field1,field2,field3' 2 ','
  test::func string::cutField 'field1,field2,field3' 4 ','
  test::func string::cutField "line1 hm I wonder
line2 does it work on lines?
line3 seems so" 2 $'\n'
}

function test_string::camelCaseToSnakeCase() {
  test::title "✅ Testing string::camelCaseToSnakeCase"

  test::func string::camelCaseToSnakeCase thisIsATest0
  test::func string::camelCaseToSnakeCase AnotherTest

}

function test_string::kebabCaseToSnakeCase() {
  test::title "✅ Testing string::kebabCaseToSnakeCase"

  test::func string::kebabCaseToSnakeCase this-is-a-test0
  test::func string::kebabCaseToSnakeCase --another-test

}

function test_string::kebabCaseToCamelCase() {
  test::title "✅ Testing string::kebabCaseToCamelCase"

  test::func string::kebabCaseToCamelCase this-is-a-test0
  test::func string::kebabCaseToCamelCase --another-test
  test::func string::kebabCaseToCamelCase --last--
}

function test_string::trimAll() {
  test::title "✅ Testing string::trimAll"

  test::func string::trimAll '  a  super test  '
  test::func string::trimAll 'this is a command  '
  test::func string::trimAll $'\t\n''this is a '$'\t''command  '

}

function test_string::trim() {
  test::title "✅ Testing string::trim"

  test::func string::trim '  hello  world  '
  test::func string::trim 'hello  ' ' '
  test::func string::trim '  hello'
  test::func string::trim $'\n'$'\t''  hello'$'\n'$'\t'' '
}

function test_string::indexOf() {
  test::title "✅ Testing string::indexOf function"

  test::func string::indexOf 'hello' 'l'
  test::func string::indexOf 'hello' 'he'
  test::func string::indexOf 'hello' 'he' 10
  test::func string::indexOf 'yes-yes' 'ye' 1
  test::func string::indexOf 'yes-yes' 'yes' 5
}

function test_string::extractBetween() {
  test::title "✅ Testing string::extractBetween function"

  test::func string::extractBetween 'hello' 'e' 'o'
  test::func string::extractBetween 'hello' 'e' ''
  test::func string::extractBetween 'hello' 'h' 'a'

  test::printVars MULTI_LINES_TEXT2
  test::func string::extractBetween "\"\${MULTI_LINES_TEXT2}\"" "one"$'\n' '4'
  test::func string::extractBetween "\"\${MULTI_LINES_TEXT2}\"" "2 " $'\n'
}

function test_string::count() {
  test::title "✅ Testing string::count function"

  test::func string::count 'name,firstname,address' ','
  test::func string::count 'bonjour mon bon ami, bonne journée!' 'bo'
}

function test_string::split() {
  test::title "✅ Testing string::split function"

  test::func string::split "name:firstname:address" ":"
  test::func string::split "one"$'\n'"two"$'\n'"three" $'\n'
}

function test_string::regexGetFirst() {
  test::title "✅ Testing string::regexGetFirst function"

  test::func string::regexGetFirst 'name: julien' "'name:[[:space:]]*([[:alnum:]]*)'"
}

function test_string::microsecondsToHuman() {
  test::title "✅ Testing string::microsecondsToHuman function"

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
  test::printVars format
  test::func string::microsecondsToHuman ${ms} "\"\${format}\""
  test::func string::microsecondsToHuman ${ms}
  test::func _OPTION_FORMAT='%U' string::microsecondsToHuman ${ms}
}

function test_string::wrapText() {
  test::title "✅ Testing string::wrapText"

  test::markdown "Wrapping text at column 30 with no padding"
  test::func string::wrapText "\"\${MULTI_LINES_TEXT}\"" 30

  test::markdown "Wrapping text at column 50 with padding of 4 on new lines"
  test::func string::wrapText "\"\${MULTI_LINES_TEXT}\"" 50 '    '

  test::markdown "Wrapping text at column 20 with padding of 3 on all lines"
  test::func string::wrapText "\"\${MULTI_LINES_TEXT}\"" 20 '   ' 17

  test::markdown "Wrapping words, shortcut because the message is a short single line"
  test::func string::wrapText 'A message.' 80

  test::markdown "Wrapping words, no shortcut!"
  test::func string::wrapText 'A message.' 80 '' 5

  test::markdown "Wrapping words"
  test::func string::wrapText 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10
}

function test_string::wrapCharacters() {
  test::title "✅ Testing string::wrapCharacters"

  test::markdown  "Wrapping characters at column 20 with padding of 3 on all lines"
  test::func string::wrapCharacters "\"\${MULTI_LINES_TEXT}\"" 20 "   " 17

  test::markdown "Wrapping characters at 20, no other options"
  test::func string::wrapCharacters "\"\${MULTI_LINES_TEXT}\"" 20

  test::markdown "Wrapping characters"
  test::func string::wrapCharacters 01234567890123456789234 17 '   ' 1

  test::markdown "Wrapping characters"
  test::func string::wrapCharacters 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10

  test::markdown "Wrapping characters, spaces at the beginning of the line are kept"
  test::func string::wrapCharacters '  Start With spaces that must be kept! Other spaces can be ignored at wrapping.'$'\n''  Also start with spaces' 17 '   ' 14
}

function test_string::highlight() {
  test::title "✅ Testing string::highlight"

  test::func string::highlight 'This is a Text to highlight.' 'ttttt'
  test::func string::highlight 'This is a texT to highlight.' 'TTTTT' "'>'" "'<'"
  test::func string::highlight '' 'ttttt'
  test::func string::highlight 'This is a text to highlight.' ''
}

function test_string::head() {
  test::title "✅ Testing string::head"

  test::printVars MULTI_LINES_TEXT2

  test::markdown "Testing string::head with 2 lines"
  test::func string::head "\"\${MULTI_LINES_TEXT2}\"" 2

  test::markdown "Testing string::head with 0 line"
  test::func string::head "\"\${MULTI_LINES_TEXT2}\"" 0

  test::markdown "Testing string::head with 10 lines"
  test::func string::head "\"\${MULTI_LINES_TEXT2}\"" 10
}

# shellcheck disable=SC2034
# shellcheck disable=SC2016
MULTI_LINES_TEXT='You don`t [36m[36m[36mget better[39m[39m[39m on the days when you feel like going. You get better on the days when you don`t want to go, but you go anyway. If you can [34movercome the negative energy[39m coming from your tired body or unmotivated mind, you will grow and become better. It won`t be the best workout you have, you won`t accomplish as much as what you usually do when you actually feel good, but that doesn`t matter. Growth is a long term game, and the crappy days are more important.

As long as I focus on what I feel and don`t worry about where I`m going, it works out. Having no expectations but being open to everything is what makes wonderful things happen. If I don`t worry, there`s no obstruction and life flows easily. It sounds impractical, but `Expect nothing; be open to everything` is really all it is. 01234567890123456789 on new line 01234567890123456789234 line new line.

https://en.wikipedia.org/wiki/Veganism

There were 2 new lines before this.'

# shellcheck disable=SC2034
MULTI_LINES_TEXT2="1 line one
2 line two
3 line three
4 line four"
main