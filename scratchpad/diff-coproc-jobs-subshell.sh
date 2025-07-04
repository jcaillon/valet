#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
exec {LOG_FD}>&2
export VALET_CONFIG_LOG_FD=${LOG_FD}
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<pid>{04s}:<subshell>{1s}] <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"

source "libraries.d/core"
include bash

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
"

# shellcheck disable=SC2317
function inCoproc() {
  local mainProcessPID="${BASHPID}"
  log::info "Main PID: ${mainProcessPID}"
  log::info "COPROC PID: ${BASHPID}"

  [[ -p /dev/fd/0 ]] && log::info "stdin is a pipe"
  [[ -t 0 ]] && log::info "stdout is a terminal"

  # print an initial message
  printf "%s" "hello"
  printf "%s\0" "world"

  local IFS='' instruction
  # read instructions from stdin
  while kill -0 "${mainProcessPID}"; do
    while kill -0 "${mainProcessPID}"; do
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
        bash::sleep 2
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

MAIN_PID="${BASHPID}"
coproc _PROGRESS_COPROC_PIPES { inCoproc 2>&${LOG_FD}; }

log::info "PID: ${BASHPID}"
log::info "_PROGRESS_COPROC_PIPES=${_PROGRESS_COPROC_PIPES[*]}"
log::info "_PROGRESS_COPROC_PIPES_PID=${_PROGRESS_COPROC_PIPES_PID}"
sleep 10
if [[ -p /dev/fd/${_PROGRESS_COPROC_PIPES[0]} ]]; then
  log::info "The coproc pipes are valid."
else
  log::error "The coproc pipes are not valid."
fi

log::info "Waiting for the initial message..."
IFS=$'\0' read -u "${_PROGRESS_COPROC_PIPES[0]}" -rd $'\0' RETURNED_VALUE
log::info "Received: ${RETURNED_VALUE}"

log::info "Sending start command"
printf "%s\0" "start" >&"${_PROGRESS_COPROC_PIPES[1]}"

log::info "Waiting for response..."
IFS=$'\0' read -rd $'\0' RETURNED_VALUE <&"${_PROGRESS_COPROC_PIPES[0]}" || [[ -v RETURNED_VALUE ]]
log::info "Received: ${RETURNED_VALUE}"

log::info "Sending stop command"
printf "%s\0%s\0" "unknown" "stop" >&"${_PROGRESS_COPROC_PIPES[1]}"

bash::sleep 1

# can check the variable _PROGRESS_COPROC_PIPES with -v to know if the coproc is still running
if [[ -v _PROGRESS_COPROC_PIPES ]]; then
  echo "Killing the coproc."
  kill "${_PROGRESS_COPROC_PIPES_PID}"
  bash::sleep 1
  if [[ -v _PROGRESS_COPROC_PIPES ]]; then
    echo "The coproc is still running."
  else
    echo "The coproc stopped with success."
  fi
else
  echo "The coproc already stopped with success."
fi

exit 0
