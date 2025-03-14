#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include profiler

profiler::enable "./tmp/profiler.log"

echo "coucou ${BASHPID}, ${SHLVL}"
VAR=1

(
  echo "coucou2 ${BASHPID}, ${SHLVL}"
  VAR=2
)

profiler::disable

cat ./tmp/profiler.log