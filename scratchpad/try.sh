#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_LOG_LEVEL="debug"
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<pid>{04d}:<subshell>{1s}]   <colorFaded><sourceFile>{-5s}:<line>{-4s}<colorDefault>  <levelColor><level>{-4s} <colorDefault> <message>"


source "libraries.d/core"
include tui coproc

fu=${fu1:-} || :