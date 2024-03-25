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
# >>> self test for valet
#===============================================================
function about_selfTestCore() {
  echo "
command: self test-core
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

function selfTestCore() {
  # for each test file in the test directory
  local testDirectory
  for testDirectory in "${VALET_HOME}/tests.d"/*; do
    # skip if not a directory
    [ ! -d "${testDirectory}" ] && continue
    # skip hidden directories
    [[ "${testDirectory}" == .* ]] && continue

    runTest "${testDirectory}"
  done
}


#===============================================================
# >>> self test for valet commands
#===============================================================
function about_selfTestCommands() {
  echo "
command: self test-commands
fileToSource: ${BASH_SOURCE[0]}
shortDescription: Test valet built-in and custom commands.
description: |-
  Test valet built-in and custom commands using approval tests approach.
arguments:
  - name: testsDirectory
    description: |-
      The path to the directory containing the tests.

      See ⌜examples.d/tests.d⌝ for the built-in command tests.
"
}

function selfTestCommands() {
  echo "testing 1, 2, 3..."
}
