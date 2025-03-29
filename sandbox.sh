#!/usr/bin/env bash
set -Eeu -o pipefail

#===============================================================
# >>> Source main functions
#===============================================================
# shellcheck source=libraries.d/core
source "libraries.d/core"

#===============================================================
# >>> Run the main function
#===============================================================

source sfzf
source interactive
source ansi-codes
source time
source prompt
source string
source tui

# interactive::testWaitForKeyPress
# exit 0

# load the file
time::getProgramElapsedMicroseconds
TIME1="${RETURNED_VALUE}"
mapfile -t MY_ARRAY < "f2"
# mapfile -t MY_ARRAY < "f3"
# mapfile -t MY_ARRAY < "f4"
# echo
# echo "→ array::fuzzyFilterSort the MY_ARRAY"
# array::fuzzyFilterSort a MY_ARRAY
# IFS=$'\n'
# echo "${RETURNED_ARRAY[*]}"
# echo "${RETURNED_ARRAY2[*]}"
time::getProgramElapsedMicroseconds
time::convertMicrosecondsToHuman "$((RETURNED_VALUE - TIME1))" %SS.%l
log::warning "Elapsed time: ${RETURNED_VALUE}"


declare -g -a SELECTION_ARRAY
SELECTION_ARRAY=('disable the '"${AC__FG_BRIGHT_YELLOW}"'monitor mode to avoid'"${AC__FG_RESET}"' the "Terminated" message with exit code once the spinner is stopped' blue red green yellow affair affairs affect affected affecting affects affiliate affiliated affiliates affiliation afford affordable afghanistan afraid africa african after afternoon fallen falling falls false fame familiar families family famous fan fancy fans fantastic fantasy faq faqs far fare fares farm farmer farmers farming farms fascinating luck lucky lucy luggage luis luke lunch lung luther luxembourg luxury lycos lying safari safe safely safer safety sage sagem said sail sailing saint saints sake salad salaries salary sale salem sales sally salmon salon salt salvador salvation sam samba same samoa sample samples sampling samsung samuel san sand sandra sandwich sandy transsexual trap trash trauma travel traveler travelers traveling traveller travelling travels travesti travis tray treasure treasurer treasures treasury treat treated)
# SELECTION_ARRAY=(blue red green yellow)
SELECTION_ARRAY=("${MY_ARRAY[@]}")

# printf "%s\n" "░░░░░░░░░░░░░░░"
tui::createSpace 5

# if PROMPT_STRING_MAX_LENGTH=9 PROMPT_PLACEHOLDER="Type something" prompt::input "${GLOBAL_CURSOR_LINE}" "${GLOBAL_CURSOR_COLUMN}" "$((GLOBAL_CURSOR_COLUMN + 15))" SELECTION_ARRAY ""; then

function fuck() {
  RETURNED_VALUE="coucou"
  RETURNED_VALUE2=false
  return 0
}
# PROMPT_CALLBACK_FUNCTION_ON_TEXT_UPDATE=fuck

# shellcheck disable=SC2317
function onReturn() {
  case "${FUNCNAME[1]}" in
    array::fuzzyFilterSortQuicksort | tui::waitForKeyPress | prompt::getItemDisplayedString) :;;
    *)
      local -i index
      local str=""
      for((index=0;index<${#FUNCNAME[@]};index++)); do
        str+=" "
      done
      echo "Left ${str}${FUNCNAME[1]}:${BASH_LINENO[2]}" >>f1
    ;;
  esac
}

# trap onReturn RETURN

# load the file "file" into an array (each line as an element)
tui::getCursorPosition

# _OPTION_ITEMS_BOX_FORCE_LEFT=14
# _OPTION_ITEMS_BOX_FORCE_TOP=5
# _OPTION_ITEMS_BOX_FORCE_WIDTH=10
# _OPTION_ITEMS_BOX_FORCE_HEIGHT=5
# _OPTION_ITEMS_BOX_FORCE_BELOW=true

# _OPTION_STOP_COLUMN=$((GLOBAL_CURSOR_COLUMN + 10))
_OPTION_ITEMS_BOX_ITEM_COUNT_ENABLED=true
_OPTION_ITEMS_ARRAY_NAME=SELECTION_ARRAY
_OPTION_STRING=""
_OPTION_ITEMS_BOX_MAX_HEIGHT=100
_OPTION_ITEMS_BOX_FORCE_BELOW=true
_OPTION_ENABLE_PROMPT=true
_OPTION_ITEMS_BOX_FORCE_SHOW_COUNT=true
_OPTION_ITEMS_BOX_SHOW_COUNT_AT_TOP=false
_OPTION_SHOW_SYMBOL=true
_OPTION_FILTERS_FROM_N_CHARS=0
_OPTION_ACCEPT_ANY_VALUE=true
_OPTION_PLACEHOLDER="Type something"
_OPTION_STRING_MAX_LENGTH=99
_OPTION_AUTOCOMPLETE_WHOLE_LINE=false
_OPTION_TAB_OPENS_ITEMS_BOX=true
_OPTION_ITEMS_BOX_ALLOW_FILTERING=true
_OPTION_PASSWORD_MODE=false
if prompt::input "${GLOBAL_CURSOR_LINE}" "${GLOBAL_CURSOR_COLUMN}"; then
  log::info "You entered: ⌜${RETURNED_VALUE}⌝ (displayed: ⌜${RETURNED_VALUE2}⌝ index ⌜${RETURNED_VALUE3}⌝)"
else
  log::info "bye"
fi

exit 0