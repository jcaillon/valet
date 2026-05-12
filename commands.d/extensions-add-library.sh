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
# >>> command: extensions add-library
#===============================================================

: <<"COMMAND_YAML"
command: extensions add-library
function: extensionsAddLibrary
author: github.com/jcaillon
shortDescription: Add a new library to the current extension.
description: |-
  Call this function in an extension directory to add a new library to the extension.

  This will create a file from a library template in the ⌜libraries.d⌝ directory.
arguments:
- name: library-name
  description: |-
    The name of the library to create.
examples:
- name: extensions add-library my-library
  description: |-
    Create a new library named ⌜my-library⌝ in the current extension under the ⌜libraries.d⌝ directory.
COMMAND_YAML
function extensionsAddLibrary() {
  local libraryName
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  local templateFlavor="default"

  # the library name should only contains letters, digits, underscores and hyphens
  if [[ ! ${libraryName} =~ ^[-[:alnum:]_]+$ ]]; then
    core::fail "The library name should only contain letters, digits, spaces and hyphens."
    return 1
  fi

  # check if we are working for an extension
  core::getExtensionsDirectory
  if [[ ${PWD} != "${REPLY}"* && ! -d "libraries.d" ]]; then
    log::warning "The current directory is not under the valet extensions directory ⌜${REPLY}⌝."
    if ! interactive::confirm "It does not look like the current directory ⌜${PWD}⌝ is a valet extension, do you want to proceed anyway?"; then
      log::info "Aborting the creation of the library."
      log::info "You should first create an extension with ⌜valet extensions create⌝ and then cd into the created directory."
      return 0
    fi
  fi

  local newLibraryFilePath="${PWD}/libraries.d/lib-${libraryName}"
  local libraryTemplateFile="${GLOBAL_INSTALLATION_DIRECTORY}/extras/template-library-${templateFlavor}.sh"

  if [[ -f ${newLibraryFilePath} ]]; then
    log::warning "The library file ⌜${newLibraryFilePath}⌝ already exists."
    if ! interactive::confirm "Do you want to override the existing library file?"; then
      log::info "Aborting the creation of the library."
      return 0
    fi
    command rm -f "${newLibraryFilePath}"
  fi

  # create the libraries directory if it does not exist
  fs::createDirectoryIfNeeded "${PWD}/libraries.d"

  fs::readFile "${libraryTemplateFile}"
  local templateContent="${REPLY//_LIBRARY_NAME_/"${libraryName}"}"

  printf "%s" "${templateContent}" >"${newLibraryFilePath}"

  log::success "The library ⌜${libraryName}⌝ has been created with the file ⌜${newLibraryFilePath}⌝."
}
