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
# >>> showcase command menu
#===============================================================
function about_showcaseMenu() {
  echo "
command: showcase
fileToSource: ${BASH_SOURCE[0]}
shortDescription: Show the showcase sub menu.
description: |-
  Can be used to show the showcase sub menu in interactive mode.

  Note: interactive mode requires fzf to be installed.
arguments:
  - name: commands...
    description: |-
      The command to execute.

      See the commands section for more information.
examples:
  - name: showcase ⌜command1⌝
    description: |-
      Run the ⌜command1⌝ showcase command.
"
}

function showcaseMenu() {
  showSubMenu "$@"
}

#===============================================================
# >>> showcase commands
#===============================================================

# shellcheck disable=SC2317
function about_showcase_command1() {
  echo "
command: showcase command1
fileToSource: ${BASH_SOURCE[0]}
sudo: true
shortDescription: A showcase command that uses arguments and options.
description: |-
  An example of description.

  You can put any text here, it will be wrapped to fit the terminal width.

  You can ⌜highlight⌝ some text as well.
arguments:
  - name: firstArg
    description: |-
      First argument.
  - name: more...
    description: |-
      Will be an an array of strings.
options:
  - name: -o, --option1
    description: |-
      First option.
  - name: -o2, -2, --this-is-option2 <level>
    description: |-
      An option with a value.
examples:
  - name: showcase command1 -o -2 value1 arg1 more1 more2
    description: |-
      Call command1 with option1, option2 and some arguments.
"
}

function showcase_command1() {
  local -a more
  parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  checkParseResults "${help:-}" "${parsingErrors:-}"

  inform "First argument: ${firstArg:-}"
  inform "Option 1: ${option1:-}"
  inform "Option 2: ${thisIsOption2:-}"
  inform "More: ${more[*]}"
}

# shellcheck disable=SC2317
function about_helloWorld() {
  echo "
command: showcase hello-world
fileToSource: ${BASH_SOURCE[0]}
shortDescription: A very dumb command
description: |-
  A dumb command.
"
}

function helloWorld() {
  echo "Hello world!"
}
