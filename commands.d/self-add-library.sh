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
# >>> command: self add-library
#===============================================================

##<<<VALET_COMMAND
# command: self add-library
# function: selfAddLibrary
# author: github.com/jcaillon
# shortDescription: Add a new library to the current extension.
# description: |-
#   Call this function in an extension directory to add a new library to the extension.
#
#   This will create a file from a library template in the ⌜libraries.d⌝ directory.
# arguments:
# - name: library-name
#   description: |-
#     The name of the library to create.
# examples:
# - name: self add-library my-library
#   description: |-
#     Create a new library named ⌜my-library⌝ in the current extension under the ⌜libraries.d⌝ directory.
##VALET_COMMAND
function selfAddLibrary() {
  local libraryName
  command::parseArguments "$@"; eval "${REPLY}"
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
    log::warning "The current directory is not under the valet user directory ⌜${REPLY}⌝."
    if ! interactive::promptYesNo "It does not look like the current directory ⌜${PWD}⌝ is a valet extension, do you want to proceed anyway?"; then
      log::info "Aborting the creation of the library."
      log::info "You should first create an extension with ⌜valet self extend⌝ and then cd into the created directory."
      return 0
    fi
  fi

  local newCommandFilePath="${PWD}/libraries.d/lib-${libraryName}"
  local commandTemplateFile="${GLOBAL_INSTALLATION_DIRECTORY}/extras/template-library-${templateFlavor}.sh"

  if [[ -f ${newCommandFilePath} ]]; then
    log::warning "The library file ⌜${newCommandFilePath}⌝ already exists."
    if ! interactive::promptYesNo "Do you want to override the existing library file?"; then
      log::info "Aborting the creation of the library."
      return 0
    fi
    rm -f "${newCommandFilePath}"
  fi

  # create the commands directory if it does not exist
  fs::createDirectoryIfNeeded "${PWD}/libraries.d"

  fs::readFile "${commandTemplateFile}"
  local templateContent="${REPLY//_LIBRARY_NAME_/"${libraryName}"}"

  printf "%s" "${templateContent}" >"${newCommandFilePath}"

  log::success "The library ⌜${libraryName}⌝ has been created with the file ⌜${newCommandFilePath}⌝."
}
