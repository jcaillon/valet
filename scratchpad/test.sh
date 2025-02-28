#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark progress bash time

_BASH_TEMPORARY_STDOUT_FILE=/tmp/temporary-stdout
function runAndCaptureOutput() {
    # shellcheck disable=SC2068
    ${@} &>"${_BASH_TEMPORARY_STDOUT_FILE}" || return 1
    RETURNED_VALUE=""
    IFS='' read -rd '' RETURNED_VALUE <"${_BASH_TEMPORARY_STDOUT_FILE}" || echo "ok"
    printf "%q" "${IFS}"
}

runAndCaptureOutput jobs

printf "%q" "${IFS}"

time::startTimer

for((i=0;i<100;i++)); do
  builtin source "libraries.d/esc-codes"
  builtin source "libraries.d/styles"
done

time::getTimerValue true
