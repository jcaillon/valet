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
# >>> self test for valet
#===============================================================
function about_selfTest() {
  echo "
command: self test
fileToSource: ${BASH_SOURCE[0]}
shortDescription: Test commands or test valet itself.
description: |-
  Test commands and/or valet using approval tests approach.
arguments:
  - name: testsDirectory
    description: |-
      The path to the directory containing the tests.

      See ⌜tests.d⌝ for example tests.
"
}

function selfTest() {
  echo "testing 1, 2, 3..."
}
