#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../lib-io
source io
# shellcheck source=../lib-string
source string
# shellcheck source=../lib-system
source system
# shellcheck source=../lib-interactive
source interactive
# shellcheck source=../lib-curl
source curl

#===============================================================
# >>> command: self extend
#===============================================================

##<<VALET_COMMAND
# command: self extend
# function: selfExtend
# author: github.com/jcaillon
# shortDescription: Extends Valet by downloading a new application or library in the user directory.
# description: |-
#   Extends Valet by downloading a new application or library in the user directory.
#
#   - Applications usually add new commands to Valet.
#   - Libraries usually add new callable functions to Valet.
#
#   This command will download the given repository and install it in the Valet user directory.
#   If a `valet.setup.sh` script is present in the repository root directory, it will be executed.
#
#   For GitHub and GitLab repositories, this command will:
#
#   1. If git is installed, clone the repository for the given reference (version option).
#   2. Otherwise, download source tarball for the given reference and extract it.
#
#   Once an extension is installed, you can use the `valet self update` command to update it.
# arguments:
# - name: repositoryUrl
#   description: |-
#     The URL of the repository to download and install in Valet.
#
#     Usually a GitHub or GitLab repository URL such as `https://github.com/jcaillon/valet-devops-toolbox.git`.
#
#     If the repository is private, you can pass the URL with the username and password like this:
#     `https://username:password@my.gitlab.private/group/project.git`.
# options:
# - name: -v, --version <version>
#   description: |-
#     The version of the repository to download.
#     Usually a tag or a branch name.
#   default: latest
# - name: --skip-setup
#   description: |-
#     Skip the execution of the `valet.setup.sh` script even if it exists.
# examples:
# - name: self extend https://github.com/jcaillon/valet-devops-toolbox.git --version latest
#   description: |-
#     Download the latest version of the valet-devops-toolbox application and install it for Valet.
##VALET_COMMAND
function selfExtend() {
  local repositoryUrl version skipSetup
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  if system::getNotExistingCommands curl tar; then
    local IFS=$'\n'
    core::fail "The following tools are required for this command but are not installed:"$'\n'"${RETURNED_ARRAY[*]}"
  fi

  # compute where to install the extension
  core::getUserDirectory
  local userDirectory="${RETURNED_VALUE}"
  local repositoryName
  if [[ ${repositoryUrl} =~ .*/([^/]+)(.git)? ]]; then
    repositoryName="${BASH_REMATCH[1]:-}"
  fi
  local extensionDirectory="${userDirectory}/${repositoryName}"
  log::info "The extension will be installed under ⌜${extensionDirectory}⌝."

  # if the extension already exists, ask the user for a confirmation
  if [[ -d "${extensionDirectory}" ]]; then
    log::warning "The extension ⌜${repositoryName}⌝ already exists in ⌜${extensionDirectory}⌝."
    if ! interactive::promptYesNo "Do you want to overwrite the existing ⌜${repositoryName}⌝ extension?" true; then
      log::info "The extension ⌜${repositoryName}⌝ will not be installed."
      return 0
    fi
    rm -Rf "${extensionDirectory}"
  fi

  # if Git is installed, we simply clone the repository for the correct reference
  if command -v git2 &>/dev/null; then
    selfExtend_gitClone "${repositoryUrl}" "${version}" "${extensionDirectory}"

  else
    # if Git is not installed, we download the source tarball and extract it
    # We will only be able to do that for a few git servers however
    selfExtend_downloadTarball "${repositoryUrl}"  "${version}" "${extensionDirectory}"
  fi

  # execute the setup script of the extension, if any
  if [[ ${skipSetup} != "true" ]]; then
    if [[ -f "${extensionDirectory}/valet.setup.sh" ]]; then
      log::info "Executing the setup script for the extension ⌜${repositoryName}⌝."
      # shellcheck disable=SC1091
      source "${extensionDirectory}/valet.setup.sh"
      io::writeToFile "${extensionDirectory}/.setup-executed" "ok"
    else
      log::info "No setup script found for the extension ⌜${repositoryName}⌝."
    fi
  fi

  log::success "The extension ⌜${repositoryName}⌝ has been installed in ⌜${extensionDirectory}⌝."

  # rebuild the command cache
  core::deleteUserCommands
  core::reloadUserCommands

  # rebuild the documentation
  core::sourceFunction selfDocument
  selfDocument
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

  log::info "Attempting to download the source tarball for ⌜${repositoryUrl}⌝ in ⌜${targetDirectory}⌝."

  # get the sha1 of the reference, fail if not found
  selfExtend_getSha1 "${repositoryUrl}" "${reference}"
  local sha1="${RETURNED_VALUE}"

  local tarballUrlPattern

  # get tarball for github api
  if [[ ${repositoryUrl} =~ "https://github.com/"([^/]+)"/"([^/]+)(.git)? ]]; then
    tarballUrlPattern="https://github.com/${BASH_REMATCH[1]:-}/${BASH_REMATCH[2]:-}/archive/%SHA1%.tar.gz"
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
  mkdir -p "${targetDirectory}" || core::fail "Could not create the directory ⌜${targetDirectory}⌝."
  mv "${tempDirectory}/${repo}-${sha1}"/* "${targetDirectory}" || core::fail "Could not move the files from ⌜${tempDirectory}/${repo}-${sha1}⌝ to ⌜${targetDirectory}⌝."

  # write the sha1 to the targetDirectory so we known which commit we fetched
  io::writeToFile "${targetDirectory}/.sha1" "${sha1}"
  io::writeToFile "${targetDirectory}/.tarball-url" "${tarballUrlPattern}"
}

# Get the sha1 from a git server API.
#
# Compatible git servers:
#
# - GitHub: It will use the GitHub API to get the sha1 of the reference.
function selfExtend_getSha1() {
  local repositoryUrl="${1}"
  local reference="${2}"

  local sha1

  # get sha1 from github api
  if [[ ${repositoryUrl} =~ "https://github.com/"([^/]+)"/"([^/]+)(.git)? ]]; then
    local owner="${BASH_REMATCH[1]:-}"
    local repo="${BASH_REMATCH[2]:-}"

    # get the sha1
    RETURNED_VALUE=""
    interactive::startProgress "#spinner Fetching reference information from GitHub..."
    local url="https://api.github.com/repos/${owner}/${repo}/git/refs/heads/${reference}"
    if ! curl::toVar false '200' -H "Accept: application/vnd.github.v3+json" "${url}"; then
      url="https://api.github.com/repos/${owner}/${repo}/git/refs/tags/${reference}"
      curl::toVar false '200' -H "Accept: application/vnd.github.v3+json" "${url}" || :
    fi
    interactive::stopProgress

    if [[ ${RETURNED_VALUE3} == 404 ]]; then
      core::fail "Could not find a branch or tag for the reference ⌜${reference}⌝ in repository ⌜${repositoryUrl}⌝."
    elif [[ ${RETURNED_VALUE3} != 200 ]]; then
      log::warning "Unexpected error returned from the GitHub API for the URL ⌜${url}⌝: ${RETURNED_VALUE}${RETURNED_VALUE2}"
    fi
    if [[ ${RETURNED_VALUE} =~ "\"sha\":"([ ]?)"\""([^\"]+)"\"" ]]; then
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

  log::info "Cloning the git repository ⌜${url}⌝ with reference ⌜${version}⌝ in ⌜${targetDirectory}⌝."
  interactive::startProgress "#spinner Cloning repo, please wait..."
  io::invoke git "${args[@]}"
  interactive::stopProgress
}

# Attempts to update each git repository found in the user directory.
function selfExtend::updateExtensions() {
  local userDirectory="${1}"

  if [[ ! -d "${userDirectory}" ]]; then
    return 0
  fi

  log::info "Attempting to update all git repositories and installed extensions in ⌜${userDirectory}⌝."

  # shellcheck disable=SC2317
  function filterGitRepositories() {
    if [[ -d "${1}/.git" ]]; then
      return 1
    fi
    if [[ -f "${1}/.tarball-url" ]]; then
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
      if ! command -v git &>/dev/null; then
        log::warning "The command ⌜git⌝ is not installed or not found in your PATH, skipping git update for repo ⌜${path}⌝."
        continue
      fi
      if ! selfExtend::updateGitRepository "${path}"; then
        allUpdateSuccess=false

      else
        log::success "The git repository ⌜${path}⌝ has been updated."
        count+=1
      fi
    elif [[ -f "${path}/.tarball-url" ]]; then
      log::debug "Found an installed extension ⌜${path}⌝."

    fi
  done

  if [[ ${allUpdateSuccess} == "true" ]]; then
    if ((count == 0)); then
      log::info "No git repositories found in ⌜${userDirectory}⌝."
    else
      log::success "A total of ${count} git repositories in ⌜${userDirectory}⌝ have been updated."
    fi
  else
    log::warning "Some git repositories in ⌜${userDirectory}⌝ could not be updated, ${count} updated successfully."
  fi

}

function selfExtend::updateGitRepository() {
  local repoPath="${1}"

  if [[ ! -f "${repoPath}/.git/HEAD" ]]; then
    core::fail "The directory ⌜${repoPath}⌝ is not a git repository."
  fi

  if ! command -v git &>/dev/null; then
    core::fail "The command ⌜git⌝ is not installed or not found in your PATH."
  fi

  log::debug "Updating the git repository ⌜${repoPath}⌝."

  io::invoke git rev-parse HEAD
  local currentHead="${RETURNED_VALUE%%$'\n'*}"

  log::debug "Current HEAD is ${currentHead}."

  io::readFile "${repoPath}/.git/HEAD"
  if [[ ${RETURNED_VALUE} =~ ^"ref: refs/heads/"(.+) ]]; then
    local branch="${BASH_REMATCH[1]:-}"
    branch="${branch%%$'\n'*}"
    log::info "Fetching and merging branch ⌜${branch}⌝ from ⌜origin⌝ remote."
    pushd "${repoPath}" &>/dev/null || core::fail "Could not change to the directory ⌜${repoPath}⌝."
    if ! git fetch -q; then
      popd &>/dev/null || :
      log::warning "Failed to fetch from ⌜origin⌝ remote for the repo ⌜${path}⌝."
      return 1
    fi
    if ! git merge -q --ff-only "origin/${branch}" &>/dev/null; then
      popd &>/dev/null || :
      log::warning "Failed to update the git repository ⌜${path}⌝, clean your workarea first (e.g. git stash, or git commit)."
      return 1
    fi
    popd &>/dev/null || :
  elif [[ ${RETURNED_VALUE} =~ ^"ref: refs/tags/"(.+) ]]; then
    log::warning "The git repository ⌜${repoPath}⌝ has a checked out tag, could not update (please check out a branch instead)."
  else
    log::warning "The git repository ⌜${repoPath}⌝ has a detached HEAD, could not update it (please check out a branch first)."
  fi


}