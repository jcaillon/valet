#!/usr/bin/env bash
# author: github.com/jcaillon
# description: Install script for valet: <https://jcaillon.github.io/valet/>.
#
# ########################
#         SYNOPSIS
# ########################
#
# This script allows you to install Valet and can be executed as such:
#
# > ./install.sh
#
# Or directly from the GitHub repository using this command:
#
# > bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/install.sh)"
#
# If you need to pass options to the script, you can do it like this (e.g. for an unattended installation):
#
#  > bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/install.sh)" -s --unattended
#
# This script will:
#
# - 1. Download the tar.gz release from GitHub (latest by default).
# - 2. Copy it in the Valet installation directory, which defaults to: `~/.local/lib/valet`
# - 3. Run `valet self setup` command to finish the installation.
#
# ########################
#         OPTIONS
# ########################
#
# - `--unattended`:
#           Set to true to install without user interaction/prompt (useful for automated installation).
#           Can be set using the environment variable `VALET_UNATTENDED=true`.
#           Defaults to false.
#           Note: If you use the unattended mode, you can specify options for the `valet self setup` command using
#                  environment variables. Please check the command documentation for available options:
#                 <https://jcaillon.github.io/valet/docs/valet-commands/#-valet-self-setup>.
# - `--installation-directory <path>`:
#           The directory where Valet will be installed.
#           Can be set using the environment variable `VALET_INSTALLATION_DIRECTORY=<path>`.
#           Defaults to `~/.local/lib/valet`.
# - `--from-branch <branch_name>`:
#           Download Valet from a given branch tarball instead of a release.
#           Can be set using the environment variable `VALET_FROM_BRANCH=<branch_name>`.
#           Defaults to empty, which means to download the latest release.
# - `--skip-setup`:
#           Set to true to skip the execution of the `valet self setup` command after the installation.
#           You can then run `valet self setup` manually to finish the installation or add valet to your PATH by yourself.
#           Can be set using the environment variable `VALET_SKIP_SETUP=true`.
#           Defaults to false.
# - `--verbose`:
#           Set to true to get more verbose output during the installation.
#           Can be set using the environment variable `VALET_VERBOSE=true`.
#           Defaults to false.
# - `--version <version>`:
#           Install a specific version of Valet instead of the version corresponding to this script version
#           (i.e. latest version by default).
#           Can be set using the environment variable `VALET_VERSION=<version>`.
#           This option is ignored if `--from-branch` is specified.
#

# check the bash version (and that we are running in bash), make it POSIX compliant
# shellcheck disable=SC2292
# shellcheck disable=SC2086
# shellcheck disable=SC2128
if [ ${BASH_VERSINFO:-0} -lt 5 ]; then
  printf '%s\n' "❌ Bash 5 or higher is required to run valet."
  exit 1
fi

# The version of Valet downloaded by this install script.
# This value is automatically updated by the `valet self release` command when a new release is published.
VALET_RELEASED_VERSION="0.36.26"

