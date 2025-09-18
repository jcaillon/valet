#!/usr/bin/env bash
export VALET_VERBOSE=true
source "$(valet --source)"

include system string

string::getFormattedHeader "|middle|" width=50
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "|middle|right" width=50
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|" width=50
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left||" width=50
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "||right" width=50
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=50
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=17
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=16
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=15
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=14
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=13
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=12
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=11
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=10
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=9
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=8
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=7
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=6
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=5
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=4
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "left|middle|right" width=0
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "@|%|+" width=50 paddingChar="." paddingStyle=$'\e[1;34m' paddingStyleReset=$'\e[0m'
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"

string::getFormattedHeader "@|%|+" width=50 partWidths="4|6|5" paddingChar="." paddingStyle=$'\e[1;34m' paddingStyleReset=$'\e[0m'
REPLY="${REPLY//"@"/left}"
REPLY="${REPLY//"%"/middle}"
REPLY="${REPLY//"+"/right}"
printf '%-10s %s\n' "${REPLY2}" "${REPLY}"
