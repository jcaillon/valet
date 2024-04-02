#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet)
if [ -z "${_MAIN_INCLUDED:-}" ]; then
  VALETD_DIR="${BASH_SOURCE[0]}"
  VALETD_DIR="${VALETD_DIR%/*}" # strip file name
  VALETD_DIR="${VALETD_DIR%/*}" # strip directory
  # shellcheck source=../main
  source "${VALETD_DIR}/main"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=utils
source "${VALET_HOME}/valet.d/commands.d/utils"

#===============================================================
# >>> command: self download-binaries
#===============================================================
function about_selfDownloadBinaries() {
  echo "
command: self download-binaries
fileToSource: ${BASH_SOURCE[0]}
shortDescription: Download the required binaries for valet.
description: |-
  Download the required binaries for valet: fzf, curl, yq.

  These binaries will be stored in the bin directory of valet and used in priority over the binaries in your PATH.
options:
  - name: -os, --force-os <name>
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
"
}

#TODO: let the user commands have a hook to download their own dependencies when this command is run

function selfDownloadBinaries() {
  parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  checkParseResults "${help:-}" "${parsingErrors:-}"

  destination="${destination:-${VALET_HOME}/bin}"
  # make sure the destination is an absolute path
  if [[ "${destination}" != /* ]]; then
    destination="${PWD}/${destination}"
  fi

  # for the sake of simplicity, we only deal with amd64 arch...
  if [[ "${HOSTTYPE:-x86_64}" != "x86_64" ]]; then
    fail "Only amd64 architecture is supported for now but yours is ⌜${HOSTTYPE:-x86_64}⌝. Please download the binaries manually and add them in your PATH."
  fi

  # get the OS
  local os="${forceOs:-}"
  if [[ -z "${forceOs:-}" ]]; then
    getOsName
    os="${LAST_RETURNED_VALUE}"
  fi
  inform "Downloading the binaries for the OS: ${os}."

  mkdir -p "${destination}"

  createTempDirectory && pushd "${LAST_RETURNED_VALUE}" 1>/dev/null
  [[ ! -e "${destination}/fzf" || "${force:-}" == "true" ]] && downloadFzf "${os}" "0.48.1" "${destination}"
  [[ ! -e "${destination}/curl" || "${force:-}" == "true" ]] && downloadCurl "${os}" "8.7.1" "${destination}"
  [[ ! -e "${destination}/yq" || "${force:-}" == "true" ]] && downloadYq "${os}" "4.43.1" "${destination}"
  popd 1>/dev/null

  succeed "The binaries have been downloaded and stored in the bin directory of valet ⌜${destination}⌝."

  return 0
}

function downloadFzf() {
  local os="${1}"
  local version="${2}"
  local destination="${3}"
  if [[ "${os}" == "linux" ]]; then
    local fzfUrl="https://github.com/junegunn/fzf/releases/download/${version}/fzf-${version}-${os}_amd64.tar.gz"
    inform "Downloading fzf from: ${fzfUrl}."
    kurlFile true 200 fzf.tar.gz "${fzfUrl}"
    invoke tar -xzf fzf.tar.gz
    invoke mv -f "fzf" "${destination}/fzf"
  else
    local fzfUrl="https://github.com/junegunn/fzf/releases/download/${version}/fzf-${version}-${os}_amd64.zip"
    inform "Downloading fzf from: ${fzfUrl}."
    kurlFile true 200 fzf.zip "${fzfUrl}"
    invoke unzip fzf.zip
    if [[ "${os}" == "darwin" ]]; then
      invoke mv -f "fzf" "${destination}/fzf"
    else
      invoke mv -f "fzf.exe" "${destination}/fzf"
    fi
  fi
}

function downloadCurl() {
  local os="${1}"
  local version="${2}"
  local destination="${3}"
  if [[ "${os}" != "windows" ]]; then
    local curlUrl="https://github.com/moparisthebest/static-curl/releases/download/v${version}/curl-amd64"
    inform "Downloading curl from: ${curlUrl}."
    kurlFile true 200 curl "${curlUrl}"
    invoke mv -f "curl" "${destination}/curl"
  else
    local curlUrl="https://curl.se/windows/latest.cgi?p=win64-mingw.zip"
    inform "Downloading curl from: ${curlUrl}."
    kurlFile true 200 curl.zip "${curlUrl}"
    invoke unzip curl.zip
    invoke mv -f -- */bin/* "${destination}"
    invoke mv -f "${destination}/curl.exe" "${destination}/curl"
  fi
}

function downloadYq() {
  local os="${1}"
  local version="${2}"
  local destination="${3}"
  if [[ "${os}" != "windows" ]]; then
    local yqUrl="https://github.com/mikefarah/yq/releases/download/v${version}/yq_${os}_amd64"
    inform "Downloading yq from: ${yqUrl}."
    kurlFile true 200 yq "${yqUrl}"
    invoke mv -f "yq" "${destination}/yq"
  else
    local yqUrl="https://github.com/mikefarah/yq/releases/download/v${version}/yq_${os}_amd64.exe"
    inform "Downloading yq from: ${yqUrl}."
    kurlFile true 200 yq.exe "${yqUrl}"
    invoke mv -f "yq.exe" "${destination}/yq"
  fi
}