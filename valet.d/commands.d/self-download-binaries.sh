#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../lib-system
source system
# shellcheck source=../lib-io
source io
# shellcheck source=../lib-kurl
source kurl

#===============================================================
# >>> command: self download-binaries
#===============================================================
: "---
command: self download-binaries
hideInMenu: true
function: selfDownloadBinaries
author: github.com/jcaillon
shortDescription: Download the required binaries for valet.
description: |-
  Download the required binaries for valet: fzf.

  These binaries will be stored in the bin directory of valet and used in priority over the binaries in your PATH.
options:
- name: -s, --force-os <name>
  description: |-
    By default, this command will download the binaries for your current OS.

    You can force the download for a specific OS by providing the name of the OS.

    Possible values are: linux, windows, macos.
- name: --destination <path>
  description: |-
    By default, this command will download the binaries in valet bin/ directory.

    You can force the download in a specific directory by providing the path.
- name: -f, --force
  description: |-
    By default, this command will download the binaries only if the final files do not exist in the destination directory.

    You can force the download in all case with this option.
---"
#TODO: let the user commands have a hook to download their own dependencies when this command is run
function selfDownloadBinaries() {
  core::parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  destination="${destination:-${GLOBAL_VALET_HOME}/bin}"
  # make sure the destination is an absolute path
  if [[ "${destination}" != /* ]]; then
    destination="${PWD}/${destination}"
  fi

  # for the sake of simplicity, we only deal with amd64 arch...
  if [[ "${HOSTTYPE:-x86_64}" != "x86_64" ]]; then
    core::fail "Only amd64 architecture is supported for now but yours is ⌜${HOSTTYPE:-x86_64}⌝. Please download the binaries manually and add them in your PATH."
  fi

  # get the OS
  local os="${forceOs:-}"
  if [[ -z "${forceOs:-}" ]]; then
    system::getOsName
    os="${LAST_RETURNED_VALUE}"
  fi
  log::info "Downloading the binaries for the OS: ${os}."

  mkdir -p "${destination}"

  io::createTempDirectory && pushd "${LAST_RETURNED_VALUE}" 1>/dev/null
  if [[ ! -e "${destination}/fzf" || "${force:-}" == "true" ]]; then
    downloadFzf "${os}" "0.48.1" "${destination}"
  fi
  popd 1>/dev/null

  log::success "The binaries have been downloaded and stored in the bin directory of valet ⌜${destination}⌝."

  return 0
}

function downloadFzf() {
  local os="${1}"
  local version="${2}"
  local destination="${3}"
  if [[ ${os} == "linux" ]]; then
    local fzfUrl="https://github.com/junegunn/fzf/releases/download/${version}/fzf-${version}-${os}_amd64.tar.gz"
    log::info "Downloading fzf from: ${fzfUrl}."
    kurl::toFile true 200 fzf.tar.gz "${fzfUrl}"
    io::invoke tar -xzf fzf.tar.gz
    io::invoke mv -f "fzf" "${destination}/fzf"
  else
    local fzfUrl="https://github.com/junegunn/fzf/releases/download/${version}/fzf-${version}-${os}_amd64.zip"
    log::info "Downloading fzf from: ${fzfUrl}."
    kurl::toFile true 200 fzf.zip "${fzfUrl}"
    io::invoke unzip fzf.zip
    if [[ ${os} == "darwin" ]]; then
      io::invoke mv -f "fzf" "${destination}/fzf"
    else
      io::invoke mv -f "fzf.exe" "${destination}/fzf"
    fi
  fi
}
