#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-version
source version
# shellcheck source=../libraries.d/lib-interactive
source interactive
# shellcheck source=../libraries.d/lib-progress
source progress
# shellcheck source=../libraries.d/lib-curl
source curl

: <<"COMMAND_YAML"
command: self update
function: selfUpdate
author: github.com/jcaillon
shortDescription: Update valet to the latest release.

description: |-
  Update valet using the latest release on GitHub.

options:
- name: --unattended
  description: |-
    Set to true to update without interactive confirmation.
  default: false

examples:
- name: self update
  description: |-
    Update Valet to the latest version.
- name: self update --unattended
  description: |-
    Update Valet to the latest version without interactive confirmation.
COMMAND_YAML
function selfUpdate() {
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  # get the latest version if needed
  log::debug "Getting the latest version from GitHub."
  selfUpdate_getLatestReleaseVersion
  version="${REPLY}"
  log::info "The latest version of Valet found on GitHub is ⌜${version}⌝."

  # get the current version
  core::getVersion
  local currentVersion="${REPLY}"
  string::trimAll currentVersion

  # compare local and distant versions
  version::compare "${currentVersion}" "${version}"
  if [[ ${REPLY} == "0" || ${REPLY} == "1" ]]; then
    log::info "The current local version ⌜${currentVersion}⌝ is higher or equal to the distant version ⌜${version}⌝."
    log::success "You already have the latest version."
    return 0
  fi

  if [[ -d "${GLOBAL_INSTALLATION_DIRECTORY}/.git" ]]; then
    core::fail "Valet has been installed using git, so it cannot be updated using this command. Please update it manually by running ⌜git -C ${GLOBAL_INSTALLATION_DIRECTORY} fetch && git -C ${GLOBAL_INSTALLATION_DIRECTORY} checkout ${version}⌝."
  fi

  local scriptUrl="https://raw.githubusercontent.com/jcaillon/valet/${VALET_TEST_OVERRIDE_LATEST_VERSION:-"v${version}"}/install.sh"

  log::info "The install script will be fetched and executed from the url ⌜${scriptUrl}⌝."
  if [[ ${unattended:-} != "true" ]] && ! interactive::confirm "A new version of Valet is available. Do you want to update from version ⌜${currentVersion}⌝ to version ⌜${version}⌝?" default=false; then
    log::info "Update cancelled by the user."
    return 0
  fi

  selfUpdate_installFromScript "${scriptUrl}"

  log::success "Valet has been updated from version ⌜${currentVersion}⌝ to version ⌜${version}⌝."$'\n'"The changelogs can be found here: https://github.com/jcaillon/valet/releases."
}

# Install Valet using the given release URL.
function selfUpdate_installFromScript() {
  local scriptUrl="${1}"

  progress::start template="<spinner> Fetching the latest install script from GitHub..."
  curl::download "${scriptUrl}" --- failOnError=true
  local scriptPath="${REPLY}"
  progress::stop

  exe::invoke chmod +x "${scriptPath}"

  log::info "Running the install script..."
  export VALET_UNATTENDED=true
  export VALET_INSTALLATION_DIRECTORY="${GLOBAL_INSTALLATION_DIRECTORY}"
  exe::invoke "${BASH:-bash}" "${scriptPath}" --- noRedirection=true
}

# Get the version number of the latest release on GitHub.
function selfUpdate_getLatestReleaseVersion() {
  progress::start template="<spinner> Fetching the latest version from GitHub API..."
  curl::request "https://api.github.com/repos/jcaillon/valet/releases/latest" --- failOnError=true
  local version
  if [[ ${REPLY} =~ "tag_name\":"([ ]?)"\"v"([^\"]+)"\"" ]]; then
    version="${BASH_REMATCH[2]}"
  else
    log::debug "GitHub API response:"$'\n'"${REPLY}"
    core::fail "Could not get the latest version from GitHub (did not find tag_name)."
  fi
  progress::stop
  REPLY="${version}"
}
