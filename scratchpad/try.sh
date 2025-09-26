#!/usr/bin/env bash
export VALET_VERBOSE=true
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