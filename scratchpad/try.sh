#!/usr/bin/env bash
export VALET_VERBOSE=true
export VALET_CONFIG_LOG_PATTERN="<colorFaded><elapsedTimeSinceLastLog>  <levelColor><icon><level>{-4s} <colorDefault> <message>"
source "$(valet --source)"

include system string time bash interactive

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

interactive::choose ONE_LINE_ITEMS

# mapfile -t MY_ARRAY < "scratchpad/words"
# interactive::choose MY_ARRAY