#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

# shellcheck source=../libraries.d/lib-exe
source exe
# shellcheck source=../libraries.d/lib-bash
source bash

command::sourceFunction extensionsInit

#===============================================================
# >>> command: extensions create
#===============================================================

: <<"COMMAND_YAML"
command: extensions create
function: extensionsCreate
author: github.com/jcaillon
shortDescription: Create a new Valet extension.

description: |-
  Create a new Valet extension.

arguments:
- name: name
  description: |-
    The name of the extension to create.

examples:
- name: extensions create
  description: |-
    Create a new Valet extension.
COMMAND_YAML
function extensionsCreate() {
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  # compute where to init the extension
  core::getExtensionsDirectory
  local extensionsDirectory="${REPLY}"

  local extensionDirectory="${extensionsDirectory}/${name:-}"

  if [[ -d "${extensionDirectory}" ]]; then
    core::fail "An extension named ${name} already exists at ⌜${extensionDirectory}⌝, please choose another name."
  fi

  log::info "Creating the extension ${name} at ⌜${extensionDirectory}⌝."
  exe::invoke command mkdir -p "${extensionDirectory}/commands.d"

  bash::pushd "${extensionDirectory}"
  extensionsInit
  bash::popd

  local message="You new extension ${name} has been created.
Learn more about extensions and command here: <https://jcaillon.github.io/valet/docs/>.
You can now create a new commands or libraries for this extension:

cd '${extensionDirectory}'
valet extensions add-command
valet extensions add-library"

  log::info "${message}"
}
