#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet)
if [[ -z "${_CORE_INCLUDED:-}" ]]; then
  VALETD_DIR="${BASH_SOURCE[0]}"
  if [[ "${VALETD_DIR}" != /* ]]; then
    if pushd "${VALETD_DIR%/*}" &>/dev/null; then
      VALETD_DIR="${PWD}"
      popd &>/dev/null || true
    else VALETD_DIR="${PWD}"; fi
  else VALETD_DIR="${VALETD_DIR%/*}"; fi
  # shellcheck source=../core
  source "${VALETD_DIR%/*}/core"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> command: self test-core1
#===============================================================

: "---
command: self test-core1
hideInMenu: true
function: selfTestCore1
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
    - exit
    - unknown-command
    - create-temp-files
    - logging-level
    - wait-indefinitely
    - show-help
---"
function selfTestCore1() {
  parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  checkParseResults "${help:-}" "${parsingErrors:-}"

  case "${action:-}" in
  error)
    warn "This is for testing valet core functions, the next statement will return 1 and create an error."
    returnOne
    ;;
  fail)
    fail "This is for testing valet core functions, failing now."
    ;;
  exit)
    # shellcheck disable=SC2317
    function onExit() {
      warn "This is a custom on exit function."
    }
    warn "This is for testing valet core functions, exiting with code 5."
    exit 5
    ;;
  unknown-command)
    warn "This is for testing valet core functions, the next statement will call a non existing command, causing a call to command_not_found_handle."
    thisIsAnUnknownCommandForTesting
    ;;
  create-temp-files)
    # shellcheck disable=SC2317
    function cleanUp() {
      warn "This is a custom clean up function."
    }
    local tmp1 tmp2 tmp3 tmp4
    createTempFile && tmp1="${LAST_RETURNED_VALUE}"
    createTempFile && tmp2="${LAST_RETURNED_VALUE}"
    createTempDirectory && tmp3="${LAST_RETURNED_VALUE}"
    createTempDirectory && tmp4="${LAST_RETURNED_VALUE}"
    inform "Created temp file: ${tmp1}."
    inform "Created temp file: ${tmp2}."
    inform "Created temp directory: ${tmp3}."
    inform "Created temp directory: ${tmp4}."
    # activating debug log to see the cleanup
    setLogLevel "debug"
    ;;
  logging-level)
    debug "This is a debug message."
    inform "This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out."
    succeed "This is a success message."
    warn "This is a warning message."$'\n'"With a second line."
    if isDebugEnabled; then
      echo "The debug mode is activated!" 1>&2
    fi
    ;;
  wait-indefinitely)
    inform "This is for testing valet core functions, waiting indefinitely."
    while true; do
      # sleep for 1s
      read -rt 1 <> <(:) || :
    done
    ;;
  show-help)
    showHelp
    ;;
  *)
    warn "This is for testing valet core functions, running the tests."
    ;;
  esac
}

function returnOne() { return 1; }



#===============================================================
# >>> command: self test-core1
#===============================================================

: "---
command: self test-core2
hideInMenu: true
function: selfTestCore2
author: github.com/jcaillon
shortDescription: A command that only for testing valet core functions.
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
  noEnvironmentVariable: true
- name: -2, --this-is-option2 <level>
  description: |-
    An option with a value.
examples:
- name: self test-core2 -o -2 value1 arg1 more1 more2
  description: |-
    Call command1 with option1, option2 and some arguments.
---"
function selfTestCore2() {
  local -a more
  parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  checkParseResults "${help:-}" "${parsingErrors:-}"

  inform "First argument: ${firstArg:-}."
  inform "Option 1: ${option1:-}."
  inform "Option 2: ${thisIsOption2:-}."
  inform "More: ${more[*]}."

  aSubFunctionInSelfTestCore2

  echo "That's it!"
}

function aSubFunctionInSelfTestCore2() {
  # this is mainly to demonstrate the profiler
  debug "This is a sub function."
}

#===============================================================
# >>> command: self test-core3
#===============================================================
: "---
command: self test-core3
function: selfTestCore3
sudo: true
shortDescription: A command that only for testing valet core functions.
description: |-
  Before starting this command, valet will check if sudo is available.

  If so, it will require the user to enter the sudo password and use sudo inside the command
---"
function selfTestCore3() {
  parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  checkParseResults "${help:-}" "${parsingErrors:-}"

  ${SUDO} whoami
}