#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_LOG_LEVEL="debug"
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<pid>{04d}:<subshell>{1s}]   <colorFaded><sourceFile>{-5s}:<line>{-4s}<colorDefault>  <levelColor><icon><level>{-4s} <colorDefault> <message>"

# shellcheck source=../libraries.d/main
source "$(valet --source)"
include tui

tui::test

panes=(
  "_COPROC_NAME pane1_options" # first pane
)
pane1_options=(left=0 top=0 width=20 height=10 disableLeftBorder=false disableRightBorder=false disableTopBorder=false disableBottomBorder=false headerText="" footerText="")