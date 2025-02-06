#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-string
source string

function main() {
  test_string::getField
  test_string::convertCamelCaseToSnakeCase
  test_string::convertKebabCaseToSnakeCase
  test_string::convertKebabCaseToCamelCase
  test_string::trimAll
  test_string::trimEdges
  test_string::getIndexOf
  test_string::extractBetween
  test_string::count
  test_string::split
  test_string::wrapWords
  test_string::wrapCharacters
  test_string::highlight
  test_string::head
  test_string::doForEachLine
}

function test_string::doForEachLine() {
  test::title "✅ Testing string::doForEachLine"

  function forEachLine() {
    echo "Line: '${1}'"
  }

  test::func string::doForEachLine MULTI_LINES_TEXT3 forEachLine
}

function test_string::getField() {
  test::title "✅ Testing string::getField"

  local str='field1 field2 field3'
  test::printVars "str"
  test::func string::getField str 0 ' '
  test::func string::getField str 1 ' '
  test::func string::getField str 2 ','
  test::func string::getField str 4 ','

  # shellcheck disable=SC2034
  str="line1 hm I wonder"$'\n'"line2 does it work on lines?"$'\n'"line3 seems so"
  test::printVars "str"
  test::func string::getField str 2 $'\n'
}

function test_string::convertCamelCaseToSnakeCase() {
  test::title "✅ Testing string::convertCamelCaseToSnakeCase"

  test::func str="thisIsATest0" string::convertCamelCaseToSnakeCase str
  test::func str="AnotherTest" string::convertCamelCaseToSnakeCase str

}

function test_string::convertKebabCaseToSnakeCase() {
  test::title "✅ Testing string::convertKebabCaseToSnakeCase"

  test::func str="this-is-a-test0" string::convertKebabCaseToSnakeCase str
  test::func str="--another-test" string::convertKebabCaseToSnakeCase str

}

function test_string::convertKebabCaseToCamelCase() {
  test::title "✅ Testing string::convertKebabCaseToCamelCase"

  test::func str="this-is-a-test0" string::convertKebabCaseToCamelCase str
  test::func str="--another-test" string::convertKebabCaseToCamelCase str
  test::func str="--anotherTest" string::convertKebabCaseToCamelCase str
  test::func str="--last--" string::convertKebabCaseToCamelCase str
}

function test_string::trimAll() {
  test::title "✅ Testing string::trimAll"

  test::doInPlaceChanges string::trimAll '  a  super test  '
  test::doInPlaceChanges string::trimAll 'this is a command  '
  test::doInPlaceChanges string::trimAll $'\t\n''this is a '$'\t''command  '

}

function test_string::trimEdges() {
  test::title "✅ Testing string::trimEdges"

  test::doInPlaceChanges string::trimEdges '  hello  world  '
  test::doInPlaceChanges string::trimEdges 'hello  ' ' '
  test::doInPlaceChanges string::trimEdges '  hello'
  test::doInPlaceChanges string::trimEdges $'\n'$'\t''  hello'$'\n'$'\t'' '
}

function test_string::getIndexOf() {
  test::title "✅ Testing string::getIndexOf function"

  test::func str='hello' string::getIndexOf str 'l'
  test::func str='hello' string::getIndexOf str 'he'
  test::func str='hello' string::getIndexOf str 'he' 10
  test::func str='yes-yes' string::getIndexOf str 'ye' 1
  test::func str='yes-yes' string::getIndexOf str 'yes' 5
}

function test_string::extractBetween() {
  test::title "✅ Testing string::extractBetween function"

  test::func str='hello' string::extractBetween str 'e' 'o'
  test::func str='hello' string::extractBetween str 'e' ''
  test::func str='hello' string::extractBetween str 'h' 'a'

  test::printVars MULTI_LINES_TEXT2
  test::func string::extractBetween MULTI_LINES_TEXT2 "one"$'\n' '4'
  test::func string::extractBetween MULTI_LINES_TEXT2 "2 " $'\n'
}

function test_string::count() {
  test::title "✅ Testing string::count function"

  test::func str='name,firstname,address' string::count str ','
  test::func str='bonjour mon bon ami, bonne journée!' string::count str 'bo'
}

function test_string::split() {
  test::title "✅ Testing string::split function"

  test::func str="name:firstname:address" string::split str ":"
  test::func str="one:two,three" string::split str ":,"
}

function test_string::wrapWords() {
  test::title "✅ Testing string::wrapWords"

  test::markdown "Wrapping text at column 30 with no padding"
  test::func string::wrapWords "\"\${MULTI_LINES_TEXT}\"" 30

  test::markdown "Wrapping text at column 50 with padding of 4 on new lines"
  test::func string::wrapWords "\"\${MULTI_LINES_TEXT}\"" 50 '    '

  test::markdown "Wrapping text at column 20 with padding of 3 on all lines"
  test::func string::wrapWords "\"\${MULTI_LINES_TEXT}\"" 20 '   ' 17

  test::markdown "Wrapping words, shortcut because the message is a short single line"
  test::func string::wrapWords 'A message.' 80

  test::markdown "Wrapping words, no shortcut!"
  test::func string::wrapWords 'A message.' 80 '' 5

  test::markdown "Wrapping words"
  test::func string::wrapWords 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10
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
  test::func string::head MULTI_LINES_TEXT2 2

  test::markdown "Testing string::head with 0 line"
  test::func string::head MULTI_LINES_TEXT2 0

  test::markdown "Testing string::head with 10 lines"
  test::func string::head MULTI_LINES_TEXT2 10
}

function test::doInPlaceChanges() {
  # shellcheck disable=SC2034
  MY_STRING="${2}"
  test::printVars MY_STRING
  test::exec "${1}" MY_STRING
  test::printVars MY_STRING
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

# shellcheck disable=SC2034
MULTI_LINES_TEXT3="1 line one

3 line three
4 line four"

main