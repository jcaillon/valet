#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ ! -v GLOBAL_CORE_INCLUDED ]]; then
  # shellcheck source=../libraries.d/core
  source "$(valet --source)"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../libraries.d/lib-interactive
source interactive

#===============================================================
# >>> command: self setup
#===============================================================

: "---
command: self setup
function: selfSetup
hideInMenu: true
author: github.com/jcaillon
shortDescription: The command run after the installation of Valet to setup the tool.
description: |-
  The command run after the installation of Valet to setup the tool.

  Adjust the Valet configuration according to the user environment.
  Let the user know what to do next.
---"
function selfSetup() {
  command::parseArguments "$@" && eval "${RETURNED_VALUE}"
  command::checkParsedResults

  log::info "Now setting up Valet."

  printf '%s\n' "─────────────────────────────────────"
  printf '%s\n' $'\e'"[0;36mThis is a COLOR CHECK, this line should be COLORED (in cyan by default)."$'\e'"[0m"
  printf '%s\n' $'\e'"[0;32mThis is a COLOR CHECK, this line should be COLORED (in green by default)."$'\e'"[0m"
  printf '%s\n' "─────────────────────────────────────"

  if interactive::promptYesNo "Do you see the colors in the color check above the line?"; then
    VALET_CONFIG_ENABLE_COLORS=true
  else
    VALET_CONFIG_ENABLE_COLORS=false
  fi
  styles::init
  log::init

  printf '%s\n' "─────────────────────────────────────"
  printf '%s\n' "This is a nerd icon check, check out the next lines:"
  printf '%s\n' "A cross within a square: "$'\uf2d3'
  printf '%s\n' "A warning sign: "$'\uf071'
  printf '%s\n' "A checked box: "$'\uf14a'
  printf '%s\n' "An information icon: "$'\uf05a'
  printf '%s\n' "─────────────────────────────────────"

  if ! interactive::promptYesNo "Do you correctly see the nerd icons in the icon check above the line?" false; then
    log::info "If you see the replacement character ? in my terminal, it means you don't have a nerd-font setup in your terminal." \
    "You can download any font here: https://www.nerdfonts.com/font-downloads and install it." \
    "After that, you need to setup your terminal to use this newly installed font." \
    "You can run the command ⌜valet self setup⌝ again after that."
    VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
  else
    VALET_CONFIG_ENABLE_NERDFONT_ICONS=true
  fi
  styles::init
  log::init

  # generate the config
  command::sourceFunction selfConfig
  selfConfig --export-current-values --no-edit --override

  log::success "You are all set!"
}