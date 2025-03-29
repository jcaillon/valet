#!/usr/bin/env bash
set -Eeu -o pipefail

#===============================================================
# >>> Source main functions
#===============================================================
# shellcheck source=libraries.d/core
source "libraries.d/core"

source progress
source bash
source tui
source interactive
source prompt
source benchmark

#===============================================================
# >>> Run the main function
#===============================================================

# shellcheck disable=SC2034
function log::print2() {
  local colorName="${1:-${3}}"
  local icon="${2}"
  local level="${3}"
  local messageVariableName="${4}"
  local -n levelColor="VALET_CONFIG_COLOR_${colorName^^}"
  # evaluated the print statement built in log::init; it uses the local vars defined above
  eval "${GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG}"
}

VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
COLOR_DEBUG=ok
LEVEL=DEBUG
cl="COLOR_${LEVEL}"

# VALET_CONFIG_LOG_PATTERN="<colorFaded><time><colorDefault> <levelColor><level> <icon><colorDefault> PID=<pid>{05d} SHLVL=<subshell>{1d} <function>{8s}@<source>{-8s}:<line>{-3s}"$'\n'"<message>"

core::colorInit
log::init

echo "VALET_CONFIG_LOG_PATTERN=${VALET_CONFIG_LOG_PATTERN}"
echo "GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG=${GLOBAL_LOG_PRINT_STATEMENT_FORMATTED_LOG}"

function log::success2() {
  if ((${GLOBAL_LOG_LEVEL_INT:-1} > 2)); then
    return 0
  fi
  local IFS=$'\n'
  # shellcheck disable=SC2034
  local loggedLine="$*"
  log::print2 "SUCCESS" "${VALET_CONFIG_ICON_SUCCESS:-$'\uf14a'}" "SUCCESS" loggedLine
  return 0
}

function main() {
  log::success2 'Next up is a ⌜big line⌝ with a lot of numbers not separated by spaces. Which means they will be truncated by characters and not by word boundaries like this sentence.' '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567' '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567'
}


main

time::getProgramElapsedMicroseconds
START="${RETURNED_VALUE}"

time::getProgramElapsedMicroseconds
time::convertMicrosecondsToHuman "$((RETURNED_VALUE - START))"
echo "Human time: ${RETURNED_VALUE}"

# TEST=true
# function func1() {
#   if [[ -n ${TEST} ]]; then
#     :
#   fi
# }
# function func2() {
#   if [[ -v TEST ]]; then
#     :
#   fi
# }

# benchmark::run func1 func2

# progress::start
# progress::update 0 "Running test suites."

# JOB_NAMES=(name{1..30})
# JOB_COMMANDS=()
# for i in {1..30}; do
#   JOB_COMMANDS+=("sleep $((RANDOM % 3 + 1)); log::warning 'Job $i done'")
# done

# function callback() {
#   progress::update ${4} "Done running ⌜${2}⌝ at index ${1}: ${3}."
#   if [[ ${3} -eq 1 ]]; then
#     return 1
#   fi
# }

# bash::runInParallel JOB_NAMES JOB_COMMANDS 5 callback

# progress::stop
