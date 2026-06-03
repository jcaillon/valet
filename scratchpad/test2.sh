#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include benchmark progress bash time

function something() {
  log::info "Doing something..."
}

trap::register something on-exit

trap::triggerEvent on-nothing
trap::triggerEvent on-exit