function main() {
  local \
    unattended="${VALET_UNATTENDED:-"false"}" \
    installationDirectory="${VALET_INSTALLATION_DIRECTORY:-"${HOME}/.local/lib/valet"}" \
    fromBranch="${VALET_FROM_BRANCH:-}" \
    skipSetup="${VALET_SKIP_SETUP:-"false"}" \
    verbose="${VALET_VERBOSE:-"false"}" \
    version="${VALET_VERSION:-"${VALET_RELEASED_VERSION}"}"

  log::debug "Parsing arguments: ⌜${*}⌝."
  while (($# > 0)); do
    case "${1}" in
    --unattended)
      unattended="true"
      ;;
    --installation-directory)
      shift
      [[ $# -eq 0 ]] && core::fail "Missing value for 'the installation directory' after the option --installation-directory."
      installationDirectory="${1}"
      ;;
    --from-branch)
      shift
      [[ $# -eq 0 ]] && core::fail "Missing value for 'the branch name' after the option --from-branch."
      fromBranch="${1}"
      ;;
    --skip-setup)
      skipSetup="true"
      ;;
    --verbose)
      verbose="true"
      ;;
    --version)
      shift
      [[ $# -eq 0 ]] && core::fail "Missing value for 'the version' after the option --version."
      version="${1}"
      ;;
    -*) core::fail "Unknown option ⌜${1}⌝." ;;
    *) core::fail "This command takes no arguments, did not understand ⌜${1}⌝." ;;
    esac
    shift
  done

  installationDirectory="${installationDirectory%/}"
  VALET_VERBOSE="${verbose}"

  # compute the release URL
  local releaseUrl version
  if [[ -n ${fromBranch} ]]; then
    version="branch ${fromBranch}"
    releaseUrl="https://github.com/jcaillon/valet/archive/${fromBranch}.tar.gz"
  else
    releaseUrl="https://github.com/jcaillon/valet/releases/download/v${version}/valet.tar.gz"
  fi

  # display a recap to the user
  printf '\n  %s\n\n' "${STYLE_COLOR_PRIMARY}Valet installation recap:${STYLE_COLOR_DEFAULT}"
  printRecapLine "Version to install:" "${version}"
  printRecapLine "Download URL:" "${releaseUrl}"
  printRecapLine "Installation dir:" "${installationDirectory}"
  printf '\n'

  # ask for confirmation
  if [[ ${unattended} != "true" ]]; then
    interactive::confirm "Proceed with the installation?" || core::fail "Installation aborted."
  fi

  # download and install valet
  install "${releaseUrl}" "${fromBranch}" "${installationDirectory}"

  log::success "Valet version ⌜${version}⌝ has been installed in ⌜${installationDirectory}⌝."

  # remove the user commands to rebuild them
  command::deleteCommandsIndex

  if [[ ${skipSetup} == "true" ]]; then
    log::warning "Skipping the valet self setup command as --skip-setup has been passed."$'\n'"You can now run ⌜valet self setup⌝ manually to finish setting up valet."$'\n'"Or add ${installationDirectory} to your PATH."
  else
    # run the setup command
    log::info "Running the self setup command."
    VALET_VERBOSE="${VALET_VERBOSE}" VALET_UNATTENDED="${unattended}" "${installationDirectory}/valet" self setup
  fi
}

function printRecapLine() {
  printf '  - %-30s%s%s\n' "${1}" "${STYLE_COLOR_ACCENT}${2}" "${STYLE_COLOR_DEFAULT}"
}

