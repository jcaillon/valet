#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         valet.d/commands.d/*
# Author:        github.com/jcaillon

# if not executing in bash, we can stop here
if [[ -z "${BASH_VERSION:-}" ]]; then
  printf '%s\n' "❌ This script must be run with bash." 1>&2
  exit 1
fi
if [[ ${BASH_VERSINFO[0]:-0} -lt 5 ]]; then
  printf '%s\n' "❌ Bash 5 or higher is required to run valet." 1>&2
  exit 1
fi

##<<VALET_COMMAND
# command: self update
# function: selfUpdate
# author: github.com/jcaillon
# shortDescription: Install or update valet using the latest release on GitHub.
#
# description: |-
#   Update valet using the latest release on GitHub.
#
#   This script can be used as a standalone script to install Valet:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)"
#
#   If you need to pass options (e.g. --single-user-installation) to the script, you can do it like this:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)" -s --single-user-installation
#
#   The default behavior is to install Valet for all users, in /opt/valet, which might require
#   you to type your password on sudo commands (you don't have to run this script with sudo, it will
#   ask for your password when needed).
#
#   This script will:
#
#   - 1. Download the given release from GitHub (latest by default).
#
#   - 2. Copy it in the Valet home directory, which defaults to:
#     * /opt/valet in case of a multi user installation
#     * ~/.local/valet otherwise
#
#   - 3. Make the valet script readable and executable, either by adding a shim
#        in a bin directory already present in your PATH, or by adding the Valet
#        directory to your PATH on shell startup.
#
#   - 4. Copy the examples in the user valet directory ~/.valet.d.
#
#   - 5. Copy the extras (vscode snippets) in the user valet directory ~/.valet.d.
#
#   - 6. Run self setup command (in case of an installation).
#
#   - 7. Try to update (fetch merge -ff-only) the git repositories under your valet user directory.
#
# options:
# - name: -u, --unattended
#   description: |-
#     Set to true to not enter interactive mode for the setup (useful for automated installation).
#   default: false
# - name: -s, --single-user-installation
#   description: |-
#     Set to true to install Valet for the current user only.
#
#     Note: for windows, the installation is always for the current user.
#   default: false
# - name: -v, --version <version>
#   description: |-
#     The version number to install (do not including the starting 'v').
#
#     Released versions can be found here: https://github.com/jcaillon/valet/releases
#
#   default: latest
# - name: -d, --installation-directory <path>
#   description: |-
#     The directory where Valet will be installed.
#
#     Defaults to /opt/valet for a multi user installation and ~/.local/valet otherwise.
# - name: -S, --no-shim
#   description: |-
#     Set to true to not create the shim script in /usr/local/bin.
#   default: false
# - name: -P, --no-path
#   description: |-
#     Set to true to not add the Valet directory to the PATH (append to your .bashrc file).
#   default: false
# - name: --no-extras
#   description: |-
#     Set to true to to not copy the extras (vscode code snippets) to the valet user directory (~/.valet.d).
#   default: false
# - name: -E, --no-examples
#   description: |-
#     Set to true to to not copy the examples (showcase) to the valet user directory (~/.valet.d).
#
#     This will be done only if the directory does not already exist. But you can force this behavior with the --override-examples option.
#   default: false
# - name: -e, --override-examples
#   description: |-
#     Set to true to override the examples (showcase) in the valet user directory (~/.valet.d).
#   default: false
# - name: -G, --skip-git-update
#   description: |-
#     Set to true to not attempt to update the git repositories under the valet user directory (~/.valet.d).
#   default: false
# examples:
# - name: self update
#   description: |-
#     Update Valet to the latest version.
# - name: !bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)"
#   description: |-
#     Install the latest version of Valet, using all the default options.
# - name: !bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/valet.d/commands.d/self-install.sh)" -s --single-user-installation --unattended
#   description: |-
#     Install the latest version of Valet in the user home directory and disable all interaction during the install process.
##VALET_COMMAND
function selfUpdate() {
  local unattended singleUserInstallation version installationDirectory noShim noPath noExamples overrideExamples noExtras skipGitUpdate

  # if this script is run directly
  if [[ ${_NOT_EXECUTED_FROM_VALET:-false} == "true" ]]; then
    # parse arguments manually (basic parsing only)
    while (( $# > 0 )); do
      case "${1}" in
      -u | --unattended)
        unattended="true"
        ;;
      -s | --single-user-installation)
        singleUserInstallation="true"
        ;;
      -v | --version)
        shift
        [[ $# -eq 0 ]] && core::fail "Missing version number after --version."
        version="${1}"
        ;;
      -d | --installation-directory)
        shift
        [[ $# -eq 0 ]] && core::fail "Installation directory missing --installation-directory."
        installationDirectory="${1}"
        ;;
      -S | --no-shim)
        noShim="true"
        ;;
      -P | --no-path)
        noPath="true"
        ;;
      -E | --no-examples)
        noExamples="true"
        ;;
      -A | --no-extras)
        noExtras="true"
        ;;
      -e | --override-examples)
        overrideExamples="true"
        ;;
      -G | --skip-git-update)
        skipGitUpdate="true"
        ;;
      -*) core::fail "Unknown option ⌜${1}⌝." ;;
      *) core::fail "This command takes no arguments." ;;
      esac
      shift
    done
    unattended="${unattended:-"${VALET_UNATTENDED:-"false"}"}"
    singleUserInstallation="${singleUserInstallation:-"${VALET_SINGLE_USER_INSTALLATION:-"false"}"}"
    version="${version:-"${VALET_VERSION:-"latest"}"}"
    installationDirectory="${installationDirectory:-"${VALET_INSTALLATION_DIRECTORY:-}"}"
    noShim="${noShim:-"${VALET_NO_SHIM:-"false"}"}"
    noPath="${noPath:-"${VALET_NO_PATH:-"false"}"}"
    noExamples="${noExamples:-"${VALET_NO_EXAMPLES:-"false"}"}"
    overrideExamples="${overrideExamples:-"${VALET_OVERRIDE_EXAMPLES:-"false"}"}"
    noExtras="${noExtras:-"${VALET_NO_EXTRAS:-"false"}"}"
    skipGitUpdate="${skipGitUpdate:-"${VALET_SKIP_GIT_UPDATE:-"false"}"}"
  else
    core::parseArguments "$@" && eval "${RETURNED_VALUE}"
    core::checkParseResults "${help:-}" "${parsingErrors:-}"
  fi

  # check if valet already exists
  local firstInstallation="${_NOT_EXECUTED_FROM_VALET:-false}"
  if [[ ${firstInstallation} != "true" ]]; then
    log::debug "Executing a self update from Valet."
  elif command -v valet &>/dev/null; then
    log::warning "Valet is already installed but executing the install script externally."
    if [[ ${unattended} == "true" ]] || interactive::promptYesNo "Execute the self update for the existing installation?" "true"; then
      (valet self update "$@")
      exit 0
    fi
  fi

  # get the os
  system::os
  local os="${RETURNED_VALUE}"
  log::debug "The current OS is ⌜${os}⌝."

  # get the user directory where to copy the examples
  core::getUserDirectory
  local userDirectory="${RETURNED_VALUE}"

  # get the latest version if needed
  if [[ ${version:-"latest"} == "latest" ]]; then
    log::debug "Getting the latest version from GitHub."
    selfUpdate::getLatestReleaseVersion
    version="${RETURNED_VALUE}"
    log::info "The latest version of Valet found on GitHub is ⌜${version}⌝."
  fi

  local currentVersion=""
  if [[ ${firstInstallation} != "true" ]]; then

    # get the current version
    core::getVersion
    local currentVersion="${RETURNED_VALUE}"
    currentVersion="${currentVersion%%$'\n'*}"

    # compare local and distant versions
    string::compareSemanticVersion "${currentVersion}" "${version}"
    if [[ ${RETURNED_VALUE} == "0" || ${RETURNED_VALUE} == "1" ]]; then
      log::info "The current local version ⌜${currentVersion}⌝ is higher or equal to the distant version ⌜${version}⌝."
      log::success "You already have the latest version."
      if [[ ${skipGitUpdate} != "true" ]]; then
        selfUpdate::updateUserRepositories "${userDirectory}"
      fi
      return 0
    fi
  fi

  # compute the release URL
  local releaseUrl="https://github.com/jcaillon/valet/releases/download/v${version}/valet.tar.gz"

  # compute the target directories
  local -a binDirectories
  if [[ ${singleUserInstallation:-} == "true" || "${os}" == "windows" ]]; then
    log::debug "Installing Valet for the current user only."
    GLOBAL_VALET_HOME="${installationDirectory:-${GLOBAL_VALET_HOME:-"${HOME}/.local/valet"}}"
  else
    log::debug "Installing Valet for all users."
    GLOBAL_VALET_HOME="${installationDirectory:-${GLOBAL_VALET_HOME:-"/opt/valet"}}"
    binDirectories+=("/usr/local/bin")
  fi
  binDirectories+=("${HOME}/.local/bin")
  binDirectories+=("${HOME}/bin")

  # check if one of the bin directories is in the PATH
  local dir binDirectory=""
  for dir in "${binDirectories[@]}"; do
    if selfUpdate::isDirectoryInPath "${dir}"; then
      binDirectory="${dir}"
      break
    fi
  done

  # display a recap to the user
  local createShim=false addToPath=false copyExamples=false copyExtras=false
  printf '\n  %s\n\n' "${AC__TEXT_UNDERLINE}Valet installation recap:${AC__TEXT_RESET}"
  selfUpdate::printRecapLine "Operating system:" "${os}"
  if [[ ${firstInstallation} != "true" ]]; then
    selfUpdate::printRecapLine "First installation:" "${firstInstallation}"
    selfUpdate::printRecapLine "Current Valet version:" "${currentVersion}"
  fi
  selfUpdate::printRecapLine "Version to install:" "${version}"
  selfUpdate::printRecapLine "Download URL:" "${releaseUrl}"
  selfUpdate::printRecapLine "Installation dir:" "${GLOBAL_VALET_HOME}"
  if [[ ${noShim} != "true" && -n ${binDirectory} ]]; then
    selfUpdate::printRecapLine "Create shim in dir:" "${binDirectory}"
    createShim=true
  fi
  if [[ ${noPath} != "true" && -z ${binDirectory} ]] && ! selfUpdate::isDirectoryInPath "${GLOBAL_VALET_HOME}"; then
    selfUpdate::printRecapLine "Add install dir to PATH:" "true"
    addToPath=true
  fi
  if [[ ${noExamples} != "true" && (! -d ${userDirectory}/examples.d || ${overrideExamples} == "true") ]]; then
    selfUpdate::printRecapLine "Copy examples to:" "${userDirectory}"
    copyExamples=true
  else
    selfUpdate::printRecapLine "Skip examples copy:" "true"
  fi
  if [[ ${noExtras} != "true" ]]; then
    selfUpdate::printRecapLine "Copy extras to:" "${userDirectory}"
    copyExtras=true
  else
    selfUpdate::printRecapLine "Skip extras copy:" "true"
  fi
  printf '\n'

  # ask for confirmation
  if [[ ${unattended} != "true" ]]; then
    interactive::promptYesNo "Proceed with the installation?" "true" || core::fail "Installation aborted."
  fi

  selfUpdate::install "${releaseUrl}" "${binDirectory}" "${unattended}"

  # remove the user commands to rebuild them
  if [[ -f "${userDirectory}/commands" ]]; then
    rm -f "${userDirectory}/commands" 1>/dev/null || :
  fi

  if [[ ${firstInstallation} == "true" ]]; then
    # shellcheck source=../core
    source "${GLOBAL_VALET_HOME}/valet.d/core"
    selfUpdate::sourceDependencies
  else
    core::sourceUserCommands
  fi

  if [[ ${copyExamples} == "true" ]]; then
    selfUpdate::copyExamples "${userDirectory}"
  fi

  if [[ ${copyExtras} == "true" ]]; then
    selfUpdate::copyExtras "${userDirectory}"
  fi

  if [[ ${createShim} == "true" ]]; then
    selfUpdate::createShim "${binDirectory}"
  fi

  if [[ ${addToPath} == "true" ]]; then
    selfUpdate::addToPath "${GLOBAL_VALET_HOME}" "${unattended}"
  fi

  if [[ ${skipGitUpdate} != "true" ]]; then
    selfUpdate::updateUserRepositories "${userDirectory}"
  fi

  # run the post install command
  if [[ ${unattended} != "true" && ${firstInstallation} == "true" ]]; then
    log::info "Running the self setup command."
    core::sourceFunction selfSetup
    selfSetup
  else
    # re-export the config file to be up to date (done in setup as well)
    core::sourceFunction selfConfig
    selfConfig --no-edit --override --export-current-values
  fi
}

