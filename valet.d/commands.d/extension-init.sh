#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> command: extension init
#===============================================================

#<<VALET_COMMAND
# command: extension init
# function: selfInitExtension
# author: github.com/jcaillon
# shortDescription: Create a new extension under the valet user directory, or setup the current directory.
# description: |-
#   Create a new extension under the valet user directory, or setup the current directory.
#
#   In case of a new extension, the command will create a new directory with the given name under the valet user directory.
#
#
# options:
# - name: -a, --export-all
#   description: |-
#     Export all the libraries.
##VALET_COMMAND
function selfInitExtension() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

}
