#!/usr/bin/env bash
# shellcheck disable=SC1090
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_CONFIG_LOG_FD=tmp/log
export VALET_CONFIG_LOG_PATTERN="<elapsedTime>{8s} [<pid>{04s}:<subshell>{1s}] <sourceFile>{-5s}:<line>{-4s} <level>{-4s}  <message>"

source "$(valet --source)"
include list bash terminal time

# load the file
mapfile -t MY_ARRAY < "scratchpad/words"

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
    move="${1}" \
    width="${2}" \
    height="${3}" \
    arrayName="${4}" \
    filter="${5}"
  shift 5
  terminal::createSpace "$((height + 1))"
  terminal::getCursorPosition

  local -n arrayRef="${arrayName}"
  local -i itemHeight
  if [[ ${arrayRef[0]} == *$'\n'* ]]; then
    itemHeight=2
  else
    itemHeight=1
  fi

  list::setOptions "${@}" itemHeight=${itemHeight}
  list::setViewport top="${GLOBAL_CURSOR_LINE}" height="${height}" width="${width}"

  list::setItems "${arrayName}"
  list::filter "${filter}"
  list::changeSelectedItemIndex "${move}"
  list::onTick

  printf "%s" "${ESC__CURSOR_MOVE__}$((GLOBAL_CURSOR_LINE + height));1${__ESC__TO}" 1>&"${GLOBAL_FD_TUI}"
}

for array in TWO_LINES_ITEMS ONE_LINE_ITEMS; do
  draw 0 "" 10 "${array}" ""
  draw 0 20 9 "${array}" ""
  draw 0 "" 10 "${array}" "" enableReverseMode=true
  draw 0 20 9 "${array}" "" enableReverseMode=true

  draw 0 40 9 "${array}" "notfound"
  draw 0 40 9 "${array}" "notfound" emptyListText="No item found"

  draw 1 20 9 "${array}" "o"
  draw 3 20 9 "${array}" "o"
  draw 3 20 9 "${array}" "o" disableHeader=true disableScrollbar=true disableCursor=true disableFooter=true
  draw 3 20 9 "${array}" "o" headerPattern="coucou| HI THERE |Items: <colorHeader><firstItemNumber>-<lastItemNumber>/<totalItems><colorReset> <colorFrame>(filtered: <filteredItems>) <percentViewed><colorReset>" footerPattern=""

  draw 5 "" 9 "${array}" "o" filteringString=" FILTEEEEERRRRR !"

  echo "----------------------------------------"
done

# time::startTimer
# for ((i=0; i<200; i++)); do
#   draw 0 "" 9 "MY_ARRAY" "o" headerPattern="coucou| HI THERE |Items: <colorCount><firstItemNumber>-<lastItemNumber>/<totalItems><colorReset> <colorFrame>(filtered: <filteredItems>) <percentViewed><colorReset>"
# done
# time::getTimerMicroseconds logElapsedTime=true
