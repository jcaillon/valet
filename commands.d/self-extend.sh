#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../libraries.d/core
  source "$(dirname -- "$(command -v valet)")/libraries.d/core"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../libraries.d/lib-io
source io
# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-system
source system
# shellcheck source=../libraries.d/lib-interactive
source interactive
# shellcheck source=../libraries.d/lib-curl
source curl

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
# - name: extensionUri
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
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  local action="created"
  if [[ ${extensionUri} =~ ^(https|git) ]]; then
    action="installed"
  fi

  # compute where to install the extension
  core::getUserDirectory
  local userDirectory="${RETURNED_VALUE}"
  io::createDirectoryIfNeeded "${userDirectory}"

  # case of extension creation
  if [[ ${action} == "created" ]]; then
    selfExtend_createExtension "${extensionUri}" "${userDirectory}"
    return 0
  fi

  local repositoryName
  if [[ ${extensionUri} =~ .*/([^/]+) ]]; then
    repositoryName="${BASH_REMATCH[1]:-}"
    repositoryName="${repositoryName%.git}"
  fi
  local extensionName="${name:-${repositoryName:-${extensionUri}}}"
  local extensionDirectory="${userDirectory}/${extensionName}"
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
    if system::getNotExistingCommands curl tar; then
      local IFS=$'\n'
      core::fail "The following tools are required for this command but are not installed:"$'\n'"${RETURNED_ARRAY[*]}"
    fi

    # get the sha1 of the reference, fail if not found
    selfExtend_getSha1 "${extensionUri}" "${version}"
    selfExtend_downloadTarball "${extensionUri}"  "${version}" "${extensionDirectory}" "${RETURNED_VALUE}"
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
  core::sourceFunction selfDocument
  selfDocument

  log::success "The extension ⌜${extensionName}⌝ has been installed and is ready to be used."
}

