#!/usr/bin/env bash
# Title:         commands.d/*
# Author:        github.com/jcaillon

# check the bash version (and that we are running in bash), make it POSIX compliant
# shellcheck disable=SC2292
# shellcheck disable=SC2086
# shellcheck disable=SC2128
if [ ${BASH_VERSINFO:-0} -lt 5 ]; then
  printf '%s\n' "❌ Bash 5 or higher is required to run valet."
  exit 1
fi

##<<VALET_COMMAND
# command: self update
# function: selfUpdate
# author: github.com/jcaillon
# shortDescription: Update valet and its extensions to the latest releases.
#
# description: |-
#   Update valet using the latest release on GitHub. Also update all installed extensions.
#
#   This script can also be used as a standalone script to install Valet:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)"
#
#   If you need to pass options (e.g. --single-user-installation) to the script, you can do it like this:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)" -s --single-user-installation
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
#     - /opt/valet in case of a multi user installation
#     - ~/.local/valet otherwise
#
#   - 3. Make the valet script readable and executable, either by adding a shim
#        in a bin directory already present in your PATH, or by adding the Valet
#        directory to your PATH on shell startup.
#
#   - 4. Copy the showcase (command examples) in the valet user directory ~/.valet.d.
#
#   - 6. Run self setup command (in case of a new installation) or re-export the config.
#
#   - 7. Try to update (fetch merge --ff-only) the git repositories and all
#        installed extensions in your valet user directory.
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
# - name: --no-showcase
#   description: |-
#     Set to true to to not copy the showcase (command examples) to the valet user directory (~/.valet.d).
#
#     If you do not set this option, newer versions of the showcase will override the existing ones.
#
#     In case of an update, if the showcase.d directory does not exist, the showcase will not be copied.
#   default: false
# - name: -U, --skip-extensions
#   description: |-
#     Set to true to not attempt to update the installed extensions under the valet user directory (~/.valet.d).
#   default: false
# - name: -e, --only-extensions
#   description: |-
#     Set to true to only update the installed extensions under the valet user directory (~/.valet.d).
#   default: false
# - name: --skip-extensions-setup
#   description: |-
#     Set to true to skip the execution of extension setup scripts (if any, when updating extensions).
#   default: false
# - name: -b, --use-branch
#   description: |-
#     Set to true to download Valet from a branch tarball instead of a release.
#     In that case, the version is the branch name.
#     Only works for new installations, not for updates.
#   default: false
# examples:
# - name: self update
#   description: |-
#     Update Valet to the latest version.
# - name: !bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)"
#   description: |-
#     Install the latest version of Valet, using all the default options.
# - name: !bash -c "$(curl -fsSL https://raw.githubusercontent.com/jcaillon/valet/latest/commands.d/self-install.sh)" -s --single-user-installation --unattended
#   description: |-
#     Install the latest version of Valet in the user home directory and disable all interaction during the install process.
##VALET_COMMAND
function selfUpdate() {
  local unattended singleUserInstallation version installationDirectory noShim noPath noShowcase skipExtensions onlyExtensions useBranch skipExtensionsSetup

  # if this script is run directly
  if [[ ${_NOT_EXECUTED_FROM_VALET:-false} == "true" ]]; then
    log::debug "Parsing arguments manually (basic parsing only): ⌜${*}⌝."
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
        [[ $# -eq 0 ]] && core::fail "Missing value for 'version number' after the option --version."
        version="${1}"
        ;;
      -d | --installation-directory)
        shift
        [[ $# -eq 0 ]] && core::fail "Missing value for 'the installation directory' after the option --installation-directory."
        installationDirectory="${1}"
        ;;
      -S | --no-shim)
        noShim="true"
        ;;
      -P | --no-path)
        noPath="true"
        ;;
      --no-showcase)
        noShowcase="true"
        ;;
      -U | --skip-extensions)
        skipExtensions="true"
        ;;
      -e | --only-extensions)
        onlyExtensions="true"
        ;;
      -b | --use-branch)
        useBranch="true"
        ;;
      --skip-extensions-setup)
        skipExtensionsSetup="true"
        ;;
      -*) core::fail "Unknown option ⌜${1}⌝." ;;
      *) core::fail "This command takes no arguments, did not understand ⌜${1}⌝." ;;
      esac
      shift
    done
    unattended="${unattended:-"${VALET_UNATTENDED:-"false"}"}"
    singleUserInstallation="${singleUserInstallation:-"${VALET_SINGLE_USER_INSTALLATION:-"false"}"}"
    version="${version:-"${VALET_VERSION:-"latest"}"}"
    installationDirectory="${installationDirectory:-"${VALET_INSTALLATION_DIRECTORY:-}"}"
    noShim="${noShim:-"${VALET_NO_SHIM:-"false"}"}"
    noPath="${noPath:-"${VALET_NO_PATH:-"false"}"}"
    noShowcase="${noShowcase:-"${VALET_NO_EXAMPLES:-"false"}"}"
    skipExtensions="${skipExtensions:-"${VALET_SKIP_EXTENSION:-"false"}"}"
    onlyExtensions="${onlyExtensions:-"${VALET_ONLY_EXTENSION:-"false"}"}"
    useBranch="${useBranch:-"${VALET_USE_BRANCH:-"false"}"}"
    skipExtensionsSetup="${skipExtensionsSetup:-"${VALET_SKIP_EXTENSIONS_SETUP:-"false"}"}"
  else
    log::debug "Parsing the arguments using the core functions."
    command::parseArguments "$@" && eval "${RETURNED_VALUE}"
    command::checkParsedResults
  fi

  # get the os
  system::getOs
  local os="${RETURNED_VALUE}"
  log::debug "The current OS is ⌜${os}⌝."

  # get the user directory
  core::getUserValetDirectory
  local userValetDirectory="${RETURNED_VALUE}"

  # check if valet already exists
  local firstInstallation="${_NOT_EXECUTED_FROM_VALET:-false}"
  if [[ ${firstInstallation} != "true" ]]; then
    log::debug "Executing a self update from Valet."

    # only update extensions ?
    if [[ ${onlyExtensions} == "true" ]]; then
      command::sourceFunction selfExtend
      selfExtend::updateExtensions "${userValetDirectory}" "${skipExtensionsSetup}"
      return 0
    fi

  elif command -v valet &>/dev/null; then
    log::warning "Valet is already installed but you are executing the install script. It could be updated using the 'valet self update' command."
    if [[ ${unattended} != "true" ]] && ! interactive::promptYesNo "Execute this installation script?" "true"; then
      core::fail "Installation aborted."
    fi
  fi


  # get the latest version if needed
  if [[ ${useBranch} != "true" && ${version:-"latest"} == "latest" ]]; then
    log::debug "Getting the latest version from GitHub."
    selfUpdate_getLatestReleaseVersion
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
    version::compare "${currentVersion}" "${version}"
    if [[ ${RETURNED_VALUE} == "0" || ${RETURNED_VALUE} == "1" ]]; then
      log::info "The current local version ⌜${currentVersion}⌝ is higher or equal to the distant version ⌜${version}⌝."
      log::success "You already have the latest version."
      if [[ ${skipExtensions} != "true" ]]; then
        command::sourceFunction selfExtend
        selfExtend::updateExtensions "${userValetDirectory}" "${skipExtensionsSetup}"
      fi
      return 0
    fi
  fi

  # compute the release URL
  local releaseUrl="https://github.com/jcaillon/valet/releases/download/v${version}/valet.tar.gz"
  if [[ ${useBranch} == "true" ]]; then
    releaseUrl="https://github.com/jcaillon/valet/archive/${version}.tar.gz"
  fi

  # compute the target directories
  local -a binDirectories
  if [[ ${singleUserInstallation:-} == "true" || "${os}" == "windows" ]]; then
    log::debug "Installing Valet for the current user only."
    GLOBAL_INSTALLATION_DIRECTORY="${installationDirectory:-${GLOBAL_INSTALLATION_DIRECTORY:-"${HOME}/.local/valet"}}"
  else
    log::debug "Installing Valet for all users."
    GLOBAL_INSTALLATION_DIRECTORY="${installationDirectory:-${GLOBAL_INSTALLATION_DIRECTORY:-"/opt/valet"}}"
    binDirectories+=("/usr/local/bin")
  fi
  binDirectories+=("${HOME}/.local/bin")
  binDirectories+=("${HOME}/bin")

  # check if one of the bin directories is in the PATH
  local dir binDirectory=""
  for dir in "${binDirectories[@]}"; do
    if selfUpdate_isDirectoryInPath "${dir}"; then
      binDirectory="${dir}"
      break
    fi
  done
  if [[ ${firstInstallation} != "true" ]] && command -v valet &>/dev/null; then
    # on update, do not create a shim or add to PATH
    noPath=true
    noShim=true
  fi

  # display a recap to the user
  local createShim=false addToPath=false copyExamples=false
  printf '\n  %s\n\n' "${AC__TEXT_UNDERLINE}Valet installation recap:${AC__TEXT_RESET}"
  selfUpdate_printRecapLine "Operating system:" "${os}"
  if [[ ${firstInstallation} != "true" ]]; then
    selfUpdate_printRecapLine "First installation:" "${firstInstallation}"
    selfUpdate_printRecapLine "Current Valet version:" "${currentVersion}"
  fi
  selfUpdate_printRecapLine "Version to install:" "${version}"
  if [[ ${useBranch} == "true" ]]; then
    selfUpdate_printRecapLine "Download from a branch:" "true"
  fi
  selfUpdate_printRecapLine "Download URL:" "${releaseUrl}"
  selfUpdate_printRecapLine "Installation dir:" "${GLOBAL_INSTALLATION_DIRECTORY}"
  if [[ ${noShim} != "true" && -n ${binDirectory} ]]; then
    selfUpdate_printRecapLine "Create shim in dir:" "${binDirectory}"
    createShim=true
  fi
  if [[ ${noPath} != "true" && -z ${binDirectory} ]] && ! selfUpdate_isDirectoryInPath "${GLOBAL_INSTALLATION_DIRECTORY}"; then
    selfUpdate_printRecapLine "Add install dir to PATH:" "true"
    addToPath=true
  fi
  if [[ ${noShowcase} != "true" && (${firstInstallation} == "true" || -d "${userValetDirectory}/showcase.d" ) ]]; then
    selfUpdate_printRecapLine "Copy showcase to:" "${userValetDirectory}"
    copyExamples=true
  else
    selfUpdate_printRecapLine "Skip showcase copy:" "true"
  fi
  printf '\n'

  # ask for confirmation
  if [[ ${unattended} != "true" ]]; then
    interactive::promptYesNo "Proceed with the installation?" "true" || core::fail "Installation aborted."
  fi

  selfUpdate_testCommand "chmod"

  # install valet
  if [[ -d "${GLOBAL_INSTALLATION_DIRECTORY}/.git" ]]; then
    # case where valet directory is a git repository
    log::info "The Valet directory ⌜${GLOBAL_INSTALLATION_DIRECTORY}⌝ already exists and is a git repository, it will be updated using git."
    selfUpdate_updateGitRepository "${GLOBAL_INSTALLATION_DIRECTORY}" || core::fail "Failed to update the git repository ⌜${GLOBAL_INSTALLATION_DIRECTORY}⌝, clean your workarea first (e.g. git stash, or git commit)."

    chmod +x "${GLOBAL_INSTALLATION_DIRECTORY}/valet"
  else
    # download and install valet
    selfUpdate_install "${releaseUrl}" "${unattended}" "${useBranch}" "${version}"
  fi

  if [[ ${copyExamples} == "true" ]]; then
    selfUpdate_copyExamples "${userValetDirectory}"
  fi

  # remove the user commands to rebuild them
  core::getUserDataDirectory
  rm -f "${RETURNED_VALUE}/commands" 1>/dev/null || :

  if [[ ${firstInstallation} == "true" ]]; then
    # shellcheck source=../libraries.d/core
    source "${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/core"
    log::debug "Sourcing the core functions from valet."
    selfUpdate_sourceDependencies
  else
    core::reloadUserCommands
  fi

  if [[ ${createShim} == "true" ]]; then
    selfUpdate_createShim "${binDirectory}"
  fi

  if [[ ${addToPath} == "true" ]]; then
    system::addToPath "${GLOBAL_INSTALLATION_DIRECTORY}"
  fi

  # run the post install command
  if [[ ${unattended} != "true" && ${firstInstallation} == "true" ]]; then
    log::info "Running the self setup command."
    command::sourceFunction selfSetup
    selfSetup

    # tell the user about what's next todo
    log::info "As a reminder, you can modify the configuration done during this set up by either:"$'\n'"- replaying the command ⌜valet self setup⌝,"$'\n'"- running the command ⌜valet self config⌝."
    log::info "Run ⌜valet --help⌝ to get started."
  else
    # re-export the config file to be up to date (done in setup as well)
    command::sourceFunction selfConfig
    selfConfig --no-edit --override --export-current-values
  fi

  # update the extensions
  if [[ ${firstInstallation} != "true" && ${skipExtensions} != "true" ]]; then
    command::sourceFunction selfExtend
    selfExtend::updateExtensions "${userValetDirectory}" "${skipExtensionsSetup}"
  fi
}

function selfUpdate_printRecapLine() {
  printf '  - %s%-30s%s%s\n' "${AC__TEXT_BOLD}" "${1}" "${AC__FG_MAGENTA}${2}" "${AC__TEXT_RESET}"
}

# Install Valet using the given release URL.
function selfUpdate_install() {
  local releaseUrl="${1}"
  local unattended="${2}"
  local useBranch="${3}"
  local version="${4}"

  selfUpdate_testCommand "tar"
  selfUpdate_testCommand "mkdir"
  selfUpdate_testCommand "touch"
  selfUpdate_testCommand "rm"
  selfUpdate_testCommand "mv"

  # temporary directory for the installation
  local tempDirectory
  if command -v fs::createTempDirectory 1>/dev/null; then
    fs::createTempDirectory
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

  log::debug "Downloading the release from ⌜${releaseUrl}⌝."
  progress::start "<spinner> Downloading valet..."
  selfUpdate_download "${releaseUrl}" "${releaseFile}"
  progress::stop

  log::debug "Unpacking the release in ⌜${GLOBAL_INSTALLATION_DIRECTORY}⌝."
  tar -xzf "${releaseFile}" -C "${tempDirectory}" || core::fail "Could not unpack the release ⌜${releaseFile}⌝ using tar."
  log::debug "The release has been unpacked in ⌜${GLOBAL_INSTALLATION_DIRECTORY}⌝."

  if [[ ${useBranch} == "true" ]]; then
    # when downloaded from a tarball, a sub director named valet-version is created
    # we need to move the content of this directory to the parent directory
    local subDirectory="${tempDirectory}/valet-${version}"
    if [[ ! -d ${subDirectory} ]]; then
      core::fail "The downloaded branch tarball does not contain the expected directory ⌜${subDirectory}⌝."
    fi
    log::debug "Moving the content of ⌜${subDirectory}⌝ to ⌜${tempDirectory}⌝."
    mv -f "${subDirectory}"/* "${tempDirectory}" || core::fail "Could not move the content of ⌜${subDirectory}⌝ to ⌜${tempDirectory}⌝."
    rm -Rf "${subDirectory}" 1>/dev/null || :
  fi

  # figure out if we need to use sudo
  selfUpdate_setSudoIfNeeded "${GLOBAL_INSTALLATION_DIRECTORY}"

  # remove the old valet directory and move the new one
  ${_SUDO} rm -f "${releaseFile}"
  ${_SUDO} rm -Rf "${GLOBAL_INSTALLATION_DIRECTORY}"
  ${_SUDO} mv -f "${tempDirectory}" "${GLOBAL_INSTALLATION_DIRECTORY}"
  log::info "Valet has been copied in ⌜${GLOBAL_INSTALLATION_DIRECTORY}⌝."

  if [[ -n ${_SUDO} ]]; then
    # make the valet directory readable by anyone
    ${_SUDO} chown -R 644 "${GLOBAL_INSTALLATION_DIRECTORY}"
  fi

  # make valet executable
  ${_SUDO} chmod +x "${GLOBAL_INSTALLATION_DIRECTORY}/valet"

  if [[ -d ${tempDirectory} ]]; then
    rm -Rf "${tempDirectory}" 1>/dev/null || :
  fi

  log::success "Valet has been installed in ⌜${GLOBAL_INSTALLATION_DIRECTORY}⌝."
}

# Copy the showcase to the user directory.
function selfUpdate_copyExamples() {
  local userValetDirectory="${1}"

  mkdir -p "${userValetDirectory}" || core::fail "Could not create the user directory ⌜${userValetDirectory}⌝."

  if [[ -d "${userValetDirectory}/showcase.d" ]]; then
    rm -Rf "${userValetDirectory}/showcase.d" &>/dev/null || core::fail "Could not remove the existing showcase (command examples) in ⌜${userValetDirectory}⌝."
  fi

  cp -R "${GLOBAL_INSTALLATION_DIRECTORY}/showcase.d" "${userValetDirectory}" || core::fail "Could not copy the showcase (command examples) to ⌜${userValetDirectory}⌝."

  log::success "The showcase has been copied to ⌜${userValetDirectory}/showcase.d⌝."
}

# Set the _SUDO variable if needed.
function selfUpdate_setSudoIfNeeded() {
  _SUDO=""
  if ! selfUpdate_isDirectoryWritable "${1}" "${2:-}"; then
    if [[ ${unattended} == "true" ]]; then
      core::fail "The directory ⌜${1}⌝ is not writable: run this command with sudo or use the option ⌜--single-user-installation⌝."
    elif ! command -v sudo &>/dev/null; then
      core::fail "The directory ⌜${1}⌝ is not writable and you do not have sudo installed."
    else
      log::warning "The directory ⌜${1}⌝ is not writable, attempting to run the command using sudo."
      _SUDO='sudo'
      if ! selfUpdate_isDirectoryWritable "${1}" "${2:-}"; then
        core::fail "The directory ⌜${1}⌝ is not writable even with sudo."
      fi
    fi
  fi
}

# Check if a directory is writable.
function selfUpdate_isDirectoryWritable() {
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

# Check if a given directory is in the PATH.
function selfUpdate_isDirectoryInPath() {
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
function selfUpdate_getLatestReleaseVersion() {
  local jsonFile="${TMPDIR:-/tmp}/valet.latest.json"
  progress::start "<spinner> Fetching the latest version from GitHub API..."
  selfUpdate_download "https://api.github.com/repos/jcaillon/valet/releases/latest" "${jsonFile}"
  progress::stop
  fs::readFile "${jsonFile}"
  rm -f "${jsonFile}" 1>/dev/null
  if [[ ${RETURNED_VALUE} =~ "tag_name\":"([ ]?)"\"v"([^\"]+)"\"" ]]; then
    RETURNED_VALUE="${BASH_REMATCH[2]}"
  else
    log::debug "${RETURNED_VALUE}"
    core::fail "Could not get the latest version from GitHub (did not find tag_name)."
  fi
}

# Downloads a file to a specific location.
function selfUpdate_download() {
  local url="${1}"
  local output="${2}"

  if command -v curl &>/dev/null; then
    curl --fail --silent --show-error --location --output "${output}" "${url}" || core::fail "Could not download from ⌜${url}⌝ to ⌜${output}⌝."
  elif command -v wget &>/dev/null; then
    wget --quiet --output-document="${output}" "${url}" || core::fail "Could not download from ⌜${url}⌝ to ⌜${output}⌝."
  else
    core::fail "You need ⌜curl⌝ or ⌜wget⌝ installed and in your PATH."
  fi
}

# verify the presence of a command or fail if it does not exist
function selfUpdate_testCommand() {
  if ! command -v "${1}" &>/dev/null; then
    core::fail "⌜${1}⌝ is required but is not installed or not found in your PATH."
  fi
}

# Update a git repository.
function selfUpdate_updateGitRepository() {
  local repoPath="${1}"

  if [[ ! -f "${repoPath}/.git/HEAD" ]]; then
    core::fail "The directory ⌜${repoPath}⌝ is not a git repository."
  fi

  if ! command -v git &>/dev/null; then
    core::fail "The command ⌜git⌝ is not installed or not found in your PATH."
  fi

  log::debug "Updating the git repository ⌜${repoPath}⌝."

  fs::readFile "${repoPath}/.git/HEAD"
  if [[ ${RETURNED_VALUE} =~ ^"ref: refs/heads/"(.+) ]]; then
    local branch="${BASH_REMATCH[1]:-}"
    branch="${branch%%$'\n'*}"
    log::info "Fetching and merging branch ⌜${branch}⌝ from ⌜origin⌝ remote."
    pushd "${repoPath}" &>/dev/null || core::fail "Could not change to the directory ⌜${repoPath}⌝."
    if ! git fetch -q; then
      popd &>/dev/null || :
      return 1
    fi
    if ! git merge -q --ff-only "origin/${branch}" &>/dev/null; then
      popd &>/dev/null || :
      return 1
    fi
    popd &>/dev/null || :
    return 0
  fi

  core::fail "The git repository ⌜${repoPath}⌝ does not have a checked out branch to pull."
}

# source the dependencies of this script
function selfUpdate_sourceDependencies() {
  # shellcheck source=../libraries.d/lib-system
  source system
  # shellcheck source=../libraries.d/lib-interactive
  source interactive
  # shellcheck source=../libraries.d/lib-progress
  source progress
  # shellcheck source=../libraries.d/lib-ansi-codes
  source ansi-codes
  # shellcheck source=../libraries.d/lib-fs
  source fs
  # shellcheck source=../libraries.d/lib-string
  source string
  # shellcheck source=../libraries.d/lib-version
  source version
}

# Create a shim (script that calls valet) in a bin directory.
function selfUpdate_createShim() {
  local binDirectory="${1}"

  # figure out if we need to use sudo
  selfUpdate_setSudoIfNeeded "${binDirectory}" "valet"

  # create the shim in the bin directory
  local valetBin="${binDirectory}/valet"

  log::info "Creating a shim ⌜${valetBin}⌝ → ⌜${GLOBAL_INSTALLATION_DIRECTORY}/valet⌝."
  ${_SUDO} bash -c "printf '#%s%s\nsource %s \"\$@\"' \"!\" \"/usr/bin/env bash\" \"'${GLOBAL_INSTALLATION_DIRECTORY}/valet'\" 1> \"${valetBin}\""
  ${_SUDO} chmod +x "${valetBin}"
}

# Add the given directory path to the PATH.
function selfUpdate_addToPath() {
  local binDirectory="${1}"
  local unattended="${2}"

  log::info "Attempting to add the Valet directory ⌜${binDirectory}⌝ to the PATH."

  local configFile configContent
  for shellName in "bash" "ksh" "zsh" "tcsh" "csh" "xonsh" "fish" "nushell"; do
    # shellcheck disable=SC2088
    if ! command -v "${shellName}" &>/dev/null; then
      continue
    fi

    configFile="${HOME}/.${shellName}rc"

    case ${shellName} in
    fish)
      # shellcheck disable=SC2088
      configFile="${HOME}/.config/fish/config.fish"
      mkdir -p "${HOME}/.config/fish"
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

    if [[ ${unattended} != "true" ]] && ! interactive::promptYesNo "Do you want to modify ⌜${configFile}⌝ as described above ?" "true"; then
      continue
    fi

    printf '\n\n%s\n' "${configContent}" >> "${configFile}"
  done

  export PATH="${binDirectory}:${PATH}"
  log::warning "Please login again to apply the changes to your path and make valet available."
}


#===============================================================
# >>> main
#===============================================================

# set the version to download by default
# this is automatically updated by the self release command
VALET_RELEASED_VERSION="0.27.285"

# import the core script (should always be skipped if the command is run from valet)
if [[ ! -v GLOBAL_CORE_INCLUDED ]]; then
  _NOT_EXECUTED_FROM_VALET=true

  set -Eeu -o pipefail

  VALET_VERSION="${VALET_VERSION:-${VALET_RELEASED_VERSION}}"

  # determine if we support colors (can be overridden by the user with VALET_CONFIG_ENABLE_COLORS)
  case "${TERM:-}" in
  xterm-color | xterm-256color | linux) VALET_CONFIG_ENABLE_COLORS="${VALET_CONFIG_ENABLE_COLORS:-true}" ;;
  xterm) if [[ -n ${COLORTERM:-} ]]; then VALET_CONFIG_ENABLE_COLORS="${VALET_CONFIG_ENABLE_COLORS:-true}"; fi ;;
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
  function system::getOs() {
    case "${OSTYPE:-}" in
    darwin*) RETURNED_VALUE="darwin" ;;
    linux*) RETURNED_VALUE="linux" ;;
    msys*) RETURNED_VALUE="windows" ;;
    *) RETURNED_VALUE="unknown" ;;
    esac
  }
  function core::getUserValetDirectory() { RETURNED_VALUE="${VALET_CONFIG_USER_VALET_DIRECTORY:-${HOME}/.valet.d}"; }
  function core::getUserDataDirectory() { RETURNED_VALUE="${VALET_CONFIG_USER_DATA_DIRECTORY:-${XDG_DATA_HOME:-${HOME}/.local/share}/valet}"; }
  function interactive::promptYesNo() {
    local question="${1}"
    local default="${2:-false}"
    if [[ ${default} == "true" ]]; then
      printf "%s [Y/n] " "${question}"
    else
      printf "%s [y/N] " "${question}"
    fi
    local IFS=''
    read -d '' -srn 1 LAST_KEY_PRESSED
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
  function fs::readFile() { RETURNED_VALUE="$(<"${1}")"; }
  function progress::start() { :; }
  function progress::stop() { :; }
else
  selfUpdate_sourceDependencies
fi

# This is put in braces to ensure that the script does not run until it is downloaded completely.
{
  # if this script is run directly, execute the function, otherwise valet will do it
  if [[ ${_NOT_EXECUTED_FROM_VALET:-false} == "true" ]]; then
    selfUpdate "$@"
  fi
}