# Install Valet using the given release URL.
function install() {
  local \
    releaseUrl="${1}" \
    fromBranch="${2}" \
    installationDirectory="${3}"

  testCommand "tar"
  testCommand "mkdir"
  testCommand "rm"
  testCommand "mv"
  testCommand "chmod"

  # temporary directory for the installation
  local tempDirectory="${TMPDIR:-/tmp}/valet.install.d"
  if [[ -d ${tempDirectory} ]]; then
    rm -Rf "${tempDirectory}" 1>/dev/null || :
  fi
  mkdir -p "${tempDirectory}" || core::fail "Could not create the temporary directory ⌜${tempDirectory}⌝."

  # download the release and unpack it
  local releaseFile="${tempDirectory}/valet.tar.gz"

  log::debug "Downloading the release from ⌜${releaseUrl}⌝."
  downloadTarBall "${releaseUrl}" "${releaseFile}"

  log::debug "Unpacking the release."
  tar -xzf "${releaseFile}" -C "${tempDirectory}" || core::fail "Could not unpack the release ⌜${releaseFile}⌝ using tar."

  if [[ -n ${fromBranch} ]]; then
    # when downloaded from a tarball, a sub director named valet-branch is created
    # we need to move the content of this directory to the parent directory
    local subDirectory="${tempDirectory}/valet-${fromBranch}"
    if [[ ! -d ${subDirectory} ]]; then
      core::fail "The downloaded branch tarball does not contain the expected directory ⌜${subDirectory}⌝."
    fi
    log::debug "Moving the content of ⌜${subDirectory}⌝ to ⌜${tempDirectory}⌝."
    mv -f "${subDirectory}"/* "${tempDirectory}" || core::fail "Could not move the content of ⌜${subDirectory}⌝ to ⌜${tempDirectory}⌝."
    rm -Rf "${subDirectory}" 1>/dev/null || :
  fi

  log::debug "Removing old files."
  rm -f "${releaseFile}"
  rm -Rf "${installationDirectory}" || core::fail "Could not remove the existing installation directory ⌜${installationDirectory}⌝."
  mkdir -p "${installationDirectory%/*}" || core::fail "Could not create the directory ⌜${installationDirectory%/*}⌝."

  log::debug "Copying the release to the installation directory ⌜${installationDirectory}⌝."
  mv -f "${tempDirectory}" "${installationDirectory}" || core::fail "Could not move the release to the installation directory ⌜${installationDirectory}⌝."

  log::debug "Making valet executable."
  if [[ ! -f ${installationDirectory}/valet ]]; then
    core::fail "The valet executable was not found in the installation directory ⌜${installationDirectory}⌝ after downloading (did we get the correct version or branch?)."
  fi
  chmod +x "${installationDirectory}/valet" || core::fail "Could not make the valet executable at ⌜${installationDirectory}/valet⌝."

  if [[ -d ${tempDirectory} ]]; then
    rm -Rf "${tempDirectory}" 1>/dev/null || :
  fi

  log::success "Valet has been downloaded in ⌜${installationDirectory}⌝."
}

# Downloads a file to a specific location.
function downloadTarBall() {
  local url="${1}"
  local output="${2}"

  if command -v curl &>/dev/null; then
    curl --fail --silent --show-error --location --output "${output}" "${url}" || core::fail "Could not download from ⌜${url}⌝ to ⌜${output}⌝, verify the url (bad version or branch?)."
  elif command -v wget &>/dev/null; then
    wget --quiet --output-document="${output}" "${url}" || core::fail "Could not download from ⌜${url}⌝ to ⌜${output}⌝, verify the url (bad version or branch?)."
  else
    core::fail "You need ⌜curl⌝ or ⌜wget⌝ installed and in your PATH."
  fi
}

# verify the presence of a command or fail if it does not exist
function testCommand() {
  # unset potentially existing functions with the same name
  unset -f "${1}" &>/dev/null || :
  if ! command -v "${1}" &>/dev/null; then
    core::fail "⌜${1}⌝ is required but is not installed or not found in your PATH."
  fi
}

# log info message
function log::info() {
  local message="${1//⌜/${STYLE_COLOR_ACCENT}⌜}"
  printf "${STYLE_COLOR_FADED}%(%H:%M:%S)T${STYLE_COLOR_DEFAULT} ${STYLE_COLOR_INFO}%-7s${STYLE_COLOR_DEFAULT}  %s\n" "${GLOBAL_MOCK_EPOCHSECONDS:-${EPOCHSECONDS}}" "INFO" "${message//⌝/⌝${STYLE_COLOR_DEFAULT}}"
}

# log warning message
function log::warning() {
  local message="${1//⌜/${STYLE_COLOR_ACCENT}⌜}"
  printf "${STYLE_COLOR_FADED}%(%H:%M:%S)T${STYLE_COLOR_DEFAULT} ${STYLE_COLOR_WARNING}%-7s${STYLE_COLOR_DEFAULT}  %s\n" "${GLOBAL_MOCK_EPOCHSECONDS:-${EPOCHSECONDS}}" "WARNING" "${message//⌝/⌝${STYLE_COLOR_DEFAULT}}"
}

# log success message
function log::success() {
  local message="${1//⌜/${STYLE_COLOR_ACCENT}⌜}"
  printf "${STYLE_COLOR_FADED}%(%H:%M:%S)T${STYLE_COLOR_DEFAULT} ${STYLE_COLOR_SUCCESS}%-7s${STYLE_COLOR_DEFAULT}  %s\n" "${GLOBAL_MOCK_EPOCHSECONDS:-${EPOCHSECONDS}}" "SUCCESS" "${message//⌝/⌝${STYLE_COLOR_DEFAULT}}"
}

# log debug message (only if VALET_VERBOSE is set to true)
function log::debug() {
  if [[ ${VALET_VERBOSE:-false} == "true" ]]; then
    local message="${1//⌜/${STYLE_COLOR_ACCENT}⌜}"
    printf "${STYLE_COLOR_FADED}%(%H:%M:%S)T${STYLE_COLOR_DEFAULT} ${STYLE_COLOR_DEBUG}%-7s${STYLE_COLOR_DEFAULT}  %s\n" "${GLOBAL_MOCK_EPOCHSECONDS:-${EPOCHSECONDS}}" "DEBUG" "${message//⌝/⌝${STYLE_COLOR_DEFAULT}}"
  fi
}

# log error message and exit
function core::fail() {
  local message="${1//⌜/${STYLE_COLOR_ACCENT}⌜}"
  printf "${STYLE_COLOR_FADED}%(%H:%M:%S)T${STYLE_COLOR_DEFAULT} ${STYLE_COLOR_ERROR}%-7s${STYLE_COLOR_DEFAULT}  %s\n" "${GLOBAL_MOCK_EPOCHSECONDS:-${EPOCHSECONDS}}" "ERROR" "${message//⌝/⌝${STYLE_COLOR_DEFAULT}}"
  exit 1
}

# Interactive confirmation prompt.
function interactive::confirm() {
  local \
    prompt="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    default=true \
    IFS=$' '
  shift 1
  eval "local a= ${*@Q}"

  if [[ ${default} == "true" ]]; then
    printf "%s [Y/n] " "${prompt}"
  else
    printf "%s [y/N] " "${prompt}"
  fi
  local IFS=''
  read -d '' -srn 1 LAST_KEY_PRESSED
  case "${LAST_KEY_PRESSED}" in
  y | Y | $'\n') REPLY="true" ;;
  n | N | $'\e') REPLY="false" ;;
  *) REPLY="${default}" ;;
  esac
  if [[ ${REPLY} == "true" ]]; then
    printf "\nYes\n"
    return 0
  fi
  printf "\nNo\n"
  return 1
}

# Delete the cached commands index.
function command::deleteCommandsIndex() {
  rm -f "${VALET_CONFIG_USER_DATA_DIRECTORY:-"${XDG_DATA_HOME:-"${HOME}/.local/share"}/valet"}/commands" 1>/dev/null || :
}

#===============================================================
# >>> main
#===============================================================

# This is put in braces to ensure that the script does not run until it is downloaded completely.
{
  set -Eeu -o pipefail
  unalias -a
  IFS=' '$'\t'$'\n'

  # determine if we support colors (can be overridden by the user with VALET_CONFIG_ENABLE_COLORS)
  case "${TERM:-}" in
  xterm-color | xterm-256color | linux) VALET_CONFIG_ENABLE_COLORS="${VALET_CONFIG_ENABLE_COLORS:-true}" ;;
  xterm) if [[ -n ${COLORTERM:-} ]]; then VALET_CONFIG_ENABLE_COLORS="${VALET_CONFIG_ENABLE_COLORS:-true}"; fi ;;
  *) VALET_CONFIG_ENABLE_COLORS="${VALET_CONFIG_ENABLE_COLORS:-false}" ;;
  esac
  if [[ ${VALET_CONFIG_ENABLE_COLORS:-} == "true" ]]; then
    STYLE_COLOR_DEFAULT=$'\e[0m'
    STYLE_COLOR_PRIMARY=$'\e[96m'
    STYLE_COLOR_ACCENT=$'\e[95m'
    STYLE_COLOR_FADED=$'\e[90m'
    STYLE_COLOR_DEBUG=$'\e[90m'
    STYLE_COLOR_INFO=$'\e[36m'
    STYLE_COLOR_WARNING=$'\e[33m'
    STYLE_COLOR_SUCCESS=$'\e[32m'
    STYLE_COLOR_ERROR=$'\e[31m'
  else
    STYLE_COLOR_DEFAULT=''
    STYLE_COLOR_PRIMARY=''
    STYLE_COLOR_ACCENT=''
    STYLE_COLOR_FADED=''
    STYLE_COLOR_DEBUG=''
    STYLE_COLOR_INFO=''
    STYLE_COLOR_WARNING=''
    STYLE_COLOR_SUCCESS=''
    STYLE_COLOR_ERROR=''
  fi

  main "$@"
}
