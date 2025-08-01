#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include benchmark progress bash time

_BASH_TEMPORARY_STDOUT_FILE=/tmp/temporary-stdout
function runAndCaptureOutput() {
    # shellcheck disable=SC2068
    ${@} &>"${_BASH_TEMPORARY_STDOUT_FILE}" || return 1
    REPLY=""
    IFS='' read -rd '' REPLY <"${_BASH_TEMPORARY_STDOUT_FILE}" || echo "ok"
    printf "%q" "${IFS}"
}

runAndCaptureOutput jobs

printf "%q" "${IFS}"

time::startTimer

for((i=0;i<100;i++)); do
  builtin source "libraries.d/core-esc-codes"
  builtin source "libraries.d/core-styles"
done

_OPTION_LOG_ELAPSED_TIME=true time::getTimerMicroseconds
