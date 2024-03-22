#!/usr/bin/env bash
# Title:         valet.d/commands/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet)
if [ -z "${_MAIN_INCLUDED:-}" ]; then
  # shellcheck source=../main
  source "$(dirname -- "$(command -v valet)")/valetd/main"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> dev sub menu
#===============================================================
function about_selfMenu() {
  echo "
command: self
fileToSource: ${BASH_SOURCE[0]}
shortDescription: Show the valet self-maintenance sub menu.
description: |-
  Show the valet self-maintenance sub menu.

  This is a sub command that regroups commands useful to maintain valet.
arguments:
  - name: commands...
    description: |-
      The command to execute.

      See the commands section for more information.
examples:
  - name: self ⌜build⌝
    description: |-
      Re-build the valet menu by calling the ⌜build⌝ sub command.
"
}

function selfMenu() {
  showSubMenu "$@"
}
