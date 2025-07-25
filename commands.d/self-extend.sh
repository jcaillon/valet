#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ ! -v GLOBAL_CORE_INCLUDED ]]; then
  # shellcheck source=../libraries.d/core
  source "$(valet --source)"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../libraries.d/lib-exe
source exe
# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-system
source system
# shellcheck source=../libraries.d/lib-interactive
source interactive
# shellcheck source=../libraries.d/lib-progress
source progress
# shellcheck source=../libraries.d/lib-curl
source curl
# shellcheck source=../libraries.d/lib-bash
source bash

#===============================================================
# >>> command: self extend
#===============================================================

##<<VALET_COMMAND
# command: self extend
# function: selfExtend
# author: github.com/jcaillon
# shortDescription: Extends Valet by creating or downloading a new extension in the user directory.
# description: |-
#   Extends Valet by creating or downloading a new extension in the user directory.
#   Extensions can add new commands or functions to Valet.
#
#   This command will either:
#
#   - Create and setup a new extension directory under the valet user directory,
#   - setup an existing directory as a valet extension,
#   - or download the given extension (repository) and install it in the Valet user directory.
#
#   For downloaded extensions, all GIT repositories are supported.
#   For the specific cases of GitHub and GitLab repositories, this command will:
#
#   1. If git is installed, clone the repository for the given reference (version option).
#   2. If git is not installed, download source tarball for the given reference and extract it.
#
#   For downloaded extensions, if a `extension.setup.sh` script is present in the repository root directory,
#   it will be executed. This gives the extension the opportunity to setup itself.
#
#   Once an extension is installed, you can use the `valet self update` command to update it.
# arguments:
# - name: extension-uri
#   description: |-
#     The URI of the extension to install or create.
#
#     1. If you want to create a new extension, this argument should be the name of your
#        new extension (e.g. `my-new-extension`).
#     2. If you want to setup an existing directory as an extension, this argument should be `.`.
#     3. If you want to download an extension, this argument should be the URL of the repository.
#        Usually a GitHub or GitLab repository URL such as `https://github.com/jcaillon/valet-devops-toolbox.git`.
#
#     > If the repository is private, you can pass the URL with the username and password like this:
#     > `https://username:password@my.gitlab.private/group/project.git`.
# options:
# - name: -v, --version <version>
#   description: |-
#     The version of the repository to download.
#     Usually a tag or a branch name.
#   default: latest
# - name: -n, --name <extension-name>
#   description: |-
#     The name to give to this extension.
#     If a name is not provided, the name of the repository will be used.
# - name: --skip-setup
#   description: |-
#     Skip the execution of the `extension.setup.sh` script even if it exists.
# examples:
# - name: self extend my-new-extension
#   description: |-
#     Create a new extension named ⌜my-new-extension⌝ in the user directory.
# - name: self extend .
#   description: |-
#     Setup the current directory as an extension in the user directory.
# - name: self extend https://github.com/jcaillon/valet-devops-toolbox.git
#   description: |-
#     Download the latest version of the valet-devops-toolbox application and install it for Valet.
# - name: self extend https://github.com/jcaillon/valet --version extension-1 --name extension-1 --skip-setup
#   description: |-
#     Download the ⌜extension-1⌝ reference of the valet repository and install it as ⌜extension-1⌝ for Valet.
#     Skip the execution of the `extension.setup.sh` script.
#     (This is actually a fake extension for testing purposes).
##VALET_COMMAND
function selfExtend() {
  local extensionUri version skipSetup name
  command::parseArguments "$@" && eval "${REPLY}"
  command::checkParsedResults

  local action="created"
  if [[ ${extensionUri} =~ ^(https|git) ]]; then
    action="installed"
  fi

  # compute where to install the extension
  core::getExtensionsDirectory
  local extensionsDirectory="${REPLY}"

  # case of extension creation
  if [[ ${action} == "created" ]]; then
    selfExtend_createExtension "${extensionUri}" "${extensionsDirectory}"
    return 0
  fi

  local repositoryName
  if [[ ${extensionUri} =~ .*/([^/]+) ]]; then
    repositoryName="${BASH_REMATCH[1]:-}"
    repositoryName="${repositoryName%.git}"
  fi
  local extensionName="${name:-${repositoryName:-${extensionUri}}}"
  local extensionDirectory="${extensionsDirectory}/${extensionName}"
  log::info "The extension will be ${action} under ⌜${extensionDirectory}⌝."

  # if the extension already exists, ask the user for a confirmation
  if [[ -d "${extensionDirectory}" ]]; then
    log::warning "The extension ⌜${extensionName}⌝ already exists in ⌜${extensionDirectory}⌝."
    if ! interactive::promptYesNo "Do you want to overwrite the existing ⌜${extensionName}⌝ extension?" true; then
      log::info "The extension ⌜${extensionName}⌝ will not be ${action}."
      return 0
    fi
  fi

  # if Git is installed, we simply clone the repository for the correct reference
  if command -v git &>/dev/null; then
    selfExtend_gitClone "${extensionUri}" "${version}" "${extensionDirectory}"

  else
    # if Git is not installed, we download the source tarball and extract it
    # We will only be able to do that for a few git servers however
    log::info "Git is not installed, we will attempt to download the source tarball for the extension ⌜${extensionName}⌝."
    if bash::getMissingCommands curl tar; then
      local IFS=$'\n'
      core::fail "The following tools are required for this command but are not installed:"$'\n'"${REPLY_ARRAY[*]}"
    fi

    # get the sha1 of the reference, fail if not found
    selfExtend_getSha1 "${extensionUri}" "${version}"
    selfExtend_downloadTarball "${extensionUri}"  "${version}" "${extensionDirectory}" "${REPLY}"
  fi

  # execute the setup script of the extension, if any
  selfExtend_executeSetupScript "${extensionDirectory}" "${skipSetup}"

  log::success "The extension ⌜${extensionName}⌝ has been installed in ⌜${extensionDirectory}⌝."

  # rebuild the command cache
  log::info "Rebuilding the command cache."
  core::deleteUserCommands
  core::reloadUserCommands

  # rebuild the documentation
  log::info "Rebuilding the documentation."
  command::sourceFunction selfDocument
  selfDocument

  log::success "The extension ⌜${extensionName}⌝ has been installed and is ready to be used."
}

