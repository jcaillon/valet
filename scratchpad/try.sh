#!/usr/bin/env bash
export VALET_VERBOSE=true
source "$(valet --source)"

include system string time bash

if time::isTimeElapsed 2000000; then
  log::info "2000000 microseconds have elapsed"
fi
bash::sleep 1
if time::isTimeElapsed 2000000; then
  log::info "2000000 microseconds have elapsed"
fi
bash::sleep 1
if time::isTimeElapsed 2000000; then
  log::info "2000000 microseconds have elapsed"
fi

