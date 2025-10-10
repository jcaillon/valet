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


include progress exe

progress::start template="<spinner>"

log::info "Cleaning up windows temp files"
pushd ~/AppData/Local/Temp >/dev/null || log::error "Could not change directory to Temp folder"
exe::invoke rm -rf ./* --- warnOnFailure=true
popd >/dev/null || log::error "Could not change directory to previous folder"

log::info "Cleaning up bash temp files"
pushd ~/AppData/Local/tmp >/dev/null || log::error "Could not change directory to tmp folder"
exe::invoke rm -rf ./* --- warnOnFailure=true
popd >/dev/null || log::error "Could not change directory to previous folder"

KOMOREBI_CONFIG_HOME=~\.config\komorebi \
    komorebic start --ahk

windows::runPs1

interactive::continue

progress::stop