#!/usr/bin/env bash
# shellcheck disable=SC1090
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
source "$(valet --source)"
include list

# load the file
mapfile -t MY_ARRAY < "scratchpad/words"

echo "coucou1"
tui::createSpace 3


echo "${ESC__CURSOR_MOVE__}2${__ESC__DOWN}coucou2"
tui::createSpace 3


echo "${ESC__CURSOR_MOVE__}2${__ESC__DOWN}coucou3"
tui::createSpace 3


echo "${ESC__CURSOR_MOVE__}2${__ESC__DOWN}coucou4"
tui::createSpace 3


echo "${ESC__CURSOR_MOVE__}2${__ESC__DOWN}coucou5"
tui::createSpace 3

echo "yes"

tui::createSpace 4
echo "coucou"
tui::getCursorPosition
echo "Cursor position: ${GLOBAL_CURSOR_LINE}:${GLOBAL_CURSOR_COLUMN}, ${GLOBAL_LINES}"
echo "coucou"
printf "%s" "${ESC__CURSOR_MOVE__}${GLOBAL_CURSOR_LINE};1${__ESC__TO}"

tui::createSpace 9
echo "yes"

sleep 1
