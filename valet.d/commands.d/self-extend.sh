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

source lib-self-update
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

}