# Create a new extension for Valet.
function selfExtend_createExtension() {
  local extensionName="${1}"
  local extensionsDirectory="${2}"

  local extensionDirectory

  if [[ ${extensionName} == "." ]]; then
    # setup an existing directory as an extension
    extensionName="${PWD##*/}"
    log::info "Setting up the current directory ⌜${extensionName}⌝ as an extension."

    if [[ ${PWD} != "${extensionsDirectory}"* ]]; then
      core::fail "Extension directories must be created in the user directory ⌜${extensionsDirectory}⌝, the current directory is ⌜${PWD}⌝."
    fi
    extensionDirectory="${PWD}"
  else
    # create a new extension directory
    extensionDirectory="${extensionsDirectory}/${extensionName}"
    log::info "Creating the extension ⌜${extensionName}⌝ in ⌜${extensionDirectory}⌝."

    # if the extension already exists, ask the user for a confirmation
    if [[ -d "${extensionDirectory}" ]]; then
      log::warning "The extension ⌜${extensionName}⌝ already exists in ⌜${extensionDirectory}⌝."
      if ! interactive::promptYesNo "Do you want to overwrite the existing ⌜${extensionName}⌝ extension?" true; then
        log::info "The extension ⌜${extensionName}⌝ will not be created."
        return 0
      fi
      rm -Rf "${extensionDirectory}"
    fi

    local -a subDirectories=(commands.d libraries.d tests.d)
    local subdir
    for subdir in "${subDirectories[@]}"; do
      fs::createDirectoryIfNeeded "${extensionDirectory}/${subdir}"
    done
  fi

  # verify that we have lib-valet generated in the user directory
  if [[ ! -f "${extensionsDirectory}/lib-valet" ]]; then
    log::info "Rebuilding the documentation because ⌜${extensionsDirectory}/lib-valet⌝ is missing."
    command::sourceFunction selfDocument
    selfDocument
  fi

  if system::isWindows; then
    # shellcheck source=../libraries.d/lib-windows
    source windows

    # on windows, creating links will prompt the user for admin permissions
    # we can group all the ps1 commands and run it once at the end
    windows::startPs1Batch

    # shellcheck disable=SC2317
    function createLink() { windows::createLink "${@}"; }
  else
    # shellcheck disable=SC2317
    function createLink() { fs::createLink "${@}"; }
  fi


  # vscode stuff
  if command -v code &>/dev/null; then
    fs::createDirectoryIfNeeded "${extensionDirectory}/.vscode"
    cp -n "${GLOBAL_INSTALLATION_DIRECTORY}/extras/.vscode/settings.json" "${extensionDirectory}/.vscode/settings.json" || log::error "Could not copy the vscode settings file."
    cp -n "${GLOBAL_INSTALLATION_DIRECTORY}/extras/.vscode/extensions.json" "${extensionDirectory}/.vscode/extensions.json" || log::error "Could not copy the vscode extensions file."

    # link the snippets
    createLink "${extensionsDirectory}/valet.code-snippets" "${extensionDirectory}/.vscode/valet.code-snippets" || log::error "Could not create a symbolic link to the vscode snippets."
  fi

  # git stuff
  if command -v git &>/dev/null; then
    fs::createFileIfNeeded "${extensionDirectory}/.gitignore"
    fs::readFile "${extensionDirectory}/.gitignore"
    if [[ ${REPLY} != *"### Valet ###"* ]]; then
      local content=$'\n'$'\n'"### Valet ###"$'\n'"lib-valet"$'\n'"lib-valet.md"$'\n'".vscode/valet.code-snippets"
      fs::writeToFile "${extensionDirectory}/.gitignore" content true
    fi
  fi

  # link lib-valet
  createLink "${extensionsDirectory}/lib-valet" "${extensionDirectory}/lib-valet" || log::error "Could not create a symbolic link to the lib-valet."
  createLink "${extensionsDirectory}/lib-valet.md" "${extensionDirectory}/lib-valet.md" || log::error "Could not create a symbolic link to the lib-valet.md."

  if system::isWindows; then
    windows::endPs1Batch
  fi

  log::success "The extension ⌜${extensionName}⌝ has been setup in ⌜${extensionDirectory}⌝."
}