function selfUpdate::printRecapLine() {
  printf '  - %s%-30s%s%s\n' "${AC__TEXT_BOLD}" "${1}" "${AC__FG_MAGENTA}${2}" "${AC__TEXT_RESET}"
}

function selfUpdate::install() {
  local releaseUrl="${1}"
  local binDirectory="${2}"
  local unattended="${3}"

  selfUpdate::testCommand "chmod"

  # case where valet directory is a git repository
  if [[ -d "${GLOBAL_VALET_HOME}/.git" ]]; then
    selfUpdate::testCommand "git"

    log::info "The Valet directory ⌜${GLOBAL_VALET_HOME}⌝ already exists and is a git repository, it will be updated using git."
    selfUpdate::updateGitRepository "${GLOBAL_VALET_HOME}" || core::fail "Failed to update the git repository ⌜${GLOBAL_VALET_HOME}⌝, clean your workarea first (e.g. git stash, or git commit)."

    chmod +x "${GLOBAL_VALET_HOME}/valet"
    return 0
  fi

  selfUpdate::testCommand "tar"
  selfUpdate::testCommand "mkdir"
  selfUpdate::testCommand "touch"
  selfUpdate::testCommand "rm"
  selfUpdate::testCommand "mv"

  # temporary directory for the installation
  local tempDirectory
  if command -v io::createTempDirectory 1>/dev/null; then
    io::createTempDirectory
    tempDirectory="${RETURNED_VALUE}"
  else
    tempDirectory="${TMPDIR:-/tmp}/valet.install.d"
    if [[ -d ${tempDirectory} ]]; then
      rm -Rf "${tempDirectory}" 1>/dev/null || :
    fi
    mkdir -p "${tempDirectory}" || core::fail "Could not create the temporary directory ⌜${tempDirectory}⌝."
  fi

  # download the release and unpack it
  local releaseFile="${tempDirectory}/valet.tar.gz"

  log::debug "Downloading the release ⌜${VALET_VERSION}⌝ from ⌜${releaseUrl}⌝."
  selfUpdate::download "${releaseUrl}" "${releaseFile}"

  log::debug "Unpacking the release in ⌜${GLOBAL_VALET_HOME}⌝."
  tar -xzf "${releaseFile}" -C "${tempDirectory}" || core::fail "Could not unpack the release ⌜${releaseFile}⌝ using tar."
  log::debug "The release has been unpacked in ⌜${GLOBAL_VALET_HOME}⌝ with:"$'\n'"${RETURNED_VALUE}."

  # figure out if we need to use sudo
  selfUpdate::setSudoIfNeeded "${GLOBAL_VALET_HOME}"

  # remove the old valet directory and move the new one
  ${_SUDO} rm -f "${releaseFile}"
  ${_SUDO} rm -Rf "${GLOBAL_VALET_HOME}"
  ${_SUDO} mv -f "${tempDirectory}" "${GLOBAL_VALET_HOME}"
  log::info "Valet has been copied in ⌜${GLOBAL_VALET_HOME}⌝."

  # make valet executable
  ${_SUDO} chmod +x "${GLOBAL_VALET_HOME}/valet"

  if [[ -d ${tempDirectory} ]]; then
    rm -Rf "${tempDirectory}" 1>/dev/null || :
  fi

  log::success "Valet has been installed in ⌜${GLOBAL_VALET_HOME}⌝."
}

