#!/usr/bin/env bash
# shellcheck disable=SC1090
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_CONFIG_LOG_FD=tmp/log
export VALET_CONFIG_LOG_PATTERN="<elapsedTime>{8s} [<pid>{04s}:<subshell>{1s}] <sourceFile>{-5s}:<line>{-4s} <level>{-4s}  <message>"

source "$(valet --source)"
include list bash terminal

TWO_LINES_ITEMS=(
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
ONE_LINE_ITEMS=(
  "apple"
  "banana"
  "cherry"
  "date"
  "elderberry"
  "fig"
  "grape"
  "honeydew"
  "kiwi"
  "lemon"
)

function draw() {
  local \
    move=${1} \
    width=${2} \
    height=${3} \
    arrayName="${4}" \
    filter="${5}"
  shift 5

  terminal::createSpace "$((height + 1))"
  terminal::getCursorPosition

  list::setOptions "${@}"
  list::setViewport top="${GLOBAL_CURSOR_LINE}" height="${height}" width="${width}"

  list::setItems "${arrayName}"
  list::filter "${filter}"
  list::changeSelectedItemIndex "${move}"
  list::draw

  printf "%s" "${ESC__CURSOR_MOVE__}$((GLOBAL_CURSOR_LINE + height));1${__ESC__TO}" 1>&"${GLOBAL_FD_TUI}"
}

draw 0 "" 10 TWO_LINES_ITEMS "" itemHeight=2
draw 0 20 9 TWO_LINES_ITEMS "" itemHeight=2
draw 0 "" 10 TWO_LINES_ITEMS "" itemHeight=2 enableReverseMode=true
draw 0 20 9 TWO_LINES_ITEMS "" itemHeight=2 enableReverseMode=true

draw 0 40 9 TWO_LINES_ITEMS "notfound" itemHeight=2

draw 1 20 9 TWO_LINES_ITEMS "o" itemHeight=2
draw 3 20 9 TWO_LINES_ITEMS "o" itemHeight=2

# option for title, option for text on the bottom left
# fix the counter
