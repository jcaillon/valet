#!/usr/bin/env bash
# Import the core script (should always be skipped if the command is run from valet).
if [ -z "${_CORE_INCLUDED:-}" ]; then
  # shellcheck source=../../valet.d/core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
fi
# --- END OF COMMAND COMMON PART
# Everything above this line should stay as is for every command file you create.
# Your command can use all the functions defined in the core script of valet.


#===============================================================
# >>> command: showcase
#===============================================================

# TODO: autogenerate this kind of functions for each sub command root

# Note that you do not need this menu if you command function only has a single command level.
# E.g.  "command: showcase command1" is a 2 level command.
# and   "command: command1" is a single level command.

function about_showcaseMenu() {
  echo "
command: showcase
fileToSource: ${BASH_SOURCE[0]}
shortDescription: Show the showcase sub menu.
description: |-
  Can be used to show the showcase sub menu in interactive mode.
arguments:
  - name: commands?...
    description: |-
      The command to execute.

      See the commands section for more information.
examples:
  - name: showcase command1
    description: |-
      Run the ⌜command1⌝ showcase command.
"
}

function showcaseMenu() {
  showSubMenu "$@"
}


#===============================================================
# >>> command: showcase command1
#===============================================================

# shellcheck disable=SC2317
function about_showcaseCommand1() {
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

function showcaseCommand1() {
  local -a more
  parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  checkParseResults "${help:-}" "${parsingErrors:-}"

  inform "First argument: ${firstArg:-}."
  inform "Option 1: ${option1:-}."
  inform "Option 2: ${thisIsOption2:-}."
  inform "More: ${more[*]}."
}


#===============================================================
# >>> command: showcase hello-world
#===============================================================

# shellcheck disable=SC2317
function about_helloWorld() {
  echo "
command: showcase hello-world
fileToSource: ${BASH_SOURCE[0]}
shortDescription: An hello world command
description: |-
  An hello world command.
"
}

function helloWorld() {
  echo "Hello world!"
}


#===============================================================
# >>> command: showcase sudo-command
#===============================================================


# shellcheck disable=SC2317
function about_showCaseSudo() {
  echo "
command: showcase sudo-command
fileToSource: ${BASH_SOURCE[0]}
sudo: true
shortDescription: A command that requires sudo
description: |-
  Before starting this command, valet will check if sudo is available.

  If so, it will require the user to enter the sudo password and use sudo inside the command
"
}

function showCaseSudo() {
  $SUDO whoami
}


#===============================================================
# >>> Additional hook functions
#===============================================================

# This function is called before the program exits.
function onExit() {
  debug "Exiting a showcase command."
}

# This function is always called before the program ends and allows
# you to do some custom clean up.
function cleanUp() {
  debug "Cleaning up stuff in the showcase commands."
}

# This function should return 0 to cancel the interruption
# or any other code to continue interrupting the program.
# It is called on signal SIGINT and SIGQUIT.
# shellcheck disable=SC2317
onInterrupt() {
  return 0
}

# This function should return 0 to cancel the termination
# or any other code to interrupt the program.
# It is called on signal SIGHUP and SIGTERM.
# shellcheck disable=SC2317
onTerminate() {
  return 0
}
