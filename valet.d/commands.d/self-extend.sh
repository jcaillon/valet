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
# examples:
# - name: self extend https://github.com/jcaillon/valet-devops-toolbox.git --version latest
#   description: |-
#     Download the latest version of the valet-devops-toolbox application and install it for Valet.
##VALET_COMMAND
function selfExtend() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  core::fail "The command ⌜self extend⌝ is not implemented yet."
}

# Attempts to update each git repository found in the user directory.
function selfExtend::updateExtensions() {
  local userDirectory="${1}"

  if [[ ! -d "${userDirectory}" ]]; then
    return 0
  fi

  log::info "Attempting to update the git repositories in ⌜${userDirectory}⌝."

  # shellcheck disable=SC2317
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
      if ! command -v git &>/dev/null; then
        log::warning "The command ⌜git⌝ is not installed or not found in your PATH, skipping git update for repo ⌜${path}⌝."
        continue
      fi
      if ! selfExtend::updateGitRepository "${path}"; then
        allUpdateSuccess=false
        log::warning "Failed to update the git repository ⌜${path}⌝, clean your workarea first (e.g. git stash, or git commit)."
      else
        log::success "The git repository ⌜${path}⌝ has been updated."
        count+=1
      fi
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

  io::readFile "${repoPath}/.git/HEAD"
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