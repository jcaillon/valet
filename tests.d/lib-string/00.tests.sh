#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-string
source string

function main() {
  test_string::get KebabCase
  test_string::get SnakeCase
  test_string::get CamelCase
  test_string::numberToUniqueId
  test_string::removeTextFormatting
  test_string::getHexRepresentation
  test_string::getField
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

function test_string::get() {
  local function="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"

  test::title "✅ Testing string::get${function}"

  local tests=(
    "thisIsATest01"
    "AnotherTest"
    "--*Another!test--"
    "_SNAKE_CASE"
    "__SNAKE_CASE__"
    "kebab-case"
    "--kebab-case--"
  )
  local test IFS=$'\n'

  test::prompt 'echo "${tests[*]"'
  echo "${tests[*]}"
  test::flush

  test::prompt 'for test in ${tests[@]}; do '"string::get${function}"' test; echo "${REPLY}"; done'
  for test in "${tests[@]}"; do
    "string::get${function}" test
    echo "${REPLY}"
  done
  test::flush
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

  _myString="w[36mo[107mr[38;2;255;255;255md[38;5;255m w[36mo[107mr[38;2;255;255;255md[38;5;255m!"
  test::func string::removeTextFormatting _myString
  test::printVars _myString
}

function test_string::getHexRepresentation() {
  test::title "✅ Testing string::getHexRepresentation"

  local _myString="d071ec191f6e98a9c78b6d502c823d8e5adcfdf83d0ea55ebc7f242b29ce8301"
  test::func _myString=d071ec191f6e98a9c78b6d502c823d8e5adcfdf83d0ea55ebc7f242b29ce8301 string::getHexRepresentation _myString
}

function test_string::doForEachLine() {
  test::title "✅ Testing string::doForEachLine"

  function forEachLine() {
    echo "Line: '${1}'"
  }

  test::func string::doForEachLine MULTI_LINES_TEXT3 forEachLine

  test::func MY_STRING="1 2 3" string::doForEachLine MY_STRING forEachLine separator=" "
}

function test_string::getField() {
  test::title "✅ Testing string::getField"

  local _MY_STRING='field1 field2 field3'
  test::printVars "_MY_STRING"
  test::func string::getField _MY_STRING 0 separator=' '
  test::func string::getField _MY_STRING 1 separator=' '
  test::func string::getField _MY_STRING 2 separator=','
  test::func string::getField _MY_STRING 4 separator=','

  # shellcheck disable=SC2034
  _MY_STRING="line1 hm I wonder"$'\n'"line2 does it work on lines?"$'\n'"line3 seems so"
  test::printVars "_MY_STRING"
  test::func string::getField _MY_STRING 2 separator=$'\n'
}

function test_string::trimAll() {
  test::title "✅ Testing string::trimAll"

  test::execWithString string::trimAll '  a  super test  '
  test::execWithString string::trimAll 'this is a command  '
  test::execWithString string::trimAll $'\t\n''this is a '$'\t''command  '

}

function test_string::trimEdges() {
  test::title "✅ Testing string::trimEdges"

  test::execWithString string::trimEdges '  hello  world  '
  test::execWithString string::trimEdges '_-_-_hello_-_' charsToTrim=_-
  test::execWithString string::trimEdges '  hello'
  test::execWithString string::trimEdges $'\n'$'\t''  hello'$'\n'$'\t'' '
}

function test_string::getIndexOf() {
  test::title "✅ Testing string::getIndexOf function"

  test::func _MY_STRING='hello' string::getIndexOf _MY_STRING 'l'
  test::func _MY_STRING='hello' string::getIndexOf _MY_STRING 'he'
  test::func _MY_STRING='hello' string::getIndexOf _MY_STRING 'he' startingIndex=10
  test::func _MY_STRING='yes-yes' string::getIndexOf _MY_STRING 'ye' startingIndex=1
  test::func _MY_STRING='yes-yes' string::getIndexOf _MY_STRING 'yes' startingIndex=5
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
  test::func string::wrapWords MULTI_LINES_TEXT width=30

  test::markdown "Wrapping text at column 50 with padding of 4 on new lines"
  test::func string::wrapWords MULTI_LINES_TEXT width=50 newLinePadString='    '

  test::markdown "Wrapping text at column 20 with padding of 3 on all lines"
  test::func string::wrapWords MULTI_LINES_TEXT width=20 newLinePadString='   ' firstLineWidth=17

  test::markdown "Wrapping words, shortcut because the message is a short single line"
  test::funcWithString string::wrapWords 'A message.' width=80

  test::markdown "Wrapping words, no shortcut!"
  test::funcWithString string::wrapWords 'A message.' width=80 newLinePadString='' firstLineWidth=5

  test::markdown "Wrapping words"
  test::funcWithString string::wrapWords 'A message.'$'\n''A new line' width=13 newLinePadString='[36m░░░[0m' firstLineWidth=10
}

function test_string::wrapCharacters() {
  test::title "✅ Testing string::wrapCharacters"

  test::markdown  "Wrapping characters at column 20 with padding of 3 on all lines"
  test::func string::wrapCharacters MULTI_LINES_TEXT width=20 newLinePadString="   " firstLineWidth=17

  test::markdown "Wrapping characters at 20, no other options"
  test::func string::wrapCharacters MULTI_LINES_TEXT width=20

  test::markdown "Wrapping characters"
  test::funcWithString string::wrapCharacters 01234567890123456789234 width=17 newLinePadString='   ' firstLineWidth=1

  test::markdown "Wrapping characters"
  test::funcWithString string::wrapCharacters 'A message.'$'\n''A new line' width=13 newLinePadString='[36m░░░[0m' firstLineWidth=10

  test::markdown "Wrapping characters, spaces at the beginning of the line are kept"
  test::funcWithString string::wrapCharacters '  Start With spaces that must be kept! Other spaces can be ignored at wrapping.'$'\n''  Also start with spaces' width=17 newLinePadString='   ' firstLineWidth=14

  test::funcWithString string::wrapCharacters 'Message' width=3
}

function test_string::highlight() {
  test::title "✅ Testing string::highlight"

  test::func MY_STRING='This is a Text to highlight.' MY_CHARS='ttttt' string::highlight MY_STRING MY_CHARS
  test::func MY_STRING='This is a texT to highlight.' MY_CHARS='TTTTT' string::highlight MY_STRING MY_CHARS highlightCode="'>'" resetCode="'<'"
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

  test::markdown "Testing string::head with 10 lines"
  test::func MY_STRING='1 2 3 4' string::head MY_STRING 2 separator=' '
}

function test::funcWithString() {
  # shellcheck disable=SC2034
  MY_STRING="${2}"
  local function="${1}"
  shift 2
  test::printVars MY_STRING
  test::func "${function}" MY_STRING "$@"
}

function test::execWithString() {
  # shellcheck disable=SC2034
  MY_STRING="${2}"
  local function="${1}"
  shift 2
  test::printVars MY_STRING
  test::func "${function}" MY_STRING "$@"
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