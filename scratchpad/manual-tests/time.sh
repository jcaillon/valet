#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"

include time bash

time::startTimer
time::getTimerMicroseconds
log::info "Elapsed time: ${REPLY} microseconds."
time::logTimerElapsedTime
if ! time::isTimerElapsed 2s; then
  log::info "Timer is not elapsed yet."
fi

bash::sleep 2
if time::isTimerElapsed 2s; then
  log::info "Timer is elapsed after 2 seconds."
fi
