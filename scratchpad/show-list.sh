#!/usr/bin/env bash
# shellcheck disable=SC1090
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_CONFIG_LOG_FD=tmp/log
export VALET_CONFIG_LOG_PATTERN="<elapsedTime>{8s} [<pid>{04s}:<subshell>{1s}] <sourceFile>{-5s}:<line>{-4s} <level>{-4s}  <message>"

source "$(valet --source)"
include list bash terminal


# load the file
mapfile -t MY_ARRAY < "scratchpad/words"

MY_ARRAY=(
  "apple"$'\n'"(green)"
  "banana"$'\n'"(yellow)"
  "cherry"$'\n'"(red)"
  "date"$'\n'"(brown)"
  "elderberry"$'\n'"(purple)"
  "fig"$'\n'"(green)"
  "grape"$'\n'"(purple)"
  "honeydew"$'\n'"(green)"
  "kiwi"$'\n'"(brown)"
  "lemon"$'\n'"(yellow)"
  "mango"$'\n'"(orange)"
  "nectarine"$'\n'"(orange)"
  "orange"$'\n'"(orange)"
  "papaya"$'\n'"(orange)"
  "quince"$'\n'"(orange)"
)
# MY_ARRAY=(
# )
terminal::createSpace 10
terminal::getCursorPosition
log::info "Drawing the list with ${#MY_ARRAY[@]} items."

time::startTimer
list::setOptions itemHeight=2
list::setViewport _OPTION_TOP="${GLOBAL_CURSOR_LINE}" _OPTION_HEIGHT=10

list::setItems MY_ARRAY
list::drawTopSeparator
list::drawItems
list::drawCounter
list::drawScrollBar
# list::filter ""


_OPTION_LOG_ELAPSED_TIME=true time::getTimerMicroseconds

echo "${ESC__CURSOR_MOVE__}$((GLOBAL_CURSOR_LINE + 8));1${__ESC__TO}"

bash::sleep 5

# option for title, option for text on the bottom left
# fix the counter