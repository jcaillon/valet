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
#     Override the ⌜core::fail⌝ and ⌜core::failWithCode⌝ functions to not exit the script.
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

  # source valet core library, disable some traps
  output+="source \"${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/core\""$'\n'
  output+="trap SIGINT; trap SIGQUIT; trap SIGHUP; trap SIGTERM;"$'\n'

  if [[ ${sourceAllFunctions:-} == "true" ]]; then
    # source all libraries
    local library
    for library in "${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/lib-"*; do
      local libraryName="${library##*lib-}"
      libraryName="${libraryName%lib-}"
      log::debug "Exporting library: ⌜${libraryName}⌝."
      output+="source ${libraryName}"$'\n'
    done
  fi

  if [[ ${noExit:-} == "true" ]]; then
    output+="function core::fail() { log::error \"\$@\"; }"$'\n'
    output+="function core::failWithCode() { local exitCode=\"\${1}\"; shift; log::error \"\$@\"; log::error \"Exit code: \$exitCode\"; }"$'\n'
    output+="set +o errexit"
  fi

  echo "${output}"
}
