#!/usr/bin/env bash

#===============================================================
# >>> command: showcase command1
#===============================================================

: <<"COMMAND_YAML"
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
COMMAND_YAML
function showcaseCommand1() {
  local -a more
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  # always call "cleanUp" on exit to do some custom clean up
  trap::register cleanUp on-exit

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

function cleanUp() {
  log::debug "Cleaning up stuff in the showcase commands."
}
