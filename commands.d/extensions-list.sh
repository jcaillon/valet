#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=./extensions-utils
source ./extensions-utils

#===============================================================
# >>> command: extensions init
#===============================================================

: <<"COMMAND_YAML"
command: extensions list
function: extensionsList
author: github.com/jcaillon
shortDescription: List all Valet extensions.

description: |-
  List all Valet extensions, their versions and if the setup script has been executed.

examples:
- name: extensions list
  description: |-
    List all Valet extensions.
COMMAND_YAML
function extensionsList() {
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  core::getExtensionsDirectory
  local extensionsDirectory="${REPLY}"

  fs::listDirectories "${extensionsDirectory}"

  if ((${#REPLY_ARRAY[@]} == 0)); then
    log::info "You do not have any extensions created or installed yet."
    return 0
  fi

  local \
    titleName="Extension name" \
    titleVersion="Version" \
    titleSetupExecuted="Setup executed"

  local -a extensions=() versions=() setupStatus=()
  local -i maxLengthExtension=${#titleName} maxLengthVersion=${#titleVersion} maxLengthSetupStatus=${#titleSetupExecuted}
  local extensionDirectory extension version
  for extensionDirectory in "${REPLY_ARRAY[@]}"; do
    extension="${extensionDirectory##*/}"
    extensions+=("${extension}")
    if ((${#extension} > maxLengthExtension)); then
      maxLengthExtension=${#extension}
    fi

    extensions::getVersion "${extensionDirectory}"
    version="${REPLY:-"-"}"
    versions+=("${version}")
    if ((${#version} > maxLengthVersion)); then
      maxLengthVersion=${#version}
    fi

    if [[ -f ${extensionDirectory}/extension.setup.sh ]]; then
      if extensions::isSetupExecuted "${extensionDirectory}"; then
        setupStatus+=("${STYLE_COLOR_SUCCESS}Yes${STYLE_RESET}")
      else
        setupStatus+=("${STYLE_COLOR_ERROR}No${STYLE_RESET}")
      fi
    else
      setupStatus+=("${STYLE_COLOR_FADED}-${STYLE_RESET}")
    fi
  done

  # display the table
  local -i index
  local output line
  printf -v line "${STYLE_COLOR_ACCENT}%-${maxLengthExtension}s${STYLE_RESET} ${SYMBOL_VR_LINE} ${STYLE_COLOR_PRIMARY}%-${maxLengthVersion}s${STYLE_RESET} ${SYMBOL_VR_LINE} ${STYLE_COLOR_PRIMARY}%s${STYLE_RESET}\n" "${titleName}" "${titleVersion}" "${titleSetupExecuted}"
  output+="${line}"
  printf -v line "%-${maxLengthExtension}s ${SYMBOL_CROSS} %-${maxLengthVersion}s ${SYMBOL_CROSS} %-${maxLengthSetupStatus}s\n" " " " " " "
  output+="${line// /"${SYMBOL_HR_LINE}"}"
  for index in "${!extensions[@]}"; do
    printf -v line "%-${maxLengthExtension}s ${SYMBOL_VR_LINE} %-${maxLengthVersion}s ${SYMBOL_VR_LINE} %s\n" "${extensions[index]}" "${versions[index]}" "${setupStatus[index]}"
    output+="${line}"
  done

  log::info "Registered extensions:"
  log::printString $'\n'"${output}"
}
