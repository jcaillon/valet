#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include bash

exec 60>&2
echo "zefgzefze" >&60
# exec 2>/dev/null
[[ -t 2 ]] && echo "a terminal"
[[ -t 60 ]] && echo "60 a terminal"

# shellcheck disable=SC2317
function inCoproc() {
  echo "coucou" >&60

  hash -x
  echo "COPROC: coproc started" 1>&2
  # print an initial message
  printf "%s" a
  printf "%s" b
  printf "%s" c
  printf "%s\0" d

  local IFS='' instruction
  # read instructions from stdin
  while true; do
    while true; do
      read -rd '' instruction || [[ -v instruction ]]
      if read -t 0 -rd ''; then
        echo "COPROC: got instruction <${instruction}> but more instructions await" 1>&2
        continue
      fi
      break
    done
    if [[ -n ${instruction} ]]; then
      echo "COPROC: instruction: ${instruction}" 1>&2
    fi
    case "${instruction}" in
      "start")
        echo "COPROC: Starting" 1>&2
        bash::sleep 1
        printf "%s\0" "started"
        ;;
      "stop")
        echo "COPROC: Stopping" 1>&2
        break
        ;;
      *)
        echo "COPROC: Unknown instruction: ${instruction}" 1>&2
        ;;
    esac
  done
  echo "COPROC: done" 1>&2
}

exec 4>&2
{ coproc _PROGRESS_COPROC_PIPES { inCoproc 2>&4; } } 2>/dev/null
exec 4>&-
echo "MAIN: _PROGRESS_COPROC_PIPES=${_PROGRESS_COPROC_PIPES[*]}"
echo "MAIN: _PROGRESS_COPROC_PIPES_PID=${_PROGRESS_COPROC_PIPES_PID}"

IFS='' read -rd '' RETURNED_VALUE <&"${_PROGRESS_COPROC_PIPES[0]}" || [[ -v RETURNED_VALUE ]]
echo "MAIN: Received: ${RETURNED_VALUE}"

echo "MAIN: Sending start command"
printf "%s\0" "start" >&"${_PROGRESS_COPROC_PIPES[1]}"

echo "MAIN: Waiting for response..."
IFS='' read -rd '' RETURNED_VALUE <&"${_PROGRESS_COPROC_PIPES[0]}" || [[ -v RETURNED_VALUE ]]
echo "MAIN: Received: ${RETURNED_VALUE}"

echo "Sending stop command"
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
