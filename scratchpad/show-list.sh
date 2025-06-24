#!/usr/bin/env bash
# shellcheck disable=SC1090
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
source "$(valet --source)"
include list

# load the file
mapfile -t MY_ARRAY < "scratchpad/words"

tui::createSpace 9

tui::getCursorPosition

_OPTION_TOP=${GLOBAL_CURSOR_LINE} _OPTION_HEIGHT=9 list::setViewport
list::setItems MY_ARRAY
list::draw
# list::filter ""

echo "${ESC__CURSOR_MOVE__}$((GLOBAL_CURSOR_LINE + 8));1${__ESC__TO}"

sleep 1