# Create a new extension for Valet.
function selfExtend_createExtension() {
  local extensionName="${1}"
  local userDirectory="${2}"

  local extensionDirectory

  if [[ ${extensionName} == "." ]]; then
    # setup an existing directory as an extension
    extensionName="${PWD##*/}"
    log::info "Setting up the current directory ⌜${extensionName}⌝ as an extension."

    if [[ ${PWD} != "${userDirectory}"* ]]; then
      core::fail "Extension directories must be created in the user directory ⌜${userDirectory}⌝, the current directory is ⌜${PWD}⌝."
    fi
    extensionDirectory="${PWD}"
  else
    # create a new extension directory
    extensionDirectory="${userDirectory}/${extensionName}"
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
      io::createDirectoryIfNeeded "${extensionDirectory}/${subdir}"
    done
  fi

  # verify that we have lib-valet generated in the user directory
  if [[ ! -f "${userDirectory}/lib-valet" ]]; then
    log::info "Rebuilding the documentation because ⌜${userDirectory}/lib-valet⌝ is missing."
    core::sourceFunction selfDocument
    selfDocument
  fi

  # on windows, creating links will prompt the user for admin permissions
  # we can group all the ps1 commands and run it once at the end
  io::windowsPowershellBatchStart

  # vscode stuff
  if command -v code &>/dev/null; then
    io::createDirectoryIfNeeded "${extensionDirectory}/.vscode"
    cp -n "${GLOBAL_VALET_HOME}/extras/.vscode/settings.json" "${extensionDirectory}/.vscode/settings.json" || log::error "Could not copy the vscode settings file."
    cp -n "${GLOBAL_VALET_HOME}/extras/.vscode/extensions.json" "${extensionDirectory}/.vscode/extensions.json" || log::error "Could not copy the vscode extensions file."

    # link the snippets
    io::createLink "${userDirectory}/valet.code-snippets" "${extensionDirectory}/.vscode/valet.code-snippets" || log::error "Could not create a symbolic link to the vscode snippets."
  fi

  # git stuff
  if command -v git &>/dev/null; then
    io::createFilePathIfNeeded "${extensionDirectory}/.gitignore"
    io::readFile "${extensionDirectory}/.gitignore"
    if [[ ${RETURNED_VALUE} != *"### Valet ###"* ]]; then
      local content=$'\n'$'\n'"### Valet ###"$'\n'"lib-valet"$'\n'"lib-valet.md"$'\n'".vscode/valet.code-snippets"
      io::writeToFile "${extensionDirectory}/.gitignore" "${content}" true
    fi
  fi

  # link lib-valet
  io::createLink "${userDirectory}/lib-valet" "${extensionDirectory}/lib-valet" || log::error "Could not create a symbolic link to the lib-valet."
  io::createLink "${userDirectory}/lib-valet.md" "${extensionDirectory}/lib-valet.md" || log::error "Could not create a symbolic link to the lib-valet.md."

  io::windowsPowershellBatchEnd

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

  io::createTempDirectory
  local tempDirectory="${RETURNED_VALUE}"

  # download the tarball
  log::info "Downloading the extension from the URL ⌜${tarballUrl}⌝ for sha1 ⌜${sha1}⌝."
  interactive::startProgress "#spinner Download in progress, please wait..."
  curl::toFile true 200,302 "${tempDirectory}/${sha1}.tar.gz" "${tarballUrl}"
  interactive::stopProgress

  # untar
  tar -xzf "${tempDirectory}/${sha1}.tar.gz" -C "${tempDirectory}" || core::fail "Could not untar the extension tarball ⌜${tempDirectory}/${sha1}.tar.gz⌝ using tar."

  # move the files to the target directory
  rm -Rf "${targetDirectory}" 1>/dev/null || core::fail "Could not remove the existing files in ⌜${targetDirectory}⌝."
  io::createDirectoryIfNeeded "${targetDirectory}"
  io::listDirectories "${tempDirectory}" false
  if (( ${#RETURNED_ARRAY[@]} != 1 )); then
    core::fail "The tarball ⌜${tempDirectory}/${sha1}.tar.gz⌝ did not contain a single directory."
  fi
  mv "${RETURNED_ARRAY[0]}"/* "${targetDirectory}" || core::fail "Could not move the files from ⌜${RETURNED_ARRAY[0]}⌝ to ⌜${targetDirectory}⌝."

  # write the sha1 to the targetDirectory so we known which commit we fetched
  io::writeToFile "${targetDirectory}/.sha1" "${sha1}"
  io::writeToFile "${targetDirectory}/.reference" "${reference}"
  io::writeToFile "${targetDirectory}/.repo" "${repositoryUrl}"
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
    RETURNED_VALUE=""
    interactive::startProgress "#spinner Fetching reference information from GitHub..."
    local url="https://api.github.com/repos/${owner}/${repo}/git/refs/heads/${reference}"
    if ! curl::toVar false '200' -H "Accept: application/vnd.github.v3+json" "${url}"; then
      url="https://api.github.com/repos/${owner}/${repo}/git/refs/tags/${reference}"
      curl::toVar false '200' -H "Accept: application/vnd.github.v3+json" "${url}" || :
    fi
    local response="${RETURNED_VALUE}"
    local error="${RETURNED_VALUE2}"
    local httpCode="${RETURNED_VALUE3}"
    interactive::stopProgress

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

  RETURNED_VALUE="${sha1}"
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
  interactive::startProgress "#spinner Cloning repo, please wait..."
  io::invoke git "${args[@]}"
  interactive::stopProgress
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
  if ! (source "${extensionDirectory}/extension.setup.sh"); then
    log::error "The extension setup script for the extension ⌜${extensionName}⌝ failed. You can manually retry the setup by running the script ⌜${extensionDirectory}/extension.setup.sh⌝."
    interactive::promptYesNo "The setup script for the extension ⌜${extensionName}⌝ failed (see above), do you want to continue anyway?" true || core::fail "The setup script for the extension ⌜${extensionName}⌝ failed."
  fi
  io::createDirectoryIfNeeded "${extensionDirectory}/.git"
  io::writeToFile "${extensionDirectory}/.git/.valet-setup-executed" "ok"
  log::success "The setup script for the extension ⌜${extensionName}⌝ has been executed."
}

# A filter so select extension folders.
# shellcheck disable=SC2317
function filterExtensionFolder() {
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
  local userDirectory="${1}"
  local skipSetup="${2:-false}"

  if [[ ! -d "${userDirectory}" ]]; then
    log::warning "The user directory ⌜${userDirectory}⌝ does not exist."
    return 0
  fi

  log::info "Attempting to update all git repositories and installed extensions in ⌜${userDirectory}⌝."
  io::listDirectories "${userDirectory}" true false filterExtensionFolder
  local path
  local allUpdateSuccess=true
  local -i count=0
  for path in "${RETURNED_ARRAY[@]}"; do
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
        updateSuccess=${RETURNED_VALUE}
      fi
    elif [[ -f "${path}/.repo" ]]; then
      log::debug "Found an installed extension ⌜${extensionName}⌝."
      if ! selfExtend_updateTarBall "${path}"; then
        allUpdateSuccess=false
      else
        updateSuccess=${RETURNED_VALUE}
      fi
    fi

    if [[ ${updateSuccess} == "true" ]]; then
      count+=1
      selfExtend_executeSetupScript "${path}" "${skipSetup}"
    fi
  done

  if [[ ${allUpdateSuccess} == "true" ]]; then
    if ((count == 0)); then
      log::info "No extensions to update in ⌜${userDirectory}⌝."
    else
      log::success "A total of ⌜${count}⌝ extensions in ⌜${userDirectory}⌝ have been updated."
    fi
  else
    log::warning "Some extensions in ⌜${userDirectory}⌝ could not be updated, ⌜${count}⌝ were updated successfully."
  fi
}

# Update a tarball extension.
#
# Returns:
# - $?: 0 if the repository was checked without errors, 1 otherwise.
# - `RETURNED_VALUE`: true if the repository was updated, false otherwise.
function selfExtend_updateTarBall() {
  local extensionDirectory="${1}"

  local extensionName="${extensionDirectory##*/}"
  local hasBeenUpdated=false

  log::info "Updating the tarball extension ⌜${extensionDirectory}⌝."

  io::readFile "${extensionDirectory}/.repo"
  local repo="${RETURNED_VALUE%%$'\n'*}"
  io::readFile "${extensionDirectory}/.reference"
  local reference="${RETURNED_VALUE%%$'\n'*}"
  io::readFile "${extensionDirectory}/.sha1"
  local currentSha1="${RETURNED_VALUE%%$'\n'*}"

  log::debug "Extension ⌜${extensionName}⌝ is from repository ⌜${repo}⌝ and reference ⌜${reference}⌝ with sha1 ⌜${currentSha1}⌝."

  if [[ -z ${repo} || -z ${reference} ]]; then
    log::warning "The extension ⌜${extensionName}⌝ (tarball) does not have a .repo or .reference file, cannot update it."
    return 1
  fi

  # get the sha1 of the reference, fail if not found
  selfExtend_getSha1 "${repo}" "${reference}"
  local newSha1="${RETURNED_VALUE}"

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

  RETURNED_VALUE="${hasBeenUpdated}"
  return 0
}

# Update a git repository.
#
# Returns:
# - $?: 0 if the repository was checked without errors, 1 otherwise.
# - `RETURNED_VALUE`: true if the repository was updated, false otherwise.
function selfExtend_updateGitRepository() {
  local repoPath="${1}"

  local extensionName="${repoPath##*/}"
  local hasBeenUpdated=false

  log::debug "Updating the git repository ⌜${repoPath}⌝."

  selfExtend_getCurrentCommit "${repoPath}"
  local currentHead="${RETURNED_VALUE}"

  log::debug "Current HEAD is ${currentHead}."

  io::readFile "${repoPath}/.git/HEAD"
  if [[ ${RETURNED_VALUE} =~ ^"ref: refs/heads/"(.+) ]]; then
    local branch="${BASH_REMATCH[1]:-}"
    branch="${branch%%$'\n'*}"
    log::debug "Fetching and merging branch ⌜${branch}⌝ from ⌜origin⌝ remote."
    pushd "${repoPath}" &>/dev/null || core::fail "Could not change to the directory ⌜${repoPath}⌝."
    interactive::startProgress "#spinner Fetching reference ${branch} for extension ${extensionName}..."
    if ! git fetch -q; then
      popd &>/dev/null || :
      interactive::stopProgress
      log::warning "Failed to fetch from ⌜origin⌝ remote for the repo ⌜${path}⌝."
      return 1
    fi
    interactive::stopProgress
    if ! git merge -q --ff-only "origin/${branch}" &>/dev/null; then
      popd &>/dev/null || :
      log::warning "Failed to update the git repository ⌜${path}⌝, clean your workarea first (e.g. git stash, or git commit)."
      return 1
    fi
    popd &>/dev/null || :

    selfExtend_getCurrentCommit "${repoPath}"
    local newHead="${RETURNED_VALUE}"

    if [[ ${newHead} == "${currentHead}" ]]; then
      log::info "The extension ⌜${extensionName}⌝ (git) is already up-to-date."
    else
      log::success "The extension ⌜${extensionName}⌝ (git) has been updated ⌜${currentHead:1:5}..${newHead:1:5}⌝."
      hasBeenUpdated=true
    fi
  else
    log::warning "The extension ⌜${extensionName}⌝ (git) with repository ⌜${repoPath}⌝ has a detached HEAD, could not update it (please check out a branch first)."
  fi

  RETURNED_VALUE="${hasBeenUpdated}"
  return 0
}

function selfExtend_getCurrentCommit() {
  local repoPath="${1}"

  pushd "${repoPath}" &>/dev/null || core::fail "Could not change to the directory ⌜${repoPath}⌝."
  io::invoke git rev-parse HEAD
  popd &>/dev/null || :
  local currentHead="${RETURNED_VALUE%%$'\n'*}"
  RETURNED_VALUE="${currentHead}"
}