function selfUpdate::updateGitRepository() {
  if [[ ! -f "${1}/.git/HEAD" ]]; then
    core::fail "The directory ⌜${1}⌝ is not a git repository."
  fi

  if ! command -v git; then
    core::fail "The command ⌜git⌝ is not installed or not found in your PATH."
  fi

  log::debug "Updating the git repository ⌜${1}⌝."

  io::readFile "${1}/.git/HEAD"
  if [[ ${RETURNED_VALUE} =~ ^"ref: refs/heads/"(.+) ]]; then
    local branch="${BASH_REMATCH[1]:-}"
    branch="${branch%%$'\n'*}"
    log::info "Fetching and merging branch ⌜${branch}⌝ from ⌜origin⌝ remote."
    pushd "${1}" &>/dev/null || core::fail "Could not change to the directory ⌜${1}⌝."
    if ! git fetch -q; then
      popd &>/dev/null || :
      return 1
    fi
    if ! git merge -q --ff-only "origin/${branch}" &>/dev/null; then
      popd &>/dev/null || :
      return 1
    fi
    popd &>/dev/null || :
    log::success "The git repository ⌜${1}⌝ has been updated."
    return 0
  fi

  core::fail "The git repository ⌜${1}⌝ does not have a checked out branch to pull."
}

function selfUpdate::copyExamples() {
  local userDirectory="${1}"

  mkdir -p "${userDirectory}" || core::fail "Could not create the user directory ⌜${userDirectory}⌝."

  if [[ -d "${userDirectory}/examples.d" ]]; then
    rm -Rf "${userDirectory}/examples.d" &>/dev/null || core::fail "Could not remove the existing examples in ⌜${userDirectory}⌝."
  fi

  cp -R "${GLOBAL_VALET_HOME}/examples.d" "${userDirectory}" || core::fail "Could not copy the examples to ⌜${userDirectory}⌝."

  log::success "The examples have been copied to ⌜${userDirectory}/examples.d⌝."
}

function selfUpdate::setSudoIfNeeded() {
  _SUDO=""
  if ! selfUpdate::isDirectoryWritable "${1}" "${2:-}"; then
    if [[ ${unattended} == "true" ]]; then
      core::fail "The directory ⌜${1}⌝ is not writable: try to run this command using sudo?"
    elif ! command -v sudo &>/dev/null; then
      core::fail "The directory ⌜${1}⌝ is not writable and you do not have sudo installed."
    else
      log::warning "The directory ⌜${1}⌝ is not writable, attempting to run the command using sudo."
      _SUDO='sudo'
      if ! selfUpdate::isDirectoryWritable "${1}" "${2:-}"; then
        core::fail "The directory ⌜${1}⌝ is not writable even with sudo."
      fi
    fi
  fi
}

function selfUpdate::isDirectoryWritable() {
  local directory="${1%/}"
  local testFile="${2:-writable-test-${BASHPID}}"
  if ! ${_SUDO} mkdir -p "${directory}" &>/dev/null; then
    return 1
  fi
  local path="${1}/${testFile}"
  if ${_SUDO} touch "${path}" &>/dev/null; then
    if ! ${_SUDO} rm -f "${path}" 1>/dev/null; then
      return 1
    fi
    return 0
  fi
  return 1
}

function selfUpdate::createShim() {
  local binDirectory="${1}"

  # figure out if we need to use sudo
  selfUpdate::setSudoIfNeeded "${binDirectory}" "valet"

  # create the shim in the bin directory
  local valetBin="${binDirectory}/valet"

  log::info "Creating a shim ⌜${valetBin}⌝ → ⌜${GLOBAL_VALET_HOME}/valet⌝."
  ${_SUDO} bash -c "printf '#%s\n%s \"\$@\"' \"!/usr/bin/env bash\" \"'${GLOBAL_VALET_HOME}/valet'\" 1> \"${valetBin}\""
  ${_SUDO} chmod +x "${valetBin}"
}

function selfUpdate::addToPath() {
  local binDirectory="${1}"
  local unattended="${2}"

  log::info "Attempting to add the Valet directory ⌜${binDirectory}⌝ to the PATH."

  local configFile configContent
  for shellName in "bash" "zsh" "tcsh" "csh" "xonsh" "fish"; do
    # shellcheck disable=SC2088
    if ! command -v "${shellName}" 1>/dev/null; then
      continue
    fi

    configFile="${HOME}/.${shellName}rc"

    case ${shellName} in
    fish)
      # shellcheck disable=SC2088
      configFile="${HOME}/.config/fish/config.fish"
      configContent="fish_add_path '${binDirectory}'"
      ;;
    tcsh | csh)
      configContent="set path = (\$path '${binDirectory}')"
      ;;
    xonsh)
      configContent="\$PATH.append('${binDirectory}')"
      ;;
    *)
      # shellcheck disable=SC2016
      printf -v configContent 'export PATH="%s:${PATH}"' "${binDirectory}"
      ;;
    esac

    printf '\n  %s\n\n' "${AC__TEXT_UNDERLINE}Append to${AC__TEXT_RESET}: ${AC__FG_MAGENTA}${configFile}${AC__TEXT_RESET}"
    printf '    %s%s%s\n\n' "${AC__TEXT_BOLD}" "${configContent}" "${AC__TEXT_RESET}"

    if [[ ${unattended} != "true" ]]; then
      if ! interactive::promptYesNo "Do you want to modify ⌜${configFile}⌝ as described above ?" "true"; then
        continue
      fi
    fi

    printf '\n\n%s\n' "${configContent}" >> "${configFile}"
  done

  if ! command -v valet &>/dev/null; then
    log::warning "Please login again to apply the changes to your path and make valet available."
  fi
}

# Check if a given directory is in the PATH.
function selfUpdate::isDirectoryInPath() {
  local directory="${1}"
  local IFS=':'
  for p in ${PATH}; do
    if [[ "${p}" == "${directory}" ]]; then
      return 0
    fi
  done
  return 1
}

# Get the version number of the latest release on GitHub.
function selfUpdate::getLatestReleaseVersion() {
  local jsonFile="${TMPDIR:-/tmp}/valet.latest.json"
  selfUpdate::download "https://api.github.com/repos/jcaillon/valet/releases/latest" "${jsonFile}"
  io::readFile "${jsonFile}"
  rm -f "${jsonFile}" 1>/dev/null
  if [[ ${RETURNED_VALUE} =~ "tag_name\":"([ ]?)"\"v"([^\"]+)"\"" ]]; then
    RETURNED_VALUE="${BASH_REMATCH[2]}"
  else
    log::debug "${RETURNED_VALUE}"
    core::fail "Could not get the latest version from GitHub (did not find tag_name)."
  fi
}

# Downloads a file to a specific location.
function selfUpdate::download() {
  local url="${1}"
  local output="${2}"

  if command -v curl 1>/dev/null; then
    curl --fail --silent --show-error --location --output "${output}" "${url}" || core::fail "Could not download from ⌜${url}⌝ to ⌜${output}⌝."
  elif command -v wget 1>/dev/null; then
    wget --quiet --output-document="${output}" "${url}" || core::fail "Could not download from ⌜${url}⌝ to ⌜${output}⌝."
  else
    core::fail "You need ⌜curl⌝ or ⌜wget⌝ installed and in your PATH."
  fi
}

# Attempts to update each git repository found in the user directory.
function selfUpdate::updateUserRepositories() {
  local userDirectory="${1}"

  if [[ ! -d "${userDirectory}" ]]; then
    return 0
  fi

  log::info "Attempting to update the git repositories in ⌜${userDirectory}⌝."

  if ! command -v git 1>/dev/null; then
    log::warning "The command ⌜git⌝ is not installed or not found in your PATH, skipping git update."
    return 0
  fi

  function filterGitRepositories() {
    if [[ -d "${1}/.git" ]]; then
      return 1
    fi
    return 0
  }
  io::listDirectories "${userDirectory}" true false filterGitRepositories
  local path
  local allUpdateSuccess=true
  local -i count=0
  for path in "${RETURNED_ARRAY[@]}"; do
    if [[ -d "${path}/.git" ]]; then
      log::debug "Found a git repository ⌜${path}⌝."
      if ! selfUpdate::updateGitRepository "${path}"; then
        allUpdateSuccess=false
        log::warning "Failed to update the git repository ⌜${path}⌝, clean your workarea first (e.g. git stash, or git commit)."
      else
        count+=1
      fi
    fi
  done

  if [[ ${allUpdateSuccess} == "true" ]]; then
    if (( count == 0 )); then
      log::info "No git repositories found in ⌜${userDirectory}⌝."
    else
      log::success "A total of ${count} git repositories in ⌜${userDirectory}⌝ have been updated."
    fi
  else
    log::warning "Some git repositories in ⌜${userDirectory}⌝ could not be updated, ${count} updated successfully."
  fi

}

function selfUpdate::copyExtras() {
  local userDirectory="${1}"

  mkdir -p "${userDirectory}" || core::fail "Could not create the user directory ⌜${userDirectory}⌝."

  mkdir -p "${userDirectory}/.vscode" || core::fail "Could not create the .vscode directory under the user directory ⌜${userDirectory}⌝."
  cp -f "${GLOBAL_VALET_HOME}/extras/valet.code-snippets" "${userDirectory}/.vscode" || core::fail "Could not copy the examples to ⌜${userDirectory}⌝."
  log::success "The vscode code snippets have been copied to ⌜${userDirectory}/.vscode/valet.code-snippets⌝."
}

# verify the presence of a command or fail if it does not exist
function selfUpdate::testCommand() {
  if ! command -v "${1}" &>/dev/null; then
    core::fail "⌜${1}⌝ is required but is not installed or not found in your PATH."
  fi
}

function selfUpdate::sourceDependencies() {
  # shellcheck source=../lib-system
  source system
  # shellcheck source=../lib-interactive
  source interactive
  # shellcheck source=../lib-ansi-codes
  source ansi-codes
  # shellcheck source=../lib-io
  source io
  # shellcheck source=../lib-string
  source string
}

#===============================================================
# >>> main
#===============================================================

# set the version to download by default
# this is automatically updated by the self release command
VALET_RELEASED_VERSION="0.21.567"

# import the core script (should always be skipped if the command is run from valet)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  _NOT_EXECUTED_FROM_VALET=true

  set -Eeu -o pipefail

  VALET_VERSION="${VALET_VERSION:-${VALET_RELEASED_VERSION}}"

  # determine if we support colors (can be overriden by the user with VALET_CONFIG_ENABLE_COLORS)
  case "${TERM:-}" in
  xterm-color | xterm-256color | linux) VALET_CONFIG_ENABLE_COLORS="${VALET_CONFIG_ENABLE_COLORS:-true}" ;;
  xterm) if [[ -n "${COLORTERM:-}" ]]; then VALET_CONFIG_ENABLE_COLORS="${VALET_CONFIG_ENABLE_COLORS:-true}"; fi ;;
  *) VALET_CONFIG_ENABLE_COLORS="${VALET_CONFIG_ENABLE_COLORS:-false}" ;;
  esac

  AC__TEXT_RESET=$'\e[0m'
  AC__TEXT_BOLD=$'\e[1m'
  AC__TEXT_UNDERLINE=$'\e[4m'
  AC__FG_MAGENTA=$'\e[35m'
  AC__FG_BRIGHT_BLACK=$'\e[90m'
  AC__FG_CYAN=$'\e[36m'
  AC__FG_YELLOW=$'\e[33m'
  AC__FG_GREEN=$'\e[32m'
  AC__FG_RED=$'\e[31m'

  if [[ ${VALET_CONFIG_ENABLE_COLORS:-false} == "false" ]]; then
    AC__TEXT_RESET=''
    AC__TEXT_BOLD=''
    AC__TEXT_UNDERLINE=''
    AC__FG_MAGENTA=''
    AC__FG_BRIGHT_BLACK=''
    AC__FG_CYAN=''
    AC__FG_YELLOW=''
    AC__FG_GREEN=''
    AC__FG_RED=''
  fi

  # we are executing this script without valet, create simplified functions to replace the libs
  function log::info() { printf "${AC__FG_BRIGHT_BLACK}%(%H:%M:%S)T${AC__TEXT_RESET} ${AC__TEXT_BOLD}${AC__FG_CYAN}%-8s${AC__TEXT_RESET} %s\n" "${EPOCHSECONDS}" "INFO" "$*"; }
  function log::success() { printf "${AC__FG_BRIGHT_BLACK}%(%H:%M:%S)T${AC__TEXT_RESET} ${AC__TEXT_BOLD}${AC__FG_GREEN}%-8s${AC__TEXT_RESET} %s
" "${EPOCHSECONDS}" "SUCCESS" "$*"; }
  function log::debug() { if [[ ${VALET_VERBOSE:-false} == "true" ]]; then printf "${AC__FG_BRIGHT_BLACK}%(%H:%M:%S)T${AC__TEXT_RESET} ${AC__TEXT_BOLD}${AC__FG_BRIGHT_BLACK}%-8s${AC__TEXT_RESET} %s
" "${EPOCHSECONDS}" "DEBUG" "$*"; fi; }
  function log::warning() { printf "${AC__FG_BRIGHT_BLACK}%(%H:%M:%S)T${AC__TEXT_RESET} ${AC__TEXT_BOLD}${AC__FG_YELLOW}%-8s${AC__TEXT_RESET} %s
" "${EPOCHSECONDS}" "WARNING" "$*"; }
  function core::fail() {
    printf "${AC__FG_BRIGHT_BLACK}%(%H:%M:%S)T${AC__TEXT_RESET} ${AC__TEXT_BOLD}${AC__FG_RED}%-8s${AC__TEXT_RESET} %s
" "${EPOCHSECONDS}" "ERROR" "$*"
    exit 1
  }
  function system::os() {
    case "${OSTYPE:-}" in
    darwin*) RETURNED_VALUE="darwin" ;;
    linux*) RETURNED_VALUE="linux" ;;
    msys*) RETURNED_VALUE="windows" ;;
    *) RETURNED_VALUE="unknown" ;;
    esac
  }
  function core::getUserDirectory() { RETURNED_VALUE="${VALET_USER_DIRECTORY:-${HOME}/.valet.d}"; }
  function interactive::promptYesNo() {
    local question="${1}"
    local default="${2:-false}"
    if [[ ${default} == "yes" ]]; then
      printf "%s [Y/n] " "${question}"
    else
      printf "%s [y/N] " "${question}"
    fi
    IFS='' read -d '' -srn 1 LAST_KEY_PRESSED
    case "${LAST_KEY_PRESSED}" in
    y | Y | $'\n') RETURNED_VALUE="true" ;;
    n | N) RETURNED_VALUE="false" ;;
    *) RETURNED_VALUE="${default}" ;;
    esac
    if [[ ${RETURNED_VALUE} == "true" ]]; then
      printf "\nYes\n"
      return 0
    fi
    printf "\nNo\n"
    return 1
  }
  function io::readFile() { RETURNED_VALUE="$(<"${1}")"; }

  VALET_CONFIG_FILE="${VALET_CONFIG_FILE:-"${VALET_CONFIG_DIRECTORY:-${XDG_CONFIG_HOME:-${HOME}/.config}/valet}/config"}"
else
  selfUpdate::sourceDependencies
fi

# This is put in braces to ensure that the script does not run until it is downloaded completely.
{
  # if this script is run directly, execute the function, otherwise valet will do it
  if [[ ${_NOT_EXECUTED_FROM_VALET:-false} == "true" ]]; then
    selfUpdate "$@"
  fi
}
