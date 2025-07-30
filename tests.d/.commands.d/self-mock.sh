#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ ! -v GLOBAL_CORE_INCLUDED ]]; then
  # shellcheck source=../../libraries.d/core
  source "$(valet --source)"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../../libraries.d/lib-fs
source fs
# shellcheck source=../../libraries.d/lib-bash
source bash

#===============================================================
# >>> command: self mock1
#===============================================================

: "---
command: self mock1
hideInMenu: true
function: selfMock1
author: github.com/jcaillon
shortDescription: A command that only for testing valet core functions.
description: |-
  A command that only for testing valet core functions.
arguments:
- name: action
  description: |-
    The action to perform.
    One of the following options:

    - error
    - fail
    - fail2
    - exit
    - unknown-command
    - create-temp-files
    - logging-level
    - wait-indefinitely
    - show-help
---"
function selfMock1() {
  command::parseArguments "$@" && eval "${REPLY}"
  command::checkParsedResults

  case "${action:-}" in
  error)
    log::warning "This is for testing valet core functions, the next statement will return 1 and create an error."
    returnOne
    ;;
  fail)
    core::fail "This is for testing valet core functions, failing now."
    ;;
  fail2)
    _OPTION_EXIT_CODE=255 core::fail "This is for testing valet core functions, failing now with exit code 255."
    ;;
  exit)
    # shellcheck disable=SC2317
    function trap::onCleanUp() {
      log::warning "This is a custom on exit function."
    }
    log::warning "This is for testing valet core functions, exiting with code 5."
    exit 5
    ;;
  unknown-command)
    log::warning "This is for testing valet core functions, the next statement will call a non existing command, causing a call to command_not_found_handle."
    thisIsAnUnknownCommandForTesting
    ;;
  divide-by-zero)
    log::warning "This is for testing valet core functions, the next statement will call a bash error."
    ((10/0))
    log::warning "This line should not be reached, the previous command should have failed."
    ;;
  create-temp-files)
    # shellcheck disable=SC2317
    function trap::onCleanUp() {
      log::warning "This is a custom clean up function."
    }
    local tmp1 tmp2 tmp3 tmp4
    fs::createTempFile
    tmp1="${REPLY}"
    fs::createTempFile
    tmp2="${REPLY}"
    fs::createTempDirectory
    tmp3="${REPLY}"
    fs::createTempDirectory
    tmp4="${REPLY}"
    log::info "Created temp file: ${tmp1//${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}/\/tmp/valet}."
    log::info "Created temp file: ${tmp2//${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}/\/tmp/valet}."
    log::info "Created temp directory: ${tmp3//${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}/\/tmp/valet}."
    log::info "Created temp directory: ${tmp4//${GLOBAL_TEMPORARY_DIRECTORY_PREFIX}/\/tmp/valet}."
    # activating debug log to see the cleanup
    log::setLevel debug
    ;;
  logging-level)
    log::errorTrace "This is an error trace message which is always displayed."
    log::trace "This is a trace message."
    log::debug "This is a debug message."
    log::info "This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out."
    log::success "This is a success message."
    log::warning "This is a warning message."$'\n'"With a second line."
    if log::isDebugEnabled; then
      log::printString "The debug mode is activated!"
    fi
    if log::isTraceEnabled; then
      log::printString "The trace mode is activated!"
    fi
    ;;
  wait-indefinitely)
    log::info "This is for testing valet core functions, waiting indefinitely."
    bash::sleep 999
    ;;
  show-help)
    command::showHelp
    ;;
  *)
    log::warning "This is for testing valet core functions, running the tests."
    ;;
  esac
}

function returnOne() { return 1; }



#===============================================================
# >>> command: self mock2
#===============================================================

: "---
command: self mock2
hideInMenu: true
function: selfMock2
author: github.com/jcaillon
shortDescription: A command that only for testing valet core functions.
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
- name: -3, --flag3
  description: |-
    Third option.
- name: -4, --with-default <val>
  description: |-
    An option with a default value.
  default: cool
examples:
- name: self mock2 -o -2 value1 arg1 more1 more2
  description: |-
    Call command1 with option1, option2 and some arguments.
---"
function selfMock2() {
  local -a more
  command::parseArguments "$@" && eval "${REPLY}"
  command::checkParsedResults

  log::info "Option 1 (option1): ${option1:-}."
  log::info "Option 2 (thisIsOption2): ${thisIsOption2:-}."
  log::info "Option 3 (flag3): ${flag3:-}."
  log::info "Option 4 (withDefault): ${withDefault:-}."
  log::info "First argument: ${firstArg:-}."
  log::info "More: ${more[*]}."

  aSubFunctionInselfMock2

  printf '%s\n' "That's it!"
}

function aSubFunctionInselfMock2() {
  # this is mainly to demonstrate the profiler
  log::debug "This is a sub function."
}


#===============================================================
# >>> command: self mock3
#===============================================================
: "---
command: self mock3
hideInMenu: true
function: selfMock3
sudo: true
shortDescription: A command that only for testing valet core functions.
description: |-
  Before starting this command, valet will check if sudo is available.

  If so, it will require the user to enter the sudo password and use sudo inside the command
---"
function selfMock3() {
  command::parseArguments "$@" && eval "${REPLY}"
  command::checkParsedResults

  ${SUDO} whoami
}
