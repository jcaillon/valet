#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-interactive
source interactive

#===============================================================
# >>> command: self add-command
#===============================================================

: <<"COMMAND_YAML"
command: self add-command
function: selfAddCommand
author: github.com/jcaillon
shortDescription: Add a new command to the current extension.
description: |-
  Call this function in an extension directory to add a new command to the extension.

  This will create a file from a command template in the ⌜commands.d⌝ directory.
arguments:
- name: command-name
  description: |-
    The name of the command to create.
examples:
- name: self add-command my-command
  description: |-
    Create a new command named ⌜my-command⌝ in the current extension under the ⌜commands.d⌝ directory.
COMMAND_YAML
function selfAddCommand() {
  local commandName
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults

  local templateFlavor="default"

  # the command name should only contains letters, digits, spaces and hyphens
  if [[ ! ${commandName} =~ ^[-[:alnum:]" "]+$ ]]; then
    core::fail "The command name should only contain letters, digits, spaces and hyphens."
    return 1
  fi

  # check if we are working for an extension
  core::getExtensionsDirectory
  if [[ ${PWD} != "${REPLY}"* && ! -d "commands.d" ]]; then
    log::warning "The current directory is not under the valet user directory ⌜${REPLY}⌝."
    if ! interactive::confirm "It does not look like the current directory ⌜${PWD}⌝ is a valet extension, do you want to proceed anyway?"; then
      log::info "Aborting the creation of the command."
      log::info "You should first create an extension with ⌜valet self extend⌝ and then cd into the created directory."
      return 0
    fi
  fi

  local fileName="${commandName// /-}"
  string::getCamelCase fileName
  local functionName="${REPLY}"
  local newCommandFilePath="${PWD}/commands.d/${fileName}.sh"
  local commandTemplateFile="${GLOBAL_INSTALLATION_DIRECTORY}/extras/template-command-${templateFlavor}.sh"

  if [[ -f ${newCommandFilePath} ]]; then
    log::warning "The command file ⌜${newCommandFilePath}⌝ already exists."
    if ! interactive::confirm "Do you want to override the existing command file?"; then
      log::info "Aborting the creation of the command."
      return 0
    fi
    rm -f "${newCommandFilePath}"
  fi

  # create the commands directory if it does not exist
  fs::createDirectoryIfNeeded "${PWD}/commands.d"

  fs::readFile "${commandTemplateFile}"
  local templateContent="${REPLY//_COMMAND_NAME_/"${commandName}"}"
  templateContent="${templateContent//_FUNCTION_NAME_/"${functionName}"}"

  printf "%s" "${templateContent}" >"${newCommandFilePath}"

  log::success "The command ⌜${commandName}⌝ has been created with the file ⌜${newCommandFilePath}⌝."
}
