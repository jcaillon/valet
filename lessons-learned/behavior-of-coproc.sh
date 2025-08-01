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
function inCoproc() {
  log::info "Main PID: ${GLOBAL_PROGRAM_MAIN_PID}"
  log::info "COPROC PID: ${BASHPID}"

  bash::getBuiltinOutput trap -p
  if [[ ${ORIGINAL_TRAPS} == "${REPLY}" ]]; then
    log::info "Inherited the traps."
  else
    log::error "Trap settings have changed:"$'\n'"${REPLY}"
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

  [[ -p /dev/fd/0 ]] && log::info "stdin is a pipe"
  [[ -t 0 ]] && log::info "stdout is a terminal"

  # print an initial message
  printf "%s" "hello"
  printf "%s\0" "world"

  local IFS='' instruction
  # read instructions from stdin
  while kill -0 "${GLOBAL_PROGRAM_MAIN_PID}"; do
    while kill -0 "${GLOBAL_PROGRAM_MAIN_PID}"; do
      read -rd $'\0' instruction || [[ -v instruction ]]
      if read -t 0 -rd $'\0'; then
        log::info "got instruction <${instruction}> but more instructions await"
        continue
      fi
      break
    done
    if [[ -n ${instruction} ]]; then
      log::info "instruction: ${instruction}"
    fi
    case "${instruction}" in
      "start")
        log::info "Starting"
        bash::sleep 1
        printf "%s\0" "started"
        ;;
      "stop")
        log::info "Stopping"
        break
        ;;
      *)
        log::info "Unknown instruction: ${instruction}"
        ;;
    esac
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


coproc _PROGRESS_COPROC_PIPES { inCoproc 2>&${LOG_FD}; }


log::info "_PROGRESS_COPROC_PIPES=${_PROGRESS_COPROC_PIPES[*]}"
log::info "_PROGRESS_COPROC_PIPES_PID=${_PROGRESS_COPROC_PIPES_PID}"

while ! kill -0 "${_PROGRESS_COPROC_PIPES_PID}" 2>/dev/null; do
  log::info "Waiting for the coproc to start..."
  bash::sleep 0.01
done

log::info "Waiting for the initial message..."
IFS=$'\0' read -u "${_PROGRESS_COPROC_PIPES[0]}" -rd $'\0' REPLY
log::info "Received: ${REPLY}"

log::info "Sending start command"
printf "%s\0" "start" >&"${_PROGRESS_COPROC_PIPES[1]}"

log::info "Waiting for response..."
IFS=$'\0' read -rd $'\0' REPLY <&"${_PROGRESS_COPROC_PIPES[0]}" || [[ -v REPLY ]]
log::info "Received: ${REPLY}"

log::info "Sending stop command"
printf "%s\0%s\0" "unknown" "stop" >&"${_PROGRESS_COPROC_PIPES[1]}"

sleep 1

# can check the variable _PROGRESS_COPROC_PIPES with -v to know if the coproc is still running
if [[ -v _PROGRESS_COPROC_PIPES ]]; then
  echo "Killing the coproc."
  kill "${_PROGRESS_COPROC_PIPES_PID}"
  if [[ -v _PROGRESS_COPROC_PIPES ]]; then
    echo "The coproc is still running."
  else
    echo "The coproc stopped with success."
  fi
else
  echo "The coproc already stopped with success."
fi



function inCoproc2() {
  log::info "COPROC PID: ${BASHPID}"
  ((10/0))
  log::warning "This line should not be reached."
}

coproc _PROGRESS_COPROC_PIPES2 { inCoproc2 2>&${LOG_FD}; }
{ coproc _PROGRESS_COPROC_PIPES3 { inCoproc2 2>&${LOG_FD}; } } 2>/dev/null

while true; do
  EXIT_STATUS=0
  wait -n -p COPROC_PID || EXIT_STATUS=$?
  if [[ -z ${COPROC_PID:-} ]]; then
    log::warning "No more coproc to wait for."
    break
  fi
  log::info "The coproc ${COPROC_PID} exited with status: ${EXIT_STATUS}"
done


function inCoproc3() {
  trap::register
  log::info "COPROC PID: ${BASHPID}"
  fzefzefze
  log::warning "This line should not be reached."
}

coproc _PROGRESS_COPROC_PIPES4 { inCoproc3 2>&${LOG_FD}; }
wait -n "${_PROGRESS_COPROC_PIPES4_PID}" || true


# CTRL+C will interrupt both the main process and a background job, but not a coproc.
#
function inCoproc4() {
  while true; do
    log::info "JOB Still going..."
    sleep 1 || true
  done
}
coproc _PROGRESS_COPROC_PIPES4 { inCoproc4 2>&${LOG_FD}; }
while true; do
  log::info "MAIN Still going..."
  sleep 1
done


log::info "# LESSONS LEARNED:

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