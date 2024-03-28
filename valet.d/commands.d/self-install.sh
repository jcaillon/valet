#!/usr/bin/env bash
# Title:         valet.d/commands/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet)
if [ -z "${_MAIN_INCLUDED:-}" ]; then
  VALETD_DIR="${BASH_SOURCE[0]}"
  VALETD_DIR="${VALETD_DIR%/*}" # strip file name
  VALETD_DIR="${VALETD_DIR%/*}" # strip directory
  # shellcheck source=../main
  source "${VALETD_DIR}/main"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> self update valet
#===============================================================
function about_selfUpdate() {
  echo "
command: self update
fileToSource: ${BASH_SOURCE[0]}
shortDescription: Update valet using the latest release on GitHub.
description: |-
  Update valet using the latest release on GitHub.
"
}

function selfUpdate() {
  # download the latest version of valet

  # also download fzf and yq in ${VALET_HOME}/bin
  # replace call of "fzf" and "yq" by "${VALET_HOME}/bin/fzf" and "${VALET_HOME}/bin/yq" in valet
  # this way we don't loop in the PATH and it goes faster

  # tell the user about what's next todo

  # Warn the user about:
  # If you see the replacement character � in my terminal, it means you don't have a [nerd font][nerd-font] setup in your terminal.

  invoke fzf --version

  (invoke fzf --version)

  echo "ok" | invoke fzf --version

  return 0
}

