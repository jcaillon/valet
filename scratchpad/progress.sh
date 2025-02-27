#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include progress bash profiler

# ############################
# # Spinner
# ############################

log::info "Now displaying a slow spinner that goes for 7 frames."

_OPTION_MAX_FRAMES=7 _OPTION_SPINNER="⢄⢂⢁⡁⡈⡐⡠" progress::start "<spinner>" "20" 200
# the spinners stops on itself

bash::sleep 3

log::info "Another spinner."

_OPTION_SPINNER="⢄⢂⢁⡁⡈⡐⡠" progress::start "<spinner>" "20" 50

IDX=0
while [[ ${IDX} -lt 10 ]]; do
  IDX=$((IDX + 1))
  log::info "We can still output logs while the spinner runs..."
  bash::sleep  0.3
done

progress::stop


############################
# Progress bar
############################

log::warning "Now displaying a progress bar."

IDX=0
while [[ ${IDX} -le 50 ]]; do
  progress::update $((IDX * 2)) "doing something ${IDX}..."
  IDX=$((IDX + 1))
  # log::info "alright ${IDX}..."
  bash::sleep  0.1
done

progress::stop

