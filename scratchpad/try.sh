#!/usr/bin/env bash
export VALET_VERBOSE=true
source "$(valet --source)"

include system string time bash

string::getFormattedHeader "l${ESC__FG_BRIGHT_CYAN}ef${ESC__TEXT_RESET}t|mi${ESC__FG_BRIGHT_CYAN}dd${ESC__TEXT_RESET}le|ri${ESC__FG_BRIGHT_CYAN}gh${ESC__TEXT_RESET}t" width=10 paddingStyle=$'\e[1;34m' paddingStyleReset=$'\e[0m'

echo "${REPLY}"