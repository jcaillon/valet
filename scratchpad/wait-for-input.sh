#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include tui

tui::testWaitForKeyPress
