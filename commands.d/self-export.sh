#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ ! -v GLOBAL_CORE_INCLUDED ]]; then
  # shellcheck source=../libraries.d/core
  source "$(valet --source)"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> command: self export
#===============================================================

##<<VALET_COMMAND
# command: self export
# function: selfExport
# hideInMenu: true
# author: github.com/jcaillon
# shortDescription: Returns a string that can be evaluated to have Valet functions in bash.
# description: |-
#   If you want to use Valet functions directly in bash, you can use this command like this:
#
#   ```bash
#   eval "$(valet self export)"
#   ```
#
#   This will source valet to be able to use its functions as if you were in a command script.
#
#   You can optionally export all the functions if needed.
# options:
# - name: -a, --source-all-functions
#   description: |-
#     Will immediately source all the libraries functions.
# - name: -E, --no-exit
#   description: |-
#     Override the ⌜core::fail⌝  function to not exit the script.
# - name: -p, --prompt-mode
#   description: |-
#     Source valet functions with modifications to be used in a shell prompt.
# examples:
# - name: !eval "$(valet self export)"
#   description: |-
#     Source valet functions in your bash script or bash prompt.
#     You can then can then use valet function as if you were in a command script.
##VALET_COMMAND
function selfExport() {
  command::parseArguments "$@" && eval "${RETURNED_VALUE}"
  command::checkParsedResults

  local output=""

  if [[ ${promptMode:-} == "true" ]]; then
    noExit=true
    # can be used to check if the script is running in a prompt or not
    # must be set before calling the core lib
    output+="GLOBAL_EXPORTED_FOR_PROMPT=true;"$'\n'
  fi

  # source valet core library
  output+="source \"${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/core\""$'\n'

  if [[ ${sourceAllFunctions:-} == "true" ]]; then
    # source all libraries
    local library
    for library in "${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/lib-"*; do
      local libraryName="${library##*lib-}"
      libraryName="${libraryName%lib-}"
      log::trace "Exporting library: ⌜${libraryName}⌝."
      output+="source ${libraryName}"$'\n'
    done
  fi

  if [[ ${noExit:-} == "true" ]]; then
    output+="function core::fail() { log::error \"\$@\"; }"$'\n'
    output+="set +o errexit"$'\n'
  fi

  if [[ ${promptMode} == "true" ]]; then
    # disable all traps
    output+="trap SIGINT; trap SIGQUIT; trap SIGHUP; trap SIGTERM; trap ERR; trap EXIT"$'\n'
    # TODO: as we disable the exit trap, we do not clean up the files.
    # We can clean them here during the export. We list all vt-* and we list the running PIDs
    # we can clean everything that is not in the list of running PIDs
  fi

  echo "${output}"
}
