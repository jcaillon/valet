#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include prompt time profiler

# interactive::testWaitForKeyPress
# exit 0

# load the file
time::getProgramElapsedMicroseconds
TIME1="${REPLY}"
mapfile -t MY_ARRAY < "scratchpad/words"
mapfile -t MY_ARRAY < "scratchpad/f3"
# mapfile -t MY_ARRAY < "scratchpad/f4"
# echo
# echo "→ array::fuzzyFilterSort the MY_ARRAY"
# array::fuzzyFilterSort a MY_ARRAY
# IFS=$'\n'
# echo "${REPLY_ARRAY[*]}"
# echo "${REPLY_ARRAY2[*]}"
time::getProgramElapsedMicroseconds
time::convertMicrosecondsToHuman "$((REPLY - TIME1))" %SS.%l
log::warning "Elapsed time: ${REPLY}"


declare -g -a SELECTION_ARRAY
SELECTION_ARRAY=('disable the '"${ESC__FG_BRIGHT_YELLOW}"'monitor mode to avoid'"${ESC__FG_RESET}"' the "Terminated" message with exit code once the spinner is stopped' blue red green yellow affair affairs affect affected affecting affects affiliate affiliated affiliates affiliation afford affordable afghanistan afraid africa african after afternoon fallen falling falls false fame familiar families family famous fan fancy fans fantastic fantasy faq faqs far fare fares farm farmer farmers farming farms fascinating luck lucky lucy luggage luis luke lunch lung luther luxembourg luxury lycos lying safari safe safely safer safety sage sagem said sail sailing saint saints sake salad salaries salary sale salem sales sally salmon salon salt salvador salvation sam samba same samoa sample samples sampling samsung samuel san sand sandra sandwich sandy transsexual trap trash trauma travel traveler travelers traveling traveller travelling travels travesti travis tray treasure treasurer treasures treasury treat treated)
# SELECTION_ARRAY=(blue red green yellow)
SELECTION_ARRAY=("${MY_ARRAY[@]}")

# printf "%s\n" "░░░░░░░░░░░░░░░"
tui::createSpace 5

# if PROMPT_STRING_MAX_LENGTH=9 PROMPT_PLACEHOLDER="Type something" prompt::input "${GLOBAL_CURSOR_LINE}" "${GLOBAL_CURSOR_COLUMN}" "$((GLOBAL_CURSOR_COLUMN + 15))" SELECTION_ARRAY ""; then

function fuck() {
  REPLY="coucou"
  REPLY2=false
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
# if prompt::input "${GLOBAL_CURSOR_LINE}" "${GLOBAL_CURSOR_COLUMN}"; then
#   log::info "You entered: ⌜${REPLY}⌝ (displayed: ⌜${REPLY2}⌝ index ⌜${REPLY3}⌝)"
# else
#   log::info "bye"
# fi
# _OPTION_STRING='You don`t [36m[36m[36mget better[39m[39m[39m on the days when you feel like going. You get better on the days when you don`t want to go, but you go anyway. If you can [34movercome the negative energy[39m coming from your tired body or unmotivated mind, you will grow and become better. It won`t be the best workout you have, you won`t accomplish as much as what you usually do when you actually feel good, but that doesn`t matter. Growth is a long term game, and the crappy days are more important.

# As long as I focus on what I feel and don`t worry about where I`m going, it works out. Having no expectations but being open to everything is what makes wonderful things happen. If I don`t worry, there`s no obstruction and life flows easily. It sounds impractical, but `Expect nothing; be open to everything` is really all it is. 01234567890123456789 on new line 01234567890123456789234 line new line.

# https://en.wikipedia.org/wiki/Veganism

# There were 2 new lines before this.'

# profiler::enable ./tmp/prof
# VALET_CONFIG_KEEP_ALL_PROFILER_LINES=true

_OPTION_ITEMS_BOX_FILTER_ASYNCHRONOUSLY_THRESHOLD=0
_OPTION_ITEMS_BOX_FILTER_USING_EXTERNAL_PROGRAM_THRESHOLD=10000

if prompt::input "${GLOBAL_CURSOR_LINE}" "${GLOBAL_CURSOR_COLUMN}"; then
  log::info "You entered: ⌜${REPLY}⌝ (displayed: ⌜${REPLY2}⌝ index ⌜${REPLY3}⌝)"
else
  log::info "bye"
fi

exit 0