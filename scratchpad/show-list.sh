#!/usr/bin/env bash
# shellcheck disable=SC1090
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
source "$(valet --source)"
include list

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
_OPTION_ITEM_HEIGHT=2

tui::createSpace 9
tui::getCursorPosition
_OPTION_TOP=${GLOBAL_CURSOR_LINE} _OPTION_HEIGHT=9 list::setViewport

list::setItems MY_ARRAY
list::draw
list::drawCounter
# list::filter ""

echo "${ESC__CURSOR_MOVE__}$((GLOBAL_CURSOR_LINE + 8));1${__ESC__TO}"

sleep 1

# export VALET_CONFIG_LOG_FD=tmp/f