#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Author:        github.com/jcaillon
#
# Description:
#
#   This script can be used as a standalone script to install Valet.
#   The default behavior is to install Valet for all users, which will to type your password on sudo commands.
#   Do not run this script with sudo, it will ask for your password when needed.
#
#   This script will :
#   - Download the latest release from GitHub.
#   - Copy it in the Valet home directory, which defaults to:
#     - '/opt/valet' in case of a multi user installation
#     - '~/.local/valet' otherwise
#   - Add a shim script to redirect to the Valet executable in:
#     - '/usr/local/bin' in case of a multi user installation
#     - '~/.local/bin' otherwise
#   - Copy the examples in the user valet directory '~/.valet.d'.
#   - Run self setup command (in case of an installation).
#
# Environment variables to configure the installation:
#
#   VALET_UNATTENDED: set to 'true' to not enter interactive mode for the setup (useful for automated installation)
#   VALET_SINGLE_USER_INSTALLATION: set to 'true' to install Valet for the current user only.
#                             Defaults to false
#                             Note: for windows, the installation is always for the current user.
#   VALET_INSTALLATION_DIRECTORY the directory where Valet will be installed.
#   VALET_VERBOSE: set to 'true' to display debug information.
#   VALET_NO_SHIM: set to 'true' to not create the shim script in /usr/local/bin.
#   VALET_NO_BINARIES: set to 'true' to not download the binaries (just Valet scripts).
#   VALET_DONT_APPEND_PATH: set to 'true' to not add the Valet directory to the PATH (append to your .bashrc file).
#
# Usage:
#
#   To install Valet for all users:
#
#     ./self-install.sh
#
#   To install Valet for the current user only:
#
#     VALET_SINGLE_USER_INSTALLATION=true ./self-install.sh

# if not executing in bash, we can stop here
if [[ -z "${BASH_VERSION:-}" ]]; then
  echo "❌ This script must be run with bash." 1>&2
  exit 0
fi

# import the core script (should always be skipped if the command is run from valet)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  NOT_EXECUTED_FROM_VALET=true

  VALETD_DIR="${BASH_SOURCE[0]}"
  if [[ "${VALETD_DIR}" != /* ]]; then
    if pushd "${VALETD_DIR%/*}" &>/dev/null; then VALETD_DIR="${PWD}"; popd &>/dev/null || true;
    else VALETD_DIR="${PWD}"; fi
  else VALETD_DIR="${VALETD_DIR%/*}"; fi
  VALETD_DIR="${VALETD_DIR%/*}" # strip directory

  if [[ -f "${VALETD_DIR}/core" ]]; then
    # shellcheck source=../core
    source "${VALETD_DIR}/core"
  else
    set -Eeu -o pipefail

    # we are executing this script without valet, create functions to replace the core functions.
    function log::info() { printf "%-8s %s\n" "INFO" "ℹ️ $*"; }
    function log::success() { printf "%-8s %s\n" "SUCCESS" "✅ $*"; }
    function log::debug() { if [[ ${VALET_VERBOSE:-false} == "true" ]]; then printf "%-8s %s\n" "VALET_VERBOSE" "📰 $*"; fi; }
    function log::warning() { printf "%-8s %s\n" "WARNING" "⚠️ $*"; }
    function core::fail() {
      printf "%-8s %s\n" "ERROR" "❌ $*"
      exit 1
    }
    function system::getOsName() {
      case "${OSTYPE:-}" in
      darwin*) LAST_RETURNED_VALUE="darwin" ;;
      linux*) LAST_RETURNED_VALUE="linux" ;;
      msys*) LAST_RETURNED_VALUE="windows" ;;
      *) LAST_RETURNED_VALUE="unknown" ;;
      esac
    }
    function core::getUserDirectory() { LAST_RETURNED_VALUE="${VALET_USER_DIRECTORY:-${HOME}/.valet.d}"; }
    VALET_CONFIG_FILE="${VALET_CONFIG_FILE:-"${VALET_CONFIG_DIRECTORY:-${XDG_CONFIG_HOME:-${HOME}/.config}/valet}/config"}"

    VALET_CONFIG_DISABLE_COLORS=true
    VALET_CONFIG_DISABLE_NERDFONT_ICONS=true
  fi
else
  # shellcheck source=../lib-system
  source system
  # shellcheck source=../lib-interactive
  source interactive
fi

#===============================================================
# >>> command: self update
#===============================================================

: "---
command: self update
function: selfUpdate
author: github.com/jcaillon
shortDescription: Update valet using the latest release on GitHub.
description: |-
  Update valet using the latest release on GitHub.
---"
function selfUpdate() {
  # check if valet already exists
  local valetAlreadyInstalled=false
  if command -v valet &>/dev/null; then
    log::info "Valet is already installed, updating it."
    valetAlreadyInstalled=true
  fi

  local SUDO=''
  if command -v sudo &>/dev/null && ${VALET_SINGLE_USER_INSTALLATION:-false} != "true"; then
    SUDO='sudo'
  fi

  # get the os
  system::getOsName
  local os="${LAST_RETURNED_VALUE}"
  log::info "The current OS is: ${os}."

  # set the default options
  local binDirectory
  if [[ ${VALET_SINGLE_USER_INSTALLATION:-false} == "true" || "${os}" == "windows" ]]; then
    log::info "Installing Valet for the current user only."
    GLOBAL_VALET_HOME="${VALET_INSTALLATION_DIRECTORY:-${GLOBAL_VALET_HOME:-${HOME}/.local/valet}}"
    binDirectory="${HOME}/.local/bin"
  else
    log::info "Installing Valet for all users."
    GLOBAL_VALET_HOME="${VALET_INSTALLATION_DIRECTORY:-${GLOBAL_VALET_HOME:-/opt/valet}}"
    binDirectory="/usr/local/bin"
  fi

  # make sure the old valet directory is not a git repository
  if [[ -d "${GLOBAL_VALET_HOME}/.git" ]]; then
    core::fail "The Valet directory ⌜${GLOBAL_VALET_HOME}⌝ already exists and is a git repository, aborting (remove it manually and run the command again; or simply update with git pull)."
  fi

  local tempDirectory="${TMPDIR:-/tmp}/temp-${BASHPID}.valet.install.d"
  mkdir -p "${tempDirectory}" 1>/dev/null || core::fail "Could not create the temporary directory ⌜${tempDirectory}⌝."

  # download the latest release and unpack it
  local latestReleaseUrl
  if [[ ${VALET_NO_BINARIES:-false} == true ]]; then
    latestReleaseUrl="https://github.com/jcaillon/valet/releases/latest/download/valet-no-binaries.tar.gz"
  else
    latestReleaseUrl="https://github.com/jcaillon/valet/releases/latest/download/valet-${os}-amd64.tar.gz"
  fi
  local latestReleaseFile="${tempDirectory}/valet.tar.gz"
  log::info "Downloading the latest release from ⌜${latestReleaseUrl}⌝."
  curl -fsSL -o "${latestReleaseFile}" "${latestReleaseUrl}" || core::fail "Could not download the latest release from ⌜${latestReleaseUrl}⌝."
  log::debug "Unpacking the release in ⌜${GLOBAL_VALET_HOME}⌝."
  tar -xzf "${latestReleaseFile}" -C "${tempDirectory}"
  log::debug "The release has been unpacked in ⌜${GLOBAL_VALET_HOME}⌝ with:"$'\n'"${LAST_RETURNED_VALUE}."

  # remove the old valet directory and move the new one
  ${SUDO} rm -f "${latestReleaseFile}"
  ${SUDO} rm -Rf "${GLOBAL_VALET_HOME}"
  ${SUDO} mv -f "${tempDirectory}" "${GLOBAL_VALET_HOME}"
  log::info "Valet has been copied in ⌜${GLOBAL_VALET_HOME}⌝."

  # make valet executable
  ${SUDO} chmod +x "${GLOBAL_VALET_HOME}/valet"
  ${SUDO} chmod +x "${GLOBAL_VALET_HOME}/bin/"*

  log::success "Valet has been installed in ⌜${GLOBAL_VALET_HOME}⌝."

  # copy the examples if the user directory does not exist
  core::getUserDirectory && local userDirectory="${LAST_RETURNED_VALUE}"
  if [[ ! -d "${userDirectory}" ]]; then
    log::info "Copying the examples in ⌜${userDirectory}⌝."
    cp -R "${GLOBAL_VALET_HOME}/examples.d" "${userDirectory}"
  fi

  # source valet core
  if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
    # shellcheck source=../core
    source "${GLOBAL_VALET_HOME}/valet.d/core"
  fi

  if [[ "${VALET_NO_SHIM:-false}" != true ]]; then

    # create the shim in the bin directory
    local valetBin="${binDirectory}/valet"
    if [[ -f "${valetBin}" && "${valetAlreadyInstalled}" == "false" ]]; then
      log::warning "A valet shim already exists in ⌜${valetBin}⌝!?"
    else
      ${SUDO} mkdir -p "${binDirectory}" 1>/dev/null || core::fail "Could not create the bin directory ⌜${binDirectory}⌝."
      log::info "Creating a shim ⌜${GLOBAL_VALET_HOME}/valet → ${valetBin}⌝."
      {
        echo "#!/usr/bin/env bash"
        echo -n "'${GLOBAL_VALET_HOME}/valet' \"\$@\""
      } | ${SUDO} tee -a "${valetBin}" 1>/dev/null
      ${SUDO} chmod +x "${valetBin}"
    fi

    # make sure the valetBin directory is in the path or add it to ~.bashrc
    if ! command -v valet &>/dev/null; then
      if [[ ${VALET_DONT_APPEND_PATH:-false} == true ]]; then
        log::warning "Make sure to add ⌜${binDirectory}⌝ (or ⌜${GLOBAL_VALET_HOME}⌝) in your PATH."
      else
        if [[ -f "${HOME}/.bashrc" ]]; then
          log::info "Adding ⌜${binDirectory}⌝ to your PATH via .bashrc right now."
          printf "\n\n# Add Valet to the PATH\nexport PATH=\"%s:\${PATH}\"\n" "${binDirectory}" >>"${HOME}/.bashrc"
        fi
        if [[ -f "${HOME}/.zshrc" ]]; then
          log::info "Adding ⌜${binDirectory}⌝ to your PATH via .zshrc right now."
          printf "\n\n# Add Valet to the PATH\nexport PATH=\"%s:\${PATH}\"\n" "${binDirectory}" >>"${HOME}/.zshrc"
        fi
        log::warning "Please login again to apply the changes to your path or run the following command:"$'\n'"export PATH=\"${binDirectory}:\${PATH}\""
      fi
    fi

  fi

  # run the post install command
  if [[ ${VALET_UNATTENDED:-} != "true" ]]; then
    log::info "Running the self setup command."
    core::sourceForFunction selfSetup
    selfSetup
  fi
}


# if this script is run directly, execute the function, otherwise valet will do it
if [[ ${NOT_EXECUTED_FROM_VALET:-false} == "true" ]]; then
  selfUpdate "$@"
fi
