#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include bash

# shellcheck disable=SC2317
function inCoproc() {
  echo "ok2" 1>&2
  printf "%s" a
  printf "%s" b
  printf "%s" c
  printf "%s\0" d
  local IFS='' instruction
  # read instructions from stdin
  while true; do
    read -rd '' instruction || [[ -n ${instruction} ]] || instruction=""
    if [[ -n ${instruction} ]]; then
      echo "instruction: ${instruction}" 1>&2
    fi
    case "${instruction}" in
      "start")
        echo "Starting the progress bar." 1>&2
        ;;
      "update")
        echo "Updating the progress bar." 1>&2
        ;;
      *)
        ;;
    esac
  done
  echo "done" 1>&2
}

exec 4>&2
{ coproc _PROGRESS_COPROC_PIPES { inCoproc 2>&4; }  } 2>/dev/null
exec 4>&-
echo "The _PROGRESS_COPROC_PIPES coprocess array: ${_PROGRESS_COPROC_PIPES[*]}"

bash::sleep 1
echo "Sending command..."
printf "%s\0" "start" >&"${_PROGRESS_COPROC_PIPES[1]}"

bash::sleep 1

IFS='' read -rd '' RETURNED_VALUE <&"${_PROGRESS_COPROC_PIPES[0]}" || [[ -n ${RETURNED_VALUE} ]] || RETURNED_VALUE=""
echo "Received: ${RETURNED_VALUE}"

bash::sleep 1

kill "${_PROGRESS_COPROC_PIPES_PID}"

exit 0
