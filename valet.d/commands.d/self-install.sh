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
shortDescription: Test valet core features.
description: |-
  Test valet core features using approval tests approach.
arguments:
  - name: testsDirectory
    description: |-
      The path to the directory containing the tests.

      See ⌜tests.d⌝ for the internal tests.
"
}

function selfUpdate() {
  # download the latest version of valet

  # also download fzf and yq in ${VALET_HOME}/bin
  # replace call of "fzf" and "yq" by "${VALET_HOME}/bin/fzf" and "${VALET_HOME}/bin/yq" in valet
  # this way we don't loop in the PATH and it goes faster

  return 0
}

