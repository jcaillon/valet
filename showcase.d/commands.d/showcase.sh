#!/usr/bin/env bash

#===============================================================
# >>> command: showcase command1
#===============================================================

: "---
command: showcase command1
function: showcaseCommand1
shortDescription: A showcase command that uses arguments and options.
description: |-
  An example of description.

  You can put any text here, it will be wrapped to fit the terminal width.

  You can ⌜highlight⌝ some text as well.
arguments:
- name: first-arg
  description: |-
    First argument.
- name: more...
  description: |-
    Will be an an array of strings.
options:
- name: -o, --option1
  description: |-
    First option.
  noEnvironmentVariable: true
- name: -2, --this-is-option2 <level>
  description: |-
    An option with a value.
  default: two
examples:
- name: showcase command1 -o -2 value1 arg1 more1 more2
  description: |-
    Call command1 with option1, option2 and some arguments.
---"
function showcaseCommand1() {
  local -a more
  command::parseArguments "$@" && eval "${REPLY}"
  command::checkParsedResults

  log::info "First argument: ${firstArg:-}."
  log::info "Option 1: ${option1:-}."
  log::info "Option 2: ${thisIsOption2:-}."
  log::info "More: ${more[*]}."

  # example use of a library function
  # Importing the string library (note that we could do that at the begining of the script)
  # shellcheck disable=SC1091
  source string
  local _myString="<b>My bold text</b>"
  string::extractBetween _myString "<b>" "</b>"
  local extractedText="${REPLY}"
  log::info "Extracted text is: ⌜${extractedText:-}⌝"

  echo "That's it!"
}


#===============================================================
# >>> command: showcase sudo-command
#===============================================================

: "---
command: showcase sudo-command
function: showCaseSudo
sudo: true
shortDescription: A command that requires sudo.
description: |-
  Before starting this command, valet will check if sudo is available.

  If so, it will require the user to enter the sudo password and you can use the \${SUDO} variable inside the command
---"
function showCaseSudo() {
  command::parseArguments "$@" && eval "${REPLY}"
  command::checkParsedResults

  ${SUDO} whoami
}


#===============================================================
# >>> Optional hook functions
#===============================================================

# This function is called before the program exits.
# It does not have to be defined.
function trap::onExit() {
  log::debug "Exiting a showcase command."
}

# This function is always called before the program ends and allows
# you to do some custom clean up.
# It does not have to be defined.
function trap::onCleanUp() {
  log::debug "Cleaning up stuff in the showcase commands."
}

# This function should return 0 to cancel the interruption
# or any other code to continue interrupting the program.
# It is called on signal SIGINT and SIGQUIT.
# It does not have to be defined.
# shellcheck disable=SC2317
function trap::onInterrupt() {
  return 0
}

# This function should return 0 to cancel the termination
# or any other code to interrupt the program.
# It is called on signal SIGHUP and SIGTERM.
# It does not have to be defined.
# shellcheck disable=SC2317
function trap::onTerminate() {
  return 0
}
