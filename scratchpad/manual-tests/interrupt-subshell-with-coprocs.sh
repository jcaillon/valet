#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_LOG_LEVEL="debug"
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<pid>{04d}:<subshell>{1s}]   <colorFaded><sourceFile>{-5s}:<line>{-4s}<colorDefault>  <levelColor><level>{-4s} <colorDefault> <message>"

# shellcheck source=../libraries.d/main
source "$(valet --source)"
include tui coproc fs bash terminal

JOB_NAMES=(name{1..30})
JOB_COMMANDS=()
for i in {1..30}; do
  JOB_COMMANDS+=("log::info 'Job $i started with pid \$BASHPID'; bash::sleep $((RANDOM % 3 + 50 )); log::warning 'Job $i done'")
done

function callback() {
  log::info "Done running index ${1}: ${2}, logs in: ${4}"
}

bash::runInSubshell coproc::runInParallel JOB_COMMANDS maxInParallel=1 completedCallback=callback printRedirectedLogs=true

# We start a subshell that starts a coproc. Verify that CTRL+C kills everything.