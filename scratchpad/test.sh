#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark progress bash time

time::startTimer
VALET_CONFIG_DISABLE_ESC_CODES=true

for((i=0;i<1;i++)); do
  builtin source "libraries.d/lib-ansi-codes"
  builtin source "libraries.d/lib-styles"
done

time::getTimerValue true
