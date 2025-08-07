#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

# shellcheck source=../libraries.d/lib-interactive
source interactive
# shellcheck source=../libraries.d/lib-system
source system

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
  command::parseArguments "$@" && eval "${REPLY}"
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

  log::info "If you see an unusual or ? character in the lines below, it means you don't have a nerd-font setup in your terminal."$'\n'"You can download a nerd-font here: https://www.nerdfonts.com/font-downloads."

  printf '%s\n' "─────────────────────────────────────"
  printf '%s\n' "This is a nerd icon check, check out the next lines:"
  printf '%s\n' "A cross within a square: "$'\uf2d3'
  printf '%s\n' "A warning sign: "$'\uf071'
  printf '%s\n' "A checked box: "$'\uf14a'
  printf '%s\n' "An information icon: "$'\uf05a'
  printf '%s\n' "─────────────────────────────────────"

  if ! interactive::promptYesNo "Do you correctly see the nerd icons in lines above?" default=false; then
    log::info "You can download any font here: https://www.nerdfonts.com/font-downloads and install it."$'\n'"After that, you need to setup your terminal to use this newly installed font."$'\n'"You can then run the command ⌜valet self setup⌝ again to set up the use of this font."
    VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
  else
    VALET_CONFIG_ENABLE_NERDFONT_ICONS=true
  fi
  styles::init
  log::init

  # generate the config
  command::sourceFunction selfConfig
  selfConfig --export-current-values --no-edit --override

  # on windows, we can add the installation path to the windows PATH
  if system::isWindows && interactive::promptYesNo "Valet can be setup to be called from the windows CMD or windows powershell."$'\n'"Do you want to add Valet to your windows PATH?" default=false; then
    selfSetup_setupForWindows
  fi

  log::success "You are all set!"
}

# Add the valet install dir to the windows PATH
# + set VALET_WIN_BASH
# + set VALET_WIN_INSTALLATION_DIRECTORY.
function selfSetup_setupForWindows() {
  # shellcheck source=../libraries.d/lib-windows
  source windows
  # shellcheck source=../libraries.d/lib-fs
  source fs

  local linuxInstallationPath="${GLOBAL_INSTALLATION_DIRECTORY}"
  fs::toAbsolutePath "${linuxInstallationPath}" realpath=true
  windows::convertPathFromUnix "${REPLY}"
  local windowsInstallationPath="${REPLY}"

  local linuxBashPath="${BASH}"
  fs::toAbsolutePath "${linuxBashPath}" realpath=true
  windows::convertPathFromUnix "${REPLY}"
  local windowsBashPath="${REPLY}"

  log::info "Setting the windows variable VALET_WIN_BASH to ⌜${windowsBashPath}⌝."
  windows::setEnvVar VALET_WIN_BASH "${windowsBashPath}"

  log::info "Setting the windows variable VALET_WIN_INSTALLATION_DIRECTORY to ⌜${windowsInstallationPath}⌝."
  windows::setEnvVar VALET_WIN_INSTALLATION_DIRECTORY "${windowsInstallationPath}"

  log::info "Adding ⌜${windowsInstallationPath}⌝ to the user windows PATH."
  windows::addToPath "${windowsInstallationPath}"
}