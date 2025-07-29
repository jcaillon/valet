#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:pid>{04s}:<subshell>{1s}](<pid>{05d}) <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"
export VALET_LOG_LEVEL="debug"

# shellcheck disable=SC1090
source "$(valet --source)"
include benchmark progress coproc bash

#################################

progress::start
progress::update 0 "Running test suites."

JOB_NAMES=(name{1..30})
JOB_COMMANDS=()
for i in {1..30}; do
  JOB_COMMANDS+=("log::info 'Job $i started'; bash::sleep $((RANDOM % 3 + 1 )); log::warning 'Job $i done'")
done

function callback() {
  progress::update "${3}" "Done running index ${1}: ${2}."
  log::info "logs in: ${4}"
}

_OPTION_MAX_IN_PARALLEL=1 _OPTION_COMPLETED_CALLBACK=callback _OPTION_PRINT_REDIRECTED_LOGS=true coproc::runInParallel JOB_COMMANDS

if (( REPLY != 0 )); then
  log::error "Did not executed all coprocs."
else
  log::info "${REPLY2} coprocs completed with exit code 0."
fi

progress::stop