# Download the source tarball for a given repository and reference.
#
# Compatible git servers:
#
# - GitHub: It will use the GitHub API to get the sha1 of the reference.
#
# It stores the sha1 of the downloaded commit in the extension directory.
# It allows to know when we actually have updates.
function selfExtend_downloadTarball() {
  local repositoryUrl="${1}"
  local reference="${2}"
  local targetDirectory="${3}"
  local sha1="${4}"

  log::info "Attempting to download the source tarball for ⌜${repositoryUrl}⌝ in ⌜${targetDirectory}⌝."

  local tarballUrlPattern

  # get tarball for github api
  if [[ ${repositoryUrl} =~ "https://github.com/"([^/]+)"/"([^/]+) ]]; then
    local repoName="${BASH_REMATCH[2]:-}"
    repoName="${repoName%.git}"
    tarballUrlPattern="https://github.com/${BASH_REMATCH[1]:-}/${repoName}/archive/%SHA1%.tar.gz"
  fi

  if [[ -z ${tarballUrlPattern} || -z ${sha1} ]]; then
    core::fail "Cannot download the source tarball for the repository ⌜${repositoryUrl}⌝. Consider installing git so that the extension can be git cloned."
  fi

  local tarballUrl="${tarballUrlPattern/"%SHA1%"/"${sha1}"}"

  fs::createTempDirectory
  local tempDirectory="${REPLY}"

  # download the tarball
  log::info "Downloading the extension from the URL ⌜${tarballUrl}⌝ for sha1 ⌜${sha1}⌝."
  progress::start "<spinner> Download in progress, please wait..."
  curl::download true 200,302 "${tempDirectory}/${sha1}.tar.gz" "${tarballUrl}"
  progress::stop

  # untar
  tar -xzf "${tempDirectory}/${sha1}.tar.gz" -C "${tempDirectory}" || core::fail "Could not untar the extension tarball ⌜${tempDirectory}/${sha1}.tar.gz⌝ using tar."

  # move the files to the target directory
  rm -Rf "${targetDirectory}" 1>/dev/null || core::fail "Could not remove the existing files in ⌜${targetDirectory}⌝."
  fs::createDirectoryIfNeeded "${targetDirectory}"
  fs::listDirectories "${tempDirectory}" false
  if (( ${#REPLY_ARRAY[@]} != 1 )); then
    core::fail "The tarball ⌜${tempDirectory}/${sha1}.tar.gz⌝ did not contain a single directory."
  fi
  mv "${REPLY_ARRAY[0]}"/* "${targetDirectory}" || core::fail "Could not move the files from ⌜${REPLY_ARRAY[0]}⌝ to ⌜${targetDirectory}⌝."

  # write the sha1 to the targetDirectory so we known which commit we fetched
  fs::writeToFile "${targetDirectory}/.sha1" sha1
  fs::writeToFile "${targetDirectory}/.reference" reference
  fs::writeToFile "${targetDirectory}/.repo" repositoryUrl
}

# Get the sha1 from a git server API.
#
# Compatible git servers:
#
# - GitHub: It will use the GitHub API to get the sha1 of the reference.
function selfExtend_getSha1() {
  local repositoryUrl="${1}"
  local reference="${2}"

  log::info "Getting the head commit for the reference ⌜${reference}⌝ in the repository ⌜${repositoryUrl}⌝."

  local sha1

  # get sha1 from github api
  if [[ ${repositoryUrl} =~ "https://github.com/"([^/]+)"/"([^/]+) ]]; then
    local owner="${BASH_REMATCH[1]:-}"
    local repo="${BASH_REMATCH[2]:-}"
    repo="${repo%.git}"
    log::debug "Found owner ⌜${owner}⌝ and repo ⌜${repo}⌝ for the repository ⌜${repositoryUrl}⌝."

    # get the sha1
    REPLY=""
    progress::start "<spinner> Fetching reference information from GitHub..."
    local url="https://api.github.com/repos/${owner}/${repo}/git/refs/heads/${reference}"
    if ! curl::request false '200' -H "Accept: application/vnd.github.v3+json" "${url}"; then
      url="https://api.github.com/repos/${owner}/${repo}/git/refs/tags/${reference}"
      curl::request false '200' -H "Accept: application/vnd.github.v3+json" "${url}" || :
    fi
    local response="${REPLY}"
    local error="${REPLY2}"
    local httpCode="${REPLY3}"
    progress::stop

    if [[ ${httpCode} == 404 ]]; then
      core::fail "Could not find a branch or tag for the reference ⌜${reference}⌝ in repository ⌜${repositoryUrl}⌝: ${response}${error}."
    elif [[ ${httpCode} != 200 ]]; then
      log::warning "Unexpected error returned from the GitHub API for the URL ⌜${url}⌝: ${response}${error}"
    fi
    if [[ ${response} =~ "\"sha\":"([ ]?)"\""([^\"]+)"\"" ]]; then
      sha1="${BASH_REMATCH[2]:-}"
    else
      # sha1="ok"
      core::fail "Could not find the sha1 for the reference ⌜${reference}⌝ in the repository ⌜${repositoryUrl}⌝ using GitHub API. Check the version for this extension. Consider installing git so that the extension can be git cloned."
    fi
  fi

  if [[ -n ${sha1} ]]; then
    log::debug "Found sha1 for ⌜${repositoryUrl}⌝ and reference ⌜${reference}⌝: ${sha1}."
  fi

  REPLY="${sha1}"
}

# git clone a given repository in a target directory.
function selfExtend_gitClone() {
  local url="${1}"
  local version="${2}"
  local targetDirectory="${3}"

  local -a args=("clone")
  if [[ -n ${version} ]]; then
    args+=("--branch")
    args+=("${version}")
  fi
  args+=("${url}")
  args+=("${targetDirectory}")

  rm -Rf "${targetDirectory}"

  log::info "Cloning the git repository ⌜${url}⌝ with reference ⌜${version}⌝ in ⌜${targetDirectory}⌝."
  progress::start "<spinner> Cloning repo, please wait..."
  exe::invoke git "${args[@]}"
  progress::stop
}

# Execute the `extension.setup.sh` script of the extension, if any.
function selfExtend_executeSetupScript() {
  local extensionDirectory="${1}"
  local skipSetup="${2}"

  local extensionName="${extensionDirectory##*/}"

  if [[ ${skipSetup} == "true" ]]; then
    log::info "Skipping the execution of the ⌜extension.setup.sh⌝ script."
    return 0
  elif [[ ! -f ${extensionDirectory}/extension.setup.sh ]]; then
    log::info "No ⌜extension.setup.sh⌝ script found in the extension directory ⌜${extensionDirectory}⌝."
    return 0
  fi

  log::info "Found setup script for the extension ⌜${extensionName}⌝: ⌜${extensionDirectory}/extension.setup.sh⌝."

  # ask for confirmation before executing the setup script
  if ! interactive::promptYesNo "Do you trust the setup script for the extension ⌜${extensionName}⌝ and wish to execute it?" true; then
    log::info "The setup script for the extension ⌜${extensionName}⌝ was not trusted, skipping the setup."
    return 0
  fi

  log::info "Executing the setup script for the extension ⌜${extensionName}⌝: ⌜${extensionDirectory}/extension.setup.sh⌝."
  # shellcheck disable=SC1091
  if ! bash::runInSubshell source "${extensionDirectory}/extension.setup.sh"; then
    log::error "The extension setup script for the extension ⌜${extensionName}⌝ failed. You can manually retry the setup by running the script ⌜${extensionDirectory}/extension.setup.sh⌝."
    interactive::promptYesNo "The setup script for the extension ⌜${extensionName}⌝ failed (see above), do you want to continue anyway?" true || core::fail "The setup script for the extension ⌜${extensionName}⌝ failed."
  fi
  fs::createDirectoryIfNeeded "${extensionDirectory}/.git"
  local content="ok"
  fs::writeToFile "${extensionDirectory}/.git/.valet-setup-executed" content
  log::success "The setup script for the extension ⌜${extensionName}⌝ has been executed."
}

# A filter so select extension folders.
# shellcheck disable=SC2317
function selfExtend_filterExtensionFolder() {
  if [[ -d "${1}/.git" ]]; then
    return 1
  fi
  if [[ -f "${1}/.repo" ]]; then
    return 1
  fi
  return 0
}

# Attempts to update each git repository found in the user directory.
function selfExtend::updateExtensions() {
  local extensionsDirectory="${1}"
  local skipSetup="${2:-false}"

  if [[ ! -d "${extensionsDirectory}" ]]; then
    log::warning "The user directory ⌜${extensionsDirectory}⌝ does not exist."
    return 0
  fi

  log::info "Attempting to update all git repositories and installed extensions in ⌜${extensionsDirectory}⌝."
  fs::listDirectories "${extensionsDirectory}" true false selfExtend_filterExtensionFolder
  local path
  local allUpdateSuccess=true
  local -i count=0
  for path in "${REPLY_ARRAY[@]}"; do
    local updateSuccess=false
    local extensionName="${path##*/}"

    if [[ -f "${path}/.git/HEAD" ]]; then
      log::debug "Found a git repository for extension ⌜${extensionName}⌝."
      if ! command -v git &>/dev/null; then
        log::warning "The command ⌜git⌝ is not installed or not found in your PATH, skipping git update for repo ⌜${path}⌝."
        continue
      fi
      if ! selfExtend_updateGitRepository "${path}"; then
        allUpdateSuccess=false
      else
        updateSuccess=${REPLY}
      fi
    elif [[ -f "${path}/.repo" ]]; then
      log::debug "Found an installed extension ⌜${extensionName}⌝."
      if ! selfExtend_updateTarBall "${path}"; then
        allUpdateSuccess=false
      else
        updateSuccess=${REPLY}
      fi
    fi

    if [[ ${updateSuccess} == "true" ]]; then
      count+=1
      selfExtend_executeSetupScript "${path}" "${skipSetup}"
    fi
  done

  if [[ ${allUpdateSuccess} == "true" ]]; then
    if ((count == 0)); then
      log::info "No extensions to update in ⌜${extensionsDirectory}⌝."
    else
      log::success "A total of ⌜${count}⌝ extensions in ⌜${extensionsDirectory}⌝ have been updated."
    fi
  else
    log::warning "Some extensions in ⌜${extensionsDirectory}⌝ could not be updated, ⌜${count}⌝ were updated successfully."
  fi
}

# Update a tarball extension.
#
# Returns:
# - $?:0 if the repository was checked without errors, 1 otherwise.
# - ${REPLY}: true if the repository was updated, false otherwise.
function selfExtend_updateTarBall() {
  local extensionDirectory="${1}"

  local extensionName="${extensionDirectory##*/}"
  local hasBeenUpdated=false

  log::info "Updating the tarball extension ⌜${extensionDirectory}⌝."

  fs::readFile "${extensionDirectory}/.repo"
  local repo="${REPLY%%$'\n'*}"
  fs::readFile "${extensionDirectory}/.reference"
  local reference="${REPLY%%$'\n'*}"
  fs::readFile "${extensionDirectory}/.sha1"
  local currentSha1="${REPLY%%$'\n'*}"

  log::debug "Extension ⌜${extensionName}⌝ is from repository ⌜${repo}⌝ and reference ⌜${reference}⌝ with sha1 ⌜${currentSha1}⌝."

  if [[ -z ${repo} || -z ${reference} ]]; then
    log::warning "The extension ⌜${extensionName}⌝ (tarball) does not have a .repo or .reference file, cannot update it."
    return 1
  fi

  # get the sha1 of the reference, fail if not found
  selfExtend_getSha1 "${repo}" "${reference}"
  local newSha1="${REPLY}"

  if [[ -z ${newSha1} ]]; then
    log::warning "The extension ⌜${extensionName}⌝ (tarball) is not updatable for the reference ⌜${reference}⌝ and the repository url ⌜${repo}⌝."
    return 1
  fi

  if [[ ${newSha1} != "${currentSha1}" ]]; then
    # download the new tarball
    selfExtend_downloadTarball "${repo}"  "${reference}" "${extensionDirectory}" "${newSha1}"
    log::success "The extension ⌜${extensionName}⌝ (tarball) has been updated ⌜${currentSha1:1:5}...${newSha1:1:5}⌝."
    hasBeenUpdated=true
  else
    log::info "The extension ⌜${extensionName}⌝ (tarball) is already up-to-date."
  fi

  REPLY="${hasBeenUpdated}"
  return 0
}

# Update a git repository.
#
# Returns:
# - $?:0 if the repository was checked without errors, 1 otherwise.
# - ${REPLY}: true if the repository was updated, false otherwise.
function selfExtend_updateGitRepository() {
  local repoPath="${1}"

  local extensionName="${repoPath##*/}"
  local hasBeenUpdated=false

  log::debug "Updating the git repository ⌜${repoPath}⌝."

  selfExtend_getCurrentCommit "${repoPath}"
  local currentHead="${REPLY}"

  log::debug "Current HEAD is ${currentHead}."

  fs::readFile "${repoPath}/.git/HEAD"
  if [[ ${REPLY} =~ ^"ref: refs/heads/"(.+) ]]; then
    local branch="${BASH_REMATCH[1]:-}"
    branch="${branch%%$'\n'*}"
    log::debug "Fetching and merging branch ⌜${branch}⌝ from ⌜origin⌝ remote."
    pushd "${repoPath}" &>/dev/null || core::fail "Could not change to the directory ⌜${repoPath}⌝."
    progress::start "<spinner> Fetching reference ${branch} for extension ${extensionName}..."
    if ! git fetch -q; then
      popd &>/dev/null || :
      progress::stop
      log::warning "Failed to fetch from ⌜origin⌝ remote for the repo ⌜${path}⌝."
      return 1
    fi
    progress::stop
    if ! git merge -q --ff-only "origin/${branch}" &>/dev/null; then
      popd &>/dev/null || :
      log::warning "Failed to update the git repository ⌜${path}⌝, clean your workarea first (e.g. git stash, or git commit)."
      return 1
    fi
    popd &>/dev/null || :

    selfExtend_getCurrentCommit "${repoPath}"
    local newHead="${REPLY}"

    if [[ ${newHead} == "${currentHead}" ]]; then
      log::info "The extension ⌜${extensionName}⌝ (git) is already up-to-date."
    else
      log::success "The extension ⌜${extensionName}⌝ (git) has been updated ⌜${currentHead:1:5}..${newHead:1:5}⌝."
      hasBeenUpdated=true
    fi
  else
    log::warning "The extension ⌜${extensionName}⌝ (git) with repository ⌜${repoPath}⌝ has a detached HEAD, could not update it (please check out a branch first)."
  fi

  REPLY="${hasBeenUpdated}"
  return 0
}

function selfExtend_getCurrentCommit() {
  local repoPath="${1}"

  pushd "${repoPath}" &>/dev/null || core::fail "Could not change to the directory ⌜${repoPath}⌝."
  exe::invoke git rev-parse HEAD
  popd &>/dev/null || :
  local currentHead="${REPLY%%$'\n'*}"
  REPLY="${currentHead}"
}