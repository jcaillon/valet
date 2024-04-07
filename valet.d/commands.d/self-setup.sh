#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet)
if [[ -z "${_CORE_INCLUDED:-}" ]]; then
  VALETD_DIR="${BASH_SOURCE[0]}"
  if [[ "${VALETD_DIR}" != /* ]]; then
    if pushd "${VALETD_DIR%/*}" &>/dev/null; then VALETD_DIR="${PWD}"; popd &>/dev/null || true;
    else VALETD_DIR="${PWD}"; fi
  else VALETD_DIR="${VALETD_DIR%/*}"; fi
  # shellcheck source=../core
  source "${VALETD_DIR%/*}/core"
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
  log::info "Valet has been successfully installed."

  local valetConfigFileContent
  local answer

  log::info "Now running test with you to set up Valet."

  echo "─────────────────────────────────────"
  echo $'\e'"[0;36mThis is a COLOR CHECK, this line should be COLORED (in cyan by default)."$'\e'"[0m"
  echo $'\e'"[0;32mThis is a COLOR CHECK, this line should be COLORED (in green by default)."$'\e'"[0m"
  echo "─────────────────────────────────────"

  echo "Do you see the colors in the color check above the line?"
  interactive::promptYesNo "Answer 'yes' if you see the colors."$'\n'"Answer 'no' if you don't see any colors."
  answer="${LAST_RETURNED_VALUE}"
  log::info "You answered: ${answer}."

  if [[ ${answer} == "false" ]]; then
    export VALET_NO_COLOR=true
    log::createPrintFunction
    eval "${LOG_LINE_FUNCTION}"
    valetConfigFileContent+="VALET_NO_COLOR=true"$'\n'
  fi

  echo "─────────────────────────────────────"
  echo "This is a nerd icon check, check out the next lines:"
  echo "A cross within a square: "$'\uf2d3'
  echo "A warning sign: "$'\uf071'
  echo "A checked box: "$'\uf14a'
  echo "An information icon: "$'\uf05a'
  echo "─────────────────────────────────────"

  echo "Do you correctly see the nerd icons in the icon check above the line?"
  interactive::promptYesNo "Answer 'yes' if you see the icons."$'\n'"Answer 'no' if you see ? or anything else instead of the icons."
  answer="${LAST_RETURNED_VALUE}"
  log::info "You answered: ${answer}."

  if [[ ${answer} == "false" ]]; then
    log::info "If you see the replacement character ? in my terminal, it means you don't have a nerd-font setup in your terminal."$'\n'"You can download any font here: https://www.nerdfonts.com/font-downloads and install it."$'\n'"After that, you need to setup your terminal to use this newly installed font."

    echo "Do you want to disable the icons in Valet?"
    interactive::promptYesNo "Answer 'yes' to disable the icons."$'\n'"Answer 'no' if you plan to install a nerd font."
    answer="${LAST_RETURNED_VALUE}"
    log::info "You answered: ${answer}."

    if [[ ${answer} == "true" ]]; then
      export VALET_NO_ICON=true
      log::createPrintFunction
      eval "${LOG_LINE_FUNCTION}"
      valetConfigFileContent+="VALET_NO_ICON=true"$'\n'
    fi
  fi

  if [[ -n "${valetConfigFileContent:-}" ]]; then
    log::info "Based on your answers, the following configuration will be added to your valet config file:"$'\n'"${valetConfigFileContent}"
    log::info "The valet config file is located at ⌜${VALET_USER_CONFIG_FILE}⌝."

    echo "Do you want to apply this configuration?"
    interactive::promptYesNo "Answer 'yes' to apply the configuration."$'\n'"Answer 'no' to skip this step."
    answer="${LAST_RETURNED_VALUE}"
    log::info "You answered: ${answer}."
    if [[ ${answer} == "true" ]]; then
      mkdir -p "${VALET_USER_CONFIG_FILE%/*}" 1>/dev/null || log::error "Could not create the valet config directory ⌜${VALET_USER_CONFIG_FILE%/*}⌝."
      echo "${valetConfigFileContent}" >>"${VALET_USER_CONFIG_FILE}"
      log::info "The configuration has been applied."
    fi
  fi

  # TODO: verify if /dev/shm is available and suggest to use it for the work files

  log::success "The setup is complete!"

  # TODO: verify that we have all the external tools we need:
  # awk for the profiler
  # diff for the self test
  # curl for the self update

  log::success "You are all set!"

  # tell the user about what's next todo
  log::info "You can now run ⌜valet --help⌝ to get started."
  log::info "You can create your own commands and have them available in valet, please check ⌜https://github.com/jcaillon/valet/blob/main/docs/create-new-command.md⌝ or the examples under examples.d to do so."

}

# if this script is run directly, execute the function, otherwise valet will do it
if [[ ${NOT_EXECUTED_FROM_VALET:-false} == "true" ]]; then
  selfUpdate "$@"
fi
