#!/usr/bin/env bash
# Title:         valet.d/commands/*
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
"
}

function selfDownloadBinaries() {
  parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  checkParseResults "${help:-}" "${parsingErrors:-}"

  # for the sake of simpplicity, we only deal with amd64 arch...
  local arch
  invoke3var false 0 uname -m && arch="${LAST_RETURNED_VALUE%$'\n'*}" || arch="x86_64"
  debug "Your CPU architecture is: ${arch}."
  if [[ "${arch}" != "x86_64" ]]; then
    fail "Only amd64 architecture is supported for now. Please download the binaries manually and add them in your PATH."
  fi

  # get the OS
  local os="${forceOs:-}"
  if [[ -z "${forceOs:-}" ]]; then
    getOsName
    os="${LAST_RETURNED_VALUE}"
  fi
  inform "Downloading the binaries for the OS: ${os}."

  mkdir -p "${VALET_HOME}/bin"

  createTempDirectory && pushd "${LAST_RETURNED_VALUE}" 1>/dev/null
  downloadFzf "${os}" "0.48.1"
  downloadCurl "${os}" "8.7.1"
  downloadYq "${os}" "4.43.1"
  popd 1>/dev/null

  succeed "The binaries have been downloaded and stored in the bin directory of valet ⌜${VALET_HOME}/bin⌝."

  return 0
}

function downloadFzf() {
  if [[ "${1}" != "windows" ]]; then
    local fzfUrl="https://github.com/junegunn/fzf/releases/download/${2}/fzf-${2}-${1}_amd64.tar.gz"
    inform "Downloading fzf from: ${fzfUrl}."
    kurlFile true 200 fzf.tar.gz "${fzfUrl}"
    invoke tar -xzf fzf.tar.gz
    mv -f "fzf" "${VALET_HOME}/bin/fzf"
  else
    local fzfUrl="https://github.com/junegunn/fzf/releases/download/${2}/fzf-${2}-${1}_amd64.zip"
    inform "Downloading fzf from: ${fzfUrl}."
    kurlFile true 200 fzf.zip "${fzfUrl}"
    invoke unzip fzf.zip
    mv -f "fzf.exe" "${VALET_HOME}/bin/fzf"
  fi
}

function downloadCurl() {
  if [[ "${1}" != "windows" ]]; then
    local curlUrl="https://github.com/moparisthebest/static-curl/releases/download/v${2}/curl-amd64"
    inform "Downloading curl from: ${curlUrl}."
    kurlFile true 200 curl "${curlUrl}"
    mv -f "curl" "${VALET_HOME}/bin/curl"
  else
    local curlUrl="https://curl.se/windows/latest.cgi?p=win64-mingw.zip"
    kurlFile true 200 curl.zip "${curlUrl}"
    invoke unzip curl.zip
    mv -f -- */bin/* "${VALET_HOME}/bin"
    mv -f "${VALET_HOME}/bin/curl.exe" "${VALET_HOME}/bin/curl"
  fi
}

function downloadYq() {
  if [[ "${1}" != "windows" ]]; then
    local yqUrl="https://github.com/mikefarah/yq/releases/download/v${2}/yq_${1}_amd64"
    inform "Downloading yq from: ${yqUrl}."
    kurlFile true 200 yq "${yqUrl}"
    mv -f "yq" "${VALET_HOME}/bin/yq"
  else
    local yqUrl="https://github.com/mikefarah/yq/releases/download/v${2}/yq_${1}_amd64.exe"
    inform "Downloading yq from: ${yqUrl}."
    kurlFile true 200 yq.exe "${yqUrl}"
    mv -f "yq.exe" "${VALET_HOME}/bin/yq"
  fi
}