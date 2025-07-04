#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
exec {LOG_FD}>&2
export VALET_CONFIG_LOG_FD=${LOG_FD}
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<pid>{04s}:<subshell>{1s}] <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"

source "libraries.d/core"
include bash

log::info "LESSONS LEARNED:

- if the main process exits, the coproc does not exit! We must check if the main process is still running inside the coproc.
"

# shellcheck disable=SC2317
function myJob() {
  log::info "JOB PID: ${BASHPID}"

  bash::getBuiltinOutput trap -p
  if [[ ${ORIGINAL_TRAPS} == "${RETURNED_VALUE}" ]]; then
    log::info "Inherited the traps."
  else
    log::error "Trap settings have changed."
  fi
  bash::getBuiltinOutput shopt -p
  if [[ ${ORIGINAL_SHOPT} == "${RETURNED_VALUE}" ]]; then
    log::info "Inherited the shopt settings."
  else
    log::error "Shopt settings have changed."
  fi
  bash::getBuiltinOutput shopt -p -o
  if [[ ${ORIGINAL_SET} == "${RETURNED_VALUE}" ]]; then
    log::info "Inherited the set options."
  else
    log::error "Set options have changed."
  fi
  trap::register
  exit 1

  while true; do
    log::info "Still going..."
    sleep 1
  done

  log::info "done"
}

log::info "PID: ${BASHPID}"
bash::getBuiltinOutput trap -p
ORIGINAL_TRAPS="${RETURNED_VALUE}"
bash::getBuiltinOutput shopt -p
ORIGINAL_SHOPT="${RETURNED_VALUE}"
bash::getBuiltinOutput shopt -p -o
ORIGINAL_SET="${RETURNED_VALUE}"


myJob &
MY_JOB_PID="${!}"

log::info "MY_JOB_PID=${MY_JOB_PID}"
sleep 5

log::info "Stopping main..."
kill -SIGHUP "${MY_JOB_PID}" || true

exit 0
