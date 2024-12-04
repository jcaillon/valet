#!/usr/bin/env bash

#===============================================================
# >>> command: _COMMAND_NAME_
#===============================================================

: "---
command: _COMMAND_NAME_
function: _FUNCTION_NAME_
shortDescription: My new command one line description.
description: |-
  My long description.
sudo: false
hideInMenu: false
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
  noEnvironmentVariable: true
- name: -2, --this-is-option2 <level>
  description: |-
    An option with a value.
  noEnvironmentVariable: false
examples:
- name: _COMMAND_NAME_ -o -2 value1 arg1 more1 more2
  description: |-
    Call _COMMAND_NAME_ with option1, option2 and some arguments.
---"
function _FUNCTION_NAME_() {
  local -a more
  local firstArg option1 thisIsOption2
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  log::info "First argument: ${firstArg:-}."
  log::info "Option 1: ${option1:-}."
  log::info "Option 2: ${thisIsOption2:-}."
  log::info "More: ${more[*]}."

  # example use of a library function
  # Importing the string library (note that we could also do that at the beginning of the script)
  # shellcheck disable=SC1091
  source string
  string::extractBetween "<b>My bold text</b>" "<b>" "</b>"
  local extractedText="${RETURNED_VALUE}"
  log::info "Extracted text is: ⌜${extractedText:-}⌝"
}