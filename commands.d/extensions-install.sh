#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

# shellcheck source=../libraries.d/lib-exe
source exe
# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-interactive
source interactive
# shellcheck source=../libraries.d/lib-progress
source progress
# shellcheck source=../libraries.d/lib-bash
source bash
# shellcheck source=../libraries.d/lib-command
source command
# shellcheck source=./extensions-utils
source ./extensions-utils

#===============================================================
# >>> command: extensions install
#===============================================================

: <<"COMMAND_YAML"
command: extensions install
function: extensionsInstall
author: github.com/jcaillon
shortDescription: Download and install a new extension in the user directory using GIT.

description: |-
  Download and install a new extension in the user directory using GIT.

  This command will download the given extension (GIT repository) and install it in the valet extensions directory.

  For downloaded extensions, if a `extension.setup.sh` script is present in the repository root directory,
  it will be executed. This gives the extension the opportunity to setup itself.

  Once an extension is installed, you can use the `valet extensions update` command to update it.

arguments:
- name: git-repo
  description: |-
    The GIT repository of the extension to install.

    For example `https://github.com/jcaillon/valet-devops-toolbox.git`.

    > If the repository is private, you can pass the URL with the username and password like this:
    > `https://username:password@my.gitlab.private/group/project.git`.

options:
- name: -n, --name <extension-name>
  description: |-
    The name to give to this extension.
    If a name is not provided, the name of the repository will be used.
- name: -v, --version <version>
  description: |-
    The version (git reference) to checkout for the repository to download.
    Usually a tag or a branch name.
  default: latest
- name: --skip-setup
  description: |-
    Skip the execution of the `extension.setup.sh` script even if it exists.
  default: false
- name: --unattended
  description: |-
    Set to true to install without interactive confirmation.
  default: false

examples:
- name: extensions install https://github.com/jcaillon/valet-devops-toolbox.git
  description: |-
    Download the latest version of the valet-devops-toolbox application and install it for Valet.
- name: extensions install https://github.com/jcaillon/valet-devops-toolbox.git --name extension-1 --version main --skip-setup
  description: |-
    Download the ⌜main⌝ reference of the jcaillon/valet-devops-toolbox repository and install it as ⌜extension-1⌝ for Valet.
    Skip the execution of the `extension.setup.sh` script.
COMMAND_YAML
function extensionsInstall() {
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  # compute where to install the extension
  core::getExtensionsDirectory
  local extensionsDirectory="${REPLY}"

  local repositoryName
  if [[ ${gitRepo:-} =~ .*/([^/]+) ]]; then
    repositoryName="${BASH_REMATCH[1]:-}"
    repositoryName="${repositoryName%.git}"
  fi
  local extensionName="${name:-${repositoryName:-${gitRepo}}}"
  local extensionDirectory="${extensionsDirectory}/${extensionName}"
  log::info "The extension will be installed under ⌜${extensionDirectory}⌝."

  # if the extension already exists, ask the user for a confirmation
  if [[ -d "${extensionDirectory}" ]]; then
    log::warning "The extension ⌜${extensionName}⌝ already exists in ⌜${extensionDirectory}⌝."
    if [[ ${unattended:-} == "true" ]] || ! interactive::confirm "You are about to replace the existing extension, it will delete existing files."$'\n'"Do you want to overwrite the existing ⌜${extensionName}⌝ extension?"; then
      log::info "The extension ⌜${extensionName}⌝ will not be installed."
      return 0
    fi
  fi

  # clone the repository for the correct reference
  extensionsInstall_gitClone "${gitRepo}" "${version}" "${extensionDirectory}" "${unattended}"

  # get the version of the extension if possible
  local extensionNameWithVersion="⌜${extensionName}⌝"
  extensions::getVersion "${extensionDirectory}"
  if [[ -n ${REPLY} ]]; then
    extensionNameWithVersion+=" version ⌜${REPLY}⌝"
  fi

  log::info "The extension ${extensionNameWithVersion} has been downloaded in ⌜${extensionDirectory}⌝."

  # execute the setup script of the extension, if any
  if [[ ${skipSetup:-} != "true" ]]; then
    extensions::executeSetupScript "${extensionDirectory}" "${unattended}"
  else
    log::info "Skipping the execution of the ⌜extension.setup.sh⌝ script."
  fi

  log::success "The extension ${extensionNameWithVersion} has been successfully installed."

  # rebuild the command cache
  log::info "Rebuilding the command cache."
  command::deleteCommandsIndex
  command::reloadCommandsIndex

  # rebuild the documentation
  log::info "Rebuilding the documentation."
  command::sourceFunction selfDocument
  selfDocument

  log::success "The extension ${extensionNameWithVersion} is ready to be used."
}

# git clone a given repository in a target directory.
function extensionsInstall_gitClone() {
  local \
    url="${1}" \
    version="${2}" \
    targetDirectory="${3}" \
    unattended="${4}"

  if ! command -v git &>/dev/null; then
    core::fail "The command ⌜git⌝ is not installed or not found in your PATH, the extension cannot be installed. Consider installing git or check your PATH variable."
  fi

  log::info "Cloning the git repository ⌜${url}⌝ in ⌜${targetDirectory}⌝."

  progress::start template="<spinner> Cloning repo, please wait..."
  command rm -rf "${targetDirectory}"
  exe::invoke command git clone --no-checkout "${url}" "${targetDirectory}"
  progress::stop

  if ! command git -C "${targetDirectory}" rev-parse "origin/${version}" &>/dev/null; then
    local newReference="main"
    if ! command git -C "${targetDirectory}" rev-parse "origin/${newReference}" &>/dev/null; then
      newReference="master"
      if ! command git -C "${targetDirectory}" rev-parse "origin/${newReference}" &>/dev/null; then
        newReference=""
      fi
    fi

    if [[ ${unattended} == "true" || -z ${newReference} ]]; then
      command rm -rf "${targetDirectory}"
      core::fail "The reference ⌜${version}⌝ was not found in the repository ⌜${url}⌝, please specify an existing reference using the ⌜--version⌝ option."
      return 0
    fi

    if ! interactive::confirm "The reference ⌜${version}⌝ was not found in the repository ⌜${url}⌝, do you want to use the default reference ⌜${newReference}⌝ instead?"; then
      command rm -rf "${targetDirectory}"
      core::fail "Installation aborted by the user due to missing reference."
    fi

    version="${newReference}"
  fi

  log::info "Checking out the reference ⌜${version}⌝."
  exe::invoke command git -C "${targetDirectory}" checkout -q "${version}"
}
