#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

# shellcheck source=../libraries.d/lib-exe
source exe
# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-interactive
source interactive
# shellcheck source=../libraries.d/lib-command
source command

#===============================================================
# >>> command: extensions init
#===============================================================

: <<"COMMAND_YAML"
command: extensions init
function: extensionsInit
author: github.com/jcaillon
shortDescription: Initialize/setup the current directory as a Valet extension.

description: |-
  Initialize/setup the current directory as a Valet extension.

  This command will:

  - Ask the user if they want to register the current directory as an extension by linking it in the valet extensions directory (if it's not already the case).
  - Link lib-valet and lib-valet.md in the current directory.
  - If vscode is installed, copy the recommended settings and extensions for valet development in a .vscode directory in the current directory.

examples:
- name: extensions init
  description: |-
    Initialize the current directory as a Valet extension.
COMMAND_YAML
function extensionsInit() {
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  # compute where to init the extension
  core::getExtensionsDirectory
  local extensionsDirectory="${REPLY}"

  local \
    extensionName="${PWD##*/}" \
    extensionDirectory="${PWD}"

  # setup an existing directory as an extension
  log::info "Setting up the current directory ⌜${extensionName}⌝ as an extension."

  if system::isWindows; then
    # shellcheck source=../libraries.d/lib-windows
    source windows

    # on windows, creating links will prompt the user for admin permissions
    # we can group all the ps1 commands and run it once at the end
    windows::startPs1Batch
  fi

  if [[ ${PWD} != "${extensionsDirectory}"* ]]; then
    log::info "Extension directories must be created in the user directory ⌜${extensionsDirectory}⌝ but the current directory is ⌜${PWD}⌝."
    extensionsInit_registerExtension "${extensionName}" "${extensionDirectory}" "${extensionsDirectory}"
    if ((REPLY_CODE != 0)); then
      log::warning "The current directory will not be registered as an extension."$'\n'"If you want to register it later, you can run this command again or link it:"$'\n'"ln -s \"${extensionDirectory}\" \"${extensionsDirectory}/${extensionName}\""
    fi
  fi

  # verify that we have lib-valet generated in the user directory
  if [[ ! -f "${extensionsDirectory}/lib-valet" ]]; then
    log::info "Rebuilding the documentation because ⌜${extensionsDirectory}/lib-valet⌝ is missing."
    command::sourceFunction selfDocument
    selfDocument
  fi

  # vscode stuff
  if command -v code &>/dev/null; then
    fs::createDirectoryIfNeeded "${extensionDirectory}/.vscode"
    exe::invoke command cp -n "${GLOBAL_INSTALLATION_DIRECTORY}/extras/.vscode/settings.json" "${extensionDirectory}/.vscode/settings.json"
    exe::invoke command cp -n "${GLOBAL_INSTALLATION_DIRECTORY}/extras/.vscode/extensions.json" "${extensionDirectory}/.vscode/extensions.json"

    # link the snippets
    fs::createLink "${extensionsDirectory}/valet.code-snippets" "${extensionDirectory}/.vscode/valet.code-snippets" force=true
  fi

  # git stuff
  if command -v git &>/dev/null; then
    fs::createFileIfNeeded "${extensionDirectory}/.gitignore"
    fs::readFile "${extensionDirectory}/.gitignore"
    if [[ ${REPLY} != *"### Valet ###"* ]]; then
      # shellcheck disable=SC2034
      local content=$'\n'$'\n'"### Valet ###"$'\n'"lib-valet"$'\n'"lib-valet.md"$'\n'".vscode/valet.code-snippets"
      fs::writeToFile "${extensionDirectory}/.gitignore" content append=true
    fi
  fi

  # link lib-valet
  fs::createLink "${extensionsDirectory}/lib-valet" "${extensionDirectory}/lib-valet" force=true
  fs::createLink "${extensionsDirectory}/lib-valet.md" "${extensionDirectory}/lib-valet.md" force=true

  if system::isWindows; then
    windows::endPs1Batch
  fi

  log::success "The extension ${extensionName} is ready to be used."
}

function extensionsInit_registerExtension() {
  local \
    name="${1}" \
    directory="${2}" \
    extensionsDirectory="${3}"

  # check if the symlink already exists
  fs::getRealPath "${extensionsDirectory}/${name}"
  if [[ ${REPLY} == "${directory}" ]]; then
    log::info "The current directory is already registered as an extension."
    REPLY_CODE=0
    return 0
  fi

  if ! interactive::confirm "The current directory can be linked inside the valet extensions directory so it can be used as an extension."$'\n'"Do you want to register the current directory has an extension?" default=true; then
    REPLY_CODE=1
    return 0
  fi

  if [[ -e ${extensionsDirectory}/${name} || -L ${extensionsDirectory}/${name} ]]; then
    log::warning "The extension ⌜${name}⌝ already exists in ⌜${extensionsDirectory}⌝."
    if ! interactive::confirm "You are about to replace the existing extension, it will delete existing files."$'\n'"Do you want to overwrite the existing ⌜${name}⌝ extension?"; then
      REPLY_CODE=1
      return 0
    else
      exe::invoke command rm -rf "${extensionsDirectory}/${name}"
    fi
  fi

  log::info "Creating a symbolic link to register the current directory as an extension."
  fs::createLink "${directory}" "${extensionsDirectory}/${name}"

  REPLY_CODE=0
}
