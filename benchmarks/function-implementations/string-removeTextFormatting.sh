#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark

str="My text${ESC__BG_RED}${ESC__FG_WHITE} with some ${ESC__TEXT_BOLD}text formatting${ESC__TEXT_RESET} and some more text${ESC__BG_BLUE}${ESC__FG_BRIGHT_CYAN}unreadable stuff${ESC__TEXT_RESET}. Inluding some ${ESC__FG_COLOR_24b__}123;55;255${__ESC__END_COLOR}24 bit colors${ESC__BG_RESET} and some ${ESC__FG_COLOR__}2${__ESC__END_COLOR}8 bit colors${ESC__TEXT_RESET}."

echo "${str}"

function string::removeTextFormatting1() {
  local textForWhichToRemoveFormatting="${str}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9][0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]m/}"
  # 8 bit colors
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;5;[0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;5;[0-9][0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;5;[0-9][0-9][0-9]m/}"
  # 24 bit colors
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9];[0-9];[0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9][0-9];[0-9];[0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9][0-9][0-9];[0-9];[0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9];[0-9][0-9];[0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9];[0-9][0-9][0-9];[0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9];[0-9];[0-9][0-9][0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9];[0-9];[0-9][0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9][0-9];[0-9][0-9];[0-9][0-9]m/}"
  textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9][0-9][0-9];[0-9][0-9][0-9];[0-9][0-9][0-9]m/}"
}

function string::removeTextFormatting2() {
  local textForWhichToRemoveFormatting="${str}"
  if [[ ${textForWhichToRemoveFormatting} == *$'\e'* ]]; then
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9][0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;5;[0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;5;[0-9][0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;5;[0-9][0-9][0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9];[0-9];[0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9][0-9];[0-9];[0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9][0-9][0-9];[0-9];[0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9];[0-9][0-9];[0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9];[0-9][0-9][0-9];[0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9];[0-9];[0-9][0-9][0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9];[0-9];[0-9][0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9][0-9];[0-9][0-9];[0-9][0-9]m/}"
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting//$'\e['[0-9]8;2;[0-9][0-9][0-9];[0-9][0-9][0-9];[0-9][0-9][0-9]m/}"
  fi
}

function string::removeTextFormatting3() {
  local textForWhichToRemoveFormatting="${str}"
  while [[ ${textForWhichToRemoveFormatting} =~ $'\e'\[[0-9]([0-9])?(;[52];([0-9]{1,3}|[0-9]{1,3};[0-9]{1,3};[0-9]{1,3}))?m ]]; do
    textForWhichToRemoveFormatting="${textForWhichToRemoveFormatting/"${BASH_REMATCH[0]}"/}"
  done
}

benchmark::run string::removeTextFormatting1 string::removeTextFormatting2 string::removeTextFormatting3

# For a long string with many formatting codes, the first function is the fastest.

#  Function name                 ░ Average time  ░ Compared to fastest
#  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#  string::removeTextFormatting1 ░ 0.000s 105µs ░ N/A
#  string::removeTextFormatting2 ░ 0.000s 107µs ░ +2%
#  string::removeTextFormatting3 ░ 0.000s 297µs ░ +181%

# But for short 1 word strings, the second function is faster.
#
#  Function name                 ░ Average time  ░ Compared to fastest
#  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#  string::removeTextFormatting2 ░ 0.000s 014µs ░ N/A
#  string::removeTextFormatting3 ░ 0.000s 018µs ░ +31%
#  string::removeTextFormatting1 ░ 0.000s 079µs ░ +454%