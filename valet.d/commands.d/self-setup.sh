#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../lib-interactive
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
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  log::info "Now setting up Valet."

  printf '%s\n' "─────────────────────────────────────"
  printf '%s\n' "${VALET_CONFIG_COLOR_INFO:-$'\e'"[0;36m"}This is a COLOR CHECK, this line should be COLORED (in cyan by default).${VALET_CONFIG_COLOR_DEFAULT:-$'\e'"[0m"}"
  printf '%s\n' "${VALET_CONFIG_COLOR_SUCCESS:-$'\e'"[0;32m"}This is a COLOR CHECK, this line should be COLORED (in green by default).${VALET_CONFIG_COLOR_DEFAULT:-$'\e'"[0m"}"
  printf '%s\n' "─────────────────────────────────────"

  if interactive::promptYesNo "Do you see the colors in the color check above the line?"; then
    export VALET_CONFIG_ENABLE_COLORS=true
  else
    export VALET_CONFIG_ENABLE_COLORS=false
  fi
  log::createPrintFunction
  eval "${GLOBAL_LOG_PRINT_FUNCTION}"

  printf '%s\n' "─────────────────────────────────────"
  printf '%s\n' "This is a nerd icon check, check out the next lines:"
  printf '%s\n' "A cross within a square: ${VALET_CONFIG_ICON_ERROR:-$'\uf2d3'}"
  printf '%s\n' "A warning sign: ${VALET_CONFIG_ICON_WARNING:-$'\uf071'}"
  printf '%s\n' "A checked box: ${VALET_CONFIG_ICON_SUCCESS:-$'\uf14a'}"
  printf '%s\n' "An information icon: ${VALET_CONFIG_ICON_INFO:-$'\uf05a'}"
  printf '%s\n' "─────────────────────────────────────"

  if ! interactive::promptYesNo "Do you correctly see the nerd icons in the icon check above the line?" false; then
    log::info "If you see the replacement character ? in my terminal, it means you don't have a nerd-font setup in your terminal." \
    "You can download any font here: https://www.nerdfonts.com/font-downloads and install it." \
    "After that, you need to setup your terminal to use this newly installed font." \
    "You can run the command ⌜valet self setup⌝ again after that."
    export VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
  else
    export VALET_CONFIG_ENABLE_NERDFONT_ICONS=true
  fi
  log::createPrintFunction
  eval "${GLOBAL_LOG_PRINT_FUNCTION}"

  # generate the config
  core::sourceFunction selfConfig
  selfConfig --export-current-values --no-edit --override

  log::success "You are all set!"

  # tell the user about what's next todo
  log::info "As a reminder, you can modify the configuration done during this set up by either:"$'\n'"- replaying the command ⌜valet self setup⌝,"$'\n'"- running the command ⌜valet self config⌝."
  log::info "Run ⌜valet --help⌝ to get started."
  log::info "You can create your own commands and have them available in valet, please check https://jcaillon.github.io/valet/docs/new-commands/ to do so."
}