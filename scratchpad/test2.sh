#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include benchmark progress bash time coproc

log::setLevel debug
