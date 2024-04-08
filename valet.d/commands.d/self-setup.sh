#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> command: self setup
#===============================================================

: "---
command: self setup
function: selfSetup
author: github.com/jcaillon
shortDescription: The command run after the installation of Valet to setup the tool.
description: |-
  The command run after the installation of Valet to setup the tool.

  Adjust the Valet configuration according to the user environment.
  Let the user know what to do next.
---"
function selfSetup() {
  log::info "Now setting up Valet."

  echo "─────────────────────────────────────"
  echo $'\e'"[0;36mThis is a COLOR CHECK, this line should be COLORED (in cyan by default)."$'\e'"[0m"
  echo $'\e'"[0;32mThis is a COLOR CHECK, this line should be COLORED (in green by default)."$'\e'"[0m"
  echo "─────────────────────────────────────"

  if ! interactive::promptYesNo "Do you see the colors in the color check above the line?"; then
    export VALET_CONFIG_DISABLE_COLORS=true
    log::createPrintFunction
    eval "${LOG_LINE_FUNCTION}"
  fi

  echo "─────────────────────────────────────"
  echo "This is a nerd icon check, check out the next lines:"
  echo "A cross within a square: "$'\uf2d3'
  echo "A warning sign: "$'\uf071'
  echo "A checked box: "$'\uf14a'
  echo "An information icon: "$'\uf05a'
  echo "─────────────────────────────────────"

  if ! interactive::promptYesNo "Do you correctly see the nerd icons in the icon check above the line?"; then
    log::info "If you see the replacement character ? in my terminal, it means you don't have a nerd-font setup in your terminal."$'\n'"You can download any font here: https://www.nerdfonts.com/font-downloads and install it."$'\n'"After that, you need to setup your terminal to use this newly installed font."

    if interactive::promptYesNo "Do you want to disable the icons in Valet?"; then
      export VALET_CONFIG_DISABLE_NERDFONT_ICONS=true
      log::createPrintFunction
      eval "${LOG_LINE_FUNCTION}"
    fi
  fi

  # TODO: verify if /dev/shm is available and suggest to use it for the work files

  # TODO: verify that we have all the external tools we need:
  # awk for the profiler
  # diff for the self test
  # curl for the self update

  core::sourceForFunction selfConfig
  selfConfig --no-edit

  log::success "You are all set!"

  # tell the user about what's next todo
  log::info "As a reminder, you can modify the configuration done during this set up by either:"$'\n'"- replaying the command ⌜valet self setup⌝,"$'\n'"- editing the valet config file located at ⌜${VALET_CONFIG_FILE}⌝,"$'\n'"- or setting the environment variables directly in your shell or in your .bashrc file."
  log::info "You can now run ⌜valet --help⌝ to get started."
  log::info "You can create your own commands and have them available in valet, please check ⌜https://github.com/jcaillon/valet/blob/main/docs/create-new-command.md⌝ to do so."
}