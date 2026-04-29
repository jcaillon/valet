#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

# shellcheck source=../libraries.d/lib-interactive
source interactive
# shellcheck source=../libraries.d/lib-system
source system
# shellcheck source=../libraries.d/lib-exe
source exe
# shellcheck source=../libraries.d/lib-bash
source bash

#===============================================================
# >>> command: self setup
#===============================================================

: <<"COMMAND_YAML"
command: self setup
function: selfSetup
hideInMenu: true
author: github.com/jcaillon
shortDescription: The command run after the installation of Valet to setup the tool.
description: |-
  The command run after the installation of Valet to setup the tool.

  This command will do the following (with user approval for each step):

  - Copy the showcase to the user extensions directory.
  - Create a shim/proxy script in `~/.local/bin` or `~/bin` that points to the valet script.
  - Add the Valet directory to the user PATH by editing the shell startup files.
  - Add the Valet directory to the windows PATH if on windows.
  - Adjust the Valet configuration according to the user environment.
  - If the current user is root and the option is given, make Valet available for all users.
    (set read permissions for all users on Valet files and directories and create a shim in /usr/local/bin).
  - Let the user know what to do next.

options:
- name: --unattended
  description: |-
    Do not enter interactive mode for the setup (skip all actions except those explicitly specified).
- name: --copy-showcase
  description: |-
    Copy the showcase to the user extensions directory.
- name: --create-shim
  description: |-
    Create a shim/proxy script in `~/.local/bin` or `~/bin` (if one of them is in your PATH) that points to the valet script.
- name: --add-to-path
  description: |-
    Add the Valet directory to the user PATH by editing the shell startup files.
- name: --setup-for-windows
  description: |-
    Add the Valet directory to the windows PATH if on windows and set the VALET_WIN_BASH and VALET_WIN_INSTALLATION_DIRECTORY windows environment variables.
- name: --global-installation
  description: |-
    If the current user is root and the option is given, make Valet available for all users (set read permissions for all users on Valet files and directories and create a shim in /usr/local/bin).
COMMAND_YAML
function selfSetup() {
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  log::info "Now setting up Valet."

  selfSetup_checkColors "${unattended:-false}"

  selfSetup_checkNerdFontIcons "${unattended:-false}"

  selfSetup_installShowcase "${unattended:-false}" "${copyShowcase:-false}"

  selfSetup_createShim "${unattended:-false}" "${createSystemShim:-false}"
  local shimCreated="${REPLY}"

  selfSetup_addValetToPath "${unattended:-false}" "${shimCreated:-false}" "${addToPath:-false}"
  local addedToPath="${REPLY}"

  selfSetup_setupForWindows "${unattended:-false}" "${setupForWindows:-false}"

  if [[ ${EUID:-"-1"} == "0" ]]; then
    selfSetup_globalInstallation "${unattended:-false}" "${globalInstallation:-false}"
    if [[ ${shimCreated} != "true" ]]; then
      shimCreated="${REPLY}"
    fi
  fi

  # generate the config
  command::sourceFunction selfConfig
  selfConfig --export-current-values --no-edit --override

  local greetingMessage=""
  if [[ ${unattended:-} != "true" ]]; then
    greetingMessage=$'\n'$'\n'"To get started, use ⌜valet --help⌝."
  fi

  if [[ ${shimCreated:-} != "true" ]]; then
    if [[ ${addedToPath:-} == "true" ]]; then
      log::warning "Valet has been added to your PATH but it will only be available in new shell sessions."$'\n'"Please login again to apply the changes on your current shell or call valet directly with ⌜${GLOBAL_INSTALLATION_DIRECTORY}/valet⌝.${greetingMessage}"
    else
      if bash::getBuiltinOutput command -v valet && [[ ${REPLY%%$'\n'} == "${GLOBAL_INSTALLATION_DIRECTORY}/valet" ]]; then
        log::debug "Valet is already in the PATH."
      else
        log::warning "Valet is not in your PATH yet. You need to add ⌜${GLOBAL_INSTALLATION_DIRECTORY}⌝ to your PATH or call valet directly with ⌜${GLOBAL_INSTALLATION_DIRECTORY}/valet⌝.${greetingMessage}"
      fi
    fi
  else
    log::success "You are all set!${greetingMessage}"
  fi
}

function selfSetup_checkColors() {
  local unattended="${1}"

  local previousState="${VALET_CONFIG_ENABLE_COLORS:-}"

  if [[ ${unattended:-} != "true" ]]; then
    if interactive::confirm "Do you see "$'\e[46m'"t"$'\e[43m'"h"$'\e[42m'"i"$'\e[45m'"s"$'\e[0m'" "$'\e[36m'"t"$'\e[33m'"e"$'\e[32m'"x"$'\e[35m'"t"$'\e[0m'" in colors?" default="${previousState:-false}"; then
      VALET_CONFIG_ENABLE_COLORS=true
    else
      VALET_CONFIG_ENABLE_COLORS=false
    fi
  fi

  if [[ ${previousState:-} != "${VALET_CONFIG_ENABLE_COLORS:-}" ]]; then
    log::debug "The value of VALET_CONFIG_ENABLE_COLORS has been changed, reinitializing styles and log system."
    styles::init
    log::reload
  fi
}

function selfSetup_checkNerdFontIcons() {
  local unattended="${1}"

  local previousState="${VALET_CONFIG_ENABLE_NERDFONT_ICONS:-}"

  if [[ ${unattended:-} != "true" ]]; then
    log::info "Valet can use a nerd-font to improve your terminal experience."$'\n'"You can download a nerd-font here: https://www.nerdfonts.com/font-downloads."
  fi

  if [[ ${unattended:-} != "true" ]]; then
    if interactive::confirm "Do you correctly see the icons in this prompt? "$'\uf14a'" "$'\uf05a'" "$'\uf059'" " default="${previousState:-false}"; then
      VALET_CONFIG_ENABLE_NERDFONT_ICONS=true
    else
      log::info "You can download any font here: https://www.nerdfonts.com/font-downloads and install it."$'\n'"After that, you need to setup your terminal to use this newly installed font."$'\n'"You can then run the command ⌜valet self setup⌝ again to set up the use of this font."
      VALET_CONFIG_ENABLE_NERDFONT_ICONS=false
    fi
  fi

  if [[ ${previousState:-} != "${VALET_CONFIG_ENABLE_NERDFONT_ICONS:-}" ]]; then
    log::debug "The value of VALET_CONFIG_ENABLE_NERDFONT_ICONS has been changed, reinitializing styles and log system."
    styles::init
    log::reload
  fi
}

function selfSetup_installShowcase() {
  local \
    unattended="${1}" \
    copyShowcase="${2}"

  log::debug "Installing the showcase (command examples) in the extensions directory."

  core::getExtensionsDirectory
  local extensionsDirectory="${REPLY}"

  local showcaseDirectory="${extensionsDirectory}/showcase.d"
  local showcasePromptMessage
  if [[ -d ${showcaseDirectory} ]]; then
    showcasePromptMessage="The showcase (command examples) already exists in your extensions directory ⌜${showcaseDirectory}⌝."$'\n'"Do you want to override it with the latest version?"
  else
    showcasePromptMessage="Valet comes with a showcase (command examples) that can be copied to your extensions directory ⌜${showcaseDirectory}⌝."$'\n'"Do you want to copy it now?"
  fi

  if [[ ${copyShowcase:-} == "true" ]] || ([[ ${unattended:-} != "true" ]] && interactive::confirm "${showcasePromptMessage}" default=true); then
    exe::invoke command mkdir -p "${extensionsDirectory}" --- failMessage="Could not create the extensions directory ⌜${extensionsDirectory}⌝."
    if [[ -d "${showcaseDirectory}" ]]; then
      exe::invoke command rm -Rf "${showcaseDirectory}" --- failMessage="Could not remove the existing showcase (command examples) in ⌜${extensionsDirectory}⌝."
    fi
    exe::invoke command cp -R "${GLOBAL_INSTALLATION_DIRECTORY}/showcase.d" "${extensionsDirectory}" --- failMessage="Could not copy the showcase (command examples) to ⌜${extensionsDirectory}⌝."

    log::success "The showcase (command examples) has been copied to your extensions directory ⌜${showcaseDirectory}⌝."
  fi
}

function selfSetup_createShim() {
  local \
    unattended="${1}" \
    createSystemShim="${2}"

  log::debug "Add valet to the PATH or create a shim in a directory already in the PATH."

  local shimDirectory="${HOME}/.local/bin"
  if ! system::isDirectoryInPath "${shimDirectory}"; then
    shimDirectory="${HOME}/bin"
    if ! system::isDirectoryInPath "${shimDirectory}"; then
      shimDirectory=""
    fi
  fi

  if [[ -z ${shimDirectory} ]]; then
    REPLY="false"
    return 0
  fi

  # create the shim in the bin directory
  local valetBin="${shimDirectory}/valet"

  if [[ ${createShim:-} == "true" ]] || ([[ ${unattended:-} != "true" ]] && interactive::confirm "Do you want to create a shim script in ⌜${shimDirectory}⌝ to add it to your PATH?" default=true); then
    log::info "Creating a shim ⌜${valetBin}⌝ → ⌜${GLOBAL_INSTALLATION_DIRECTORY}/valet⌝."
    printf '#%s%s\nsource %s "$@"' "!" "/usr/bin/env bash" "'${GLOBAL_INSTALLATION_DIRECTORY}/valet'" 1>"${valetBin}"
    exe::invoke command chmod +x "${valetBin}"
    log::success "Shim created in ⌜${valetBin}⌝."
    REPLY="true"
  else
    REPLY="false"
  fi
}

function selfSetup_addValetToPath() {
  local \
    unattended="${1}" \
    shimCreated="${2}" \
    addToPath="${3}"

  log::debug "Add valet to the PATH by editing the shell startup files."

  local addByDefault="true"
  if [[ ${shimCreated} == "true" ]]; then
    addByDefault="false"
  fi

  if [[ ${addToPath:-} == "true" ]] || ([[ ${unattended:-} != "true" ]] && interactive::confirm "Do you want to add Valet to your PATH by editing your shell startup files?" default="${addByDefault}"); then
    system::addToPath "${GLOBAL_INSTALLATION_DIRECTORY}"
    log::success "Valet has been added to your PATH."
    REPLY="true"
  else
    REPLY="false"
  fi
}

function selfSetup_setupForWindows() {
  local \
    unattended="${1}" \
    setupForWindows="${2}"

  if ! system::isWindows; then
    return 0
  fi

  # on windows, we can add the installation path to the windows PATH
  if [[ ${setupForWindows:-} == "true" ]] || ([[ ${unattended:-} != "true" ]] && interactive::confirm "Valet can be setup to be called from the windows CMD or windows powershell."$'\n'"Do you want to add Valet to your windows PATH?" default=true); then

    # shellcheck source=../libraries.d/lib-windows
    source windows
    # shellcheck source=../libraries.d/lib-fs
    source fs

    local linuxInstallationPath="${GLOBAL_INSTALLATION_DIRECTORY}"
    fs::getAbsolutePath "${linuxInstallationPath}" realpath=true
    windows::getWindowsPathFromUnixPath "${REPLY}"
    local windowsInstallationPath="${REPLY}"

    local linuxBashPath="${BASH}"
    fs::getAbsolutePath "${linuxBashPath}" realpath=true
    windows::getWindowsPathFromUnixPath "${REPLY}"
    local windowsBashPath="${REPLY}"

    log::info "Setting the windows variable VALET_WIN_BASH to ⌜${windowsBashPath}⌝."
    windows::setEnvVar VALET_WIN_BASH "${windowsBashPath}"

    log::info "Setting the windows variable VALET_WIN_INSTALLATION_DIRECTORY to ⌜${windowsInstallationPath}⌝."
    windows::setEnvVar VALET_WIN_INSTALLATION_DIRECTORY "${windowsInstallationPath}"

    log::info "Adding ⌜${windowsInstallationPath}⌝ to the user windows PATH."
    windows::addToPath "${windowsInstallationPath}"
  fi
}

function selfSetup_globalInstallation() {
  local \
    unattended="${1}" \
    globalInstallation="${2}"

  log::debug "Setting up a global installation of Valet (make it available for all users)."

  if [[ ${globalInstallation:-} == "true" ]] || ([[ ${unattended:-} != "true" ]] && interactive::confirm "Do you want to add Valet to make valet available for all users?" default=true); then

    log::info "Setting read permissions for all users on Valet files and directories."
    exe::invoke command chmod -R a+rX "${GLOBAL_INSTALLATION_DIRECTORY}" --- failMessage="Could not set read permissions for all users on Valet files and directories."

    local shimPath="/usr/local/bin/valet"
    log::info "Creating a shim ⌜${shimPath}⌝ → ⌜${GLOBAL_INSTALLATION_DIRECTORY}/valet⌝ to make Valet available for all users."
    printf '#%s%s\nsource %s "$@"' "!" "/usr/bin/env bash" "'${GLOBAL_INSTALLATION_DIRECTORY}/valet'" 1>"${shimPath}"
    exe::invoke command chmod +x "${shimPath}" --- failMessage="Could not create the shim in ⌜${shimPath}⌝."
    log::success "Global installation setup complete."
    REPLY="true"
  else
    REPLY="false"
  fi
}
