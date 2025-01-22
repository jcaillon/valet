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

# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-io
source io
# shellcheck source=../libraries.d/lib-interactive
source interactive

#===============================================================
# >>> command: self add-command
#===============================================================

##<<VALET_COMMAND
# command: self add-command
# function: selfAddCommand
# author: github.com/jcaillon
# shortDescription: Add a new command to the current extension.
# description: |-
#   Call this function in an extension directory to add a new command to the extension.
#
#   This will create a file from a command template in the ⌜commands.d⌝ directory.
# arguments:
# - name: commandName
#   description: |-
#     The name of the command to create.
# examples:
# - name: self add-command my-command
#   description: |-
#     Create a new command named ⌜my-command⌝ in the current extension under the ⌜commands.d⌝ directory.
##VALET_COMMAND
function selfAddCommand() {
  local commandName
  command::parseArguments "$@" && eval "${RETURNED_VALUE}"
  command::checkParsedResults

  local templateFlavor="default"

  # the command name should only contains letters, digits, spaces and hyphens
  if [[ ! ${commandName} =~ ^[-[:alnum:]" "]+$ ]]; then
    core::fail "The command name should only contain letters, digits, spaces and hyphens."
    return 1
  fi

  # check if we are working for an extension
  core::getUserDirectory
  if [[ ${PWD} != "${RETURNED_VALUE}"* && ! -d "commands.d" ]]; then
    log::warning "The current directory is not under the valet user directory ⌜${RETURNED_VALUE}⌝."
    if ! interactive::promptYesNo "It does not look like the current directory ⌜${PWD}⌝ is a valet extension, do you want to proceed anyway?" true; then
      log::info "Aborting the creation of the command."
      log::info "You should first create an extension with ⌜valet self extend⌝ and then cd into the created directory."
      return 0
    fi
  fi

  local fileName="${commandName// /-}"
  string::kebabCaseToCamelCase "${fileName}"
  local functionName="${RETURNED_VALUE}"
  local newCommandFilePath="${PWD}/commands.d/${fileName}.sh"
  local commandTemplateFile="${GLOBAL_INSTALLATION_DIRECTORY}/extras/template-command-${templateFlavor}.sh"

  if [[ -f ${newCommandFilePath} ]]; then
    log::warning "The command file ⌜${newCommandFilePath}⌝ already exists."
    if ! interactive::promptYesNo "Do you want to override the existing command file?" true; then
      log::info "Aborting the creation of the command."
      return 0
    fi
    rm -f "${newCommandFilePath}"
  fi

  # create the commands directory if it does not exist
  io::createDirectoryIfNeeded "${PWD}/commands.d"

  io::readFile "${commandTemplateFile}"
  local templateContent="${RETURNED_VALUE//_COMMAND_NAME_/"${commandName}"}"
  templateContent="${templateContent//_FUNCTION_NAME_/"${functionName}"}"

  printf "%s" "${templateContent}" >"${newCommandFilePath}"

  log::success "The command ⌜${commandName}⌝ has been created with the file ⌜${newCommandFilePath}⌝."
}
