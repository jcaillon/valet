#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-string
source string

function main() {
  test_string::numberToUniqueId
  test_string::removeTextFormatting
  test_string::convertToHex
  test_string::removeSgrCodes
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

function test_string::numberToUniqueId() {
  test::title "✅ Testing string::numberToUniqueId"

  for i in 0109 345 2000 8976 12003 34567; do
    test::func string::numberToUniqueId "${i}"
  done
}

function test_string::removeTextFormatting() {
  test::title "✅ Testing string::removeTextFormatting"

  local _myString="My text${ESC__BG_RED}${ESC__FG_WHITE} with some ${ESC__TEXT_BOLD}text formatting${ESC__TEXT_RESET} and some more text${ESC__BG_BLUE}${ESC__FG_BRIGHT_CYAN}unreadable stuff${ESC__TEXT_RESET}. Inluding some ${ESC__FG_COLOR_24b__}123;55;255${__ESC__END_COLOR}24 bit colors${ESC__BG_RESET} and some ${ESC__FG_COLOR__}2${__ESC__END_COLOR}8 bit colors${ESC__TEXT_RESET}."
  test::func string::removeTextFormatting _myString
  test::printVars _myString
}

function test_string::convertToHex() {
  test::title "✅ Testing string::convertToHex"

  local _myString="d071ec191f6e98a9c78b6d502c823d8e5adcfdf83d0ea55ebc7f242b29ce8301"
  test::func _myString=d071ec191f6e98a9c78b6d502c823d8e5adcfdf83d0ea55ebc7f242b29ce8301 string::convertToHex _myString
}

function test_string::removeSgrCodes() {
  test::title "✅ Testing string::removeSgrCodes"

  local _myStringWithSgrCodes="w[36mo[107mr[38;2;255;255;255md[38;5;255m!"
  test::exec string::removeSgrCodes _myStringWithSgrCodes
  test::printVars _myStringWithSgrCodes
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

  local _MY_STRING='field1 field2 field3'
  test::printVars "_MY_STRING"
  test::func string::getField _MY_STRING 0 ' '
  test::func string::getField _MY_STRING 1 ' '
  test::func string::getField _MY_STRING 2 ','
  test::func string::getField _MY_STRING 4 ','

  # shellcheck disable=SC2034
  _MY_STRING="line1 hm I wonder"$'\n'"line2 does it work on lines?"$'\n'"line3 seems so"
  test::printVars "_MY_STRING"
  test::func string::getField _MY_STRING 2 $'\n'
}

function test_string::convertCamelCaseToSnakeCase() {
  test::title "✅ Testing string::convertCamelCaseToSnakeCase"

  test::func _MY_STRING="thisIsATest0" string::convertCamelCaseToSnakeCase _MY_STRING
  test::func _MY_STRING="AnotherTest" string::convertCamelCaseToSnakeCase _MY_STRING

}

function test_string::convertKebabCaseToSnakeCase() {
  test::title "✅ Testing string::convertKebabCaseToSnakeCase"

  test::func _MY_STRING="this-is-a-test0" string::convertKebabCaseToSnakeCase _MY_STRING
  test::func _MY_STRING="--another-test" string::convertKebabCaseToSnakeCase _MY_STRING

}

function test_string::convertKebabCaseToCamelCase() {
  test::title "✅ Testing string::convertKebabCaseToCamelCase"

  test::func _MY_STRING="this-is-a-test0" string::convertKebabCaseToCamelCase _MY_STRING
  test::func _MY_STRING="--another-test" string::convertKebabCaseToCamelCase _MY_STRING
  test::func _MY_STRING="--anotherTest" string::convertKebabCaseToCamelCase _MY_STRING
  test::func _MY_STRING="--last--" string::convertKebabCaseToCamelCase _MY_STRING
}

function test_string::trimAll() {
  test::title "✅ Testing string::trimAll"

  test::funcWithString string::trimAll '  a  super test  '
  test::funcWithString string::trimAll 'this is a command  '
  test::funcWithString string::trimAll $'\t\n''this is a '$'\t''command  '

}

function test_string::trimEdges() {
  test::title "✅ Testing string::trimEdges"

  test::funcWithString string::trimEdges '  hello  world  '
  test::funcWithString string::trimEdges '_-_-_hello_-_' _-
  test::funcWithString string::trimEdges '  hello'
  test::funcWithString string::trimEdges $'\n'$'\t''  hello'$'\n'$'\t'' '
}

function test_string::getIndexOf() {
  test::title "✅ Testing string::getIndexOf function"

  test::func _MY_STRING='hello' string::getIndexOf _MY_STRING 'l'
  test::func _MY_STRING='hello' string::getIndexOf _MY_STRING 'he'
  test::func _MY_STRING='hello' string::getIndexOf _MY_STRING 'he' 10
  test::func _MY_STRING='yes-yes' string::getIndexOf _MY_STRING 'ye' 1
  test::func _MY_STRING='yes-yes' string::getIndexOf _MY_STRING 'yes' 5
}

function test_string::extractBetween() {
  test::title "✅ Testing string::extractBetween function"

  test::func _MY_STRING='hello' string::extractBetween _MY_STRING 'e' 'o'
  test::func _MY_STRING='hello' string::extractBetween _MY_STRING 'e' ''
  test::func _MY_STRING='hello' string::extractBetween _MY_STRING 'h' 'a'

  test::printVars MULTI_LINES_TEXT2
  test::func string::extractBetween MULTI_LINES_TEXT2 "one"$'\n' '4'
  test::func string::extractBetween MULTI_LINES_TEXT2 "2 " $'\n'
}

function test_string::count() {
  test::title "✅ Testing string::count function"

  test::func _MY_STRING='name,firstname,address' string::count _MY_STRING ','
  test::func _MY_STRING='bonjour mon bon ami, bonne journée!' string::count _MY_STRING 'bo'
}

function test_string::split() {
  test::title "✅ Testing string::split function"

  test::func _MY_STRING="name:firstname:address" string::split _MY_STRING ":"
  test::func _MY_STRING="one:two,three" string::split _MY_STRING ":,"
}

function test_string::wrapWords() {
  test::title "✅ Testing string::wrapWords"

  test::markdown "Wrapping text at column 30 with no padding"
  test::func string::wrapWords MULTI_LINES_TEXT 30

  test::markdown "Wrapping text at column 50 with padding of 4 on new lines"
  test::func string::wrapWords MULTI_LINES_TEXT 50 '    '

  test::markdown "Wrapping text at column 20 with padding of 3 on all lines"
  test::func string::wrapWords MULTI_LINES_TEXT 20 '   ' 17

  test::markdown "Wrapping words, shortcut because the message is a short single line"
  test::func _MY_STRING='A message.' string::wrapWords _MY_STRING 80

  test::markdown "Wrapping words, no shortcut!"
  test::func _MY_STRING='A message.' string::wrapWords _MY_STRING 80 '' 5

  test::markdown "Wrapping words"
  test::funcWithString string::wrapWords 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10
}

function test_string::wrapCharacters() {
  test::title "✅ Testing string::wrapCharacters"

  test::markdown  "Wrapping characters at column 20 with padding of 3 on all lines"
  test::func string::wrapCharacters MULTI_LINES_TEXT 20 "   " 17

  test::markdown "Wrapping characters at 20, no other options"
  test::func string::wrapCharacters MULTI_LINES_TEXT 20

  test::markdown "Wrapping characters"
  test::funcWithString string::wrapCharacters 01234567890123456789234 17 '   ' 1

  test::markdown "Wrapping characters"
  test::funcWithString string::wrapCharacters 'A message.'$'\n''A new line' 13 '[36m░░░[0m' 10

  test::markdown "Wrapping characters, spaces at the beginning of the line are kept"
  test::funcWithString string::wrapCharacters '  Start With spaces that must be kept! Other spaces can be ignored at wrapping.'$'\n''  Also start with spaces' 17 '   ' 14

  test::funcWithString string::wrapCharacters 'Message' 3
}

function test_string::highlight() {
  test::title "✅ Testing string::highlight"

  _OPTION_HIGHLIGHT_ANSI=">"
  _OPTION_RESET_ANSI="<"
  test::func MY_STRING='This is a Text to highlight.' MY_CHARS='ttttt' string::highlight MY_STRING MY_CHARS
  test::func MY_STRING='This is a texT to highlight.' MY_CHARS='TTTTT' string::highlight MY_STRING MY_CHARS "'>'" "'<'"
  test::func MY_STRING='' MY_CHARS='ttttt' string::highlight MY_STRING MY_CHARS
  test::func MY_STRING='This is a text to highlight.' MY_CHARS='' string::highlight MY_STRING MY_CHARS
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

function test::funcWithString() {
  # shellcheck disable=SC2034
  MY_STRING="${2}"
  local function="${1}"
  shift 2
  test::printVars MY_STRING
  test::func "${function}" MY_STRING "$@"
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