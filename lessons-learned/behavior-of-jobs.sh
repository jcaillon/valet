#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
exec {LOG_FD}>&2
export VALET_CONFIG_LOG_FD=${LOG_FD}
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<subshell>{1s}] <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"

# shellcheck source=../libraries.d/main
source "$(valet --source)"
include bash

# shellcheck disable=SC2317
function trap::onCleanUp() {
  log::warning "Cleaning up..."
}

# shellcheck disable=SC2317
function myJob() {
  log::info "JOB PID: ${BASHPID}"

  bash::getBuiltinOutput trap -p
  if [[ ${ORIGINAL_TRAPS} == "${REPLY}" ]]; then
    log::info "Inherited the traps."
  else
    log::error "Trap settings have changed."
  fi
  bash::getBuiltinOutput shopt -p
  if [[ ${ORIGINAL_SHOPT} == "${REPLY}" ]]; then
    log::info "Inherited the shopt settings."
  else
    log::error "Shopt settings have changed."
  fi
  bash::getBuiltinOutput shopt -p -o
  if [[ ${ORIGINAL_SET} == "${REPLY}" ]]; then
    log::info "Inherited the set options."
  else
    log::error "Set options have changed."
  fi
  trap::register

  while true; do
    log::info "Still going..."
    sleep 1
  done

  log::info "done"
}

log::info "PID: ${BASHPID}"
bash::getBuiltinOutput trap -p
ORIGINAL_TRAPS="${REPLY}"
bash::getBuiltinOutput shopt -p
ORIGINAL_SHOPT="${REPLY}"
bash::getBuiltinOutput shopt -p -o
ORIGINAL_SET="${REPLY}"

myJob &
MY_JOB_PID="${!}"

log::info "MY_JOB_PID=${MY_JOB_PID}"
sleep 2

log::info "Stopping main..."
kill -SIGHUP "${MY_JOB_PID}" || true

sleep 1

# shellcheck disable=SC2317
function myJob2() {
  log::info "JOB PID: ${BASHPID}"
  ((10/0))
  log::info "this line should not be reached"
}

myJob2 &

log::info "the job correctly stops on error but does not correctly execute the EXIT trap for unknown reasons ???"

# shellcheck disable=SC2317
function myJob3() {
  log::info "JOB PID: ${BASHPID}"
  trap::register
  ((10/0))
  log::info "this line should not be reached"
}

myJob3 &
MY_JOB_PID="${!}"

log::info "we can re-register the EXIT trap to make it execute"

wait "${MY_JOB_PID}" || true


# CTRL+C will interrupt the main script and the job.
#
# function myJob4() {
#   while true; do
#     log::info "JOB Still going..."
#     sleep 1
#   done
# }
# myJob4 &
# while true; do
#   log::info "MAIN Still going..."
#   sleep 1
# done


log::info "LESSONS LEARNED:

- if the main process exits, the coproc (same for background jobs) does not exit:
  - When we exit an interactive shell, a SIGHUP will be sent to the shell process which forwards it to
    all its children processes, including the coproc/jobs.
  - But in the case of a script, we start a new bash process for the script which in turns starts
    processes for coproc/jobs, the SIGHUP is not sent automatically to the coproc/jobs when the script ends
    (it only happens at the end of an interactive shell session).
    Coproc/jobs will no longer have the PPID of the bash script but will be assigned the PPID 1
    which is the init process. This is actually a way to 'daemonize' a process (detaching it from the terminal).
    This technical is called 'double fork' and can also be replaced by using the builtin 'disown' command.
  - We must check if the main process is still running inside the coproc or we must kill
    all the coproc/jobs when the main script exits.
- traps, shopt settings, set options, etc... are inherited from the parent shell but the exit trap is not executed
  on error! If we re register the EXIT trap in the coproc/job, it will be executed on error.
  So it is better to re-register the EXIT trap in the coproc/job for consistent behavior.
- coproc behaves like a background job; expect that is does not inherit the SIGINT trap.
  CTRL+C will interrupt both the main process and a background job, but not a coproc.
"