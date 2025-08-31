#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:pid>{04s}:<subshell>{1s}](<pid>{05d}) <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"
export VALET_LOG_LEVEL="debug"

# shellcheck disable=SC1090
source "$(valet --source)"
include benchmark progress coproc bash

#################################

progress::start percent=0 message="Running test suites."

JOB_NAMES=(name{1..30})
JOB_COMMANDS=()
for i in {1..30}; do
  JOB_COMMANDS+=("log::info 'Job $i started'; bash::sleep $((RANDOM % 3 + 1 )); log::warning 'Job $i done'")
done

function callback() {
  progress::update percent="${3}" message="Done running index ${1}: ${2}."
  log::info "logs in: ${4}"
}

coproc::runInParallel JOB_COMMANDS maxInParallel=1 completedCallback=callback printRedirectedLogs=true

if (( REPLY != 0 )); then
  log::error "Did not executed all coprocs."
else
  log::info "${REPLY2} coprocs completed with exit code 0."
fi

progress::stop

