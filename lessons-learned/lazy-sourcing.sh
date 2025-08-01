#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_LOG_LEVEL=debug
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<subshell>{1s}] <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"

# shellcheck source=../libraries.d/main
source "$(valet --source)"

function command_not_found_handle() {
  local commandNotFound="${1:-}"
  local errorMessage

  # if the command contains :: it is one of our function, we can try to auto source it
  if [[ ${commandNotFound} == *::* ]]; then
    local possibleLibraryName="${commandNotFound%%::*}"
    # shellcheck disable=SC1090
    if ! _OPTION_EXIT_IF_NOT_FOUND=false _OPTION_RETURN_CODE_ALREADY_INCLUDED=2 source "${possibleLibraryName}"; then
      if (( $? == 2 )); then
        # we already sourced the corresponding library so the command is missing
        errorMessage="Command not found: ⌜${commandNotFound}⌝. The library ⌜${possibleLibraryName}⌝ has already been sourced but does not contain the command."
      else
        errorMessage="Command not found: ⌜${commandNotFound}⌝. Could not find a file to source for the library ⌜${possibleLibraryName}⌝, source it manually or make sure it either in the valet or user libraries."
      fi
    else
      if command -v "${commandNotFound}" &>/dev/null; then
        log::debug "Sourced library ⌜${possibleLibraryName}⌝ for missing command ⌜${commandNotFound}⌝. Now re-executing the command:" "${*}"
        # re-executing the original command
        if "${@}"; then
          return 0
        else
          return ${?}
        fi
      else
        errorMessage="Command not found: ⌜${commandNotFound}⌝. The library ⌜${possibleLibraryName}⌝ has been sourced but does not contain the command."
      fi
    fi

  elif [[ ${commandNotFound} == "curl" ]]; then
    errorMessage="This command requires ⌜curl⌝ to make https request to the internet."$'\n'"Please install it in your path and run this command again."
  else
    errorMessage="Command not found: ⌜${commandNotFound}⌝."$'\n'"Please check your ⌜PATH⌝ variable."
  fi

  # check for recursive call
  if [[ ${GLOBAL_COMMAND_NOT_FOUND:-} == "${commandNotFound}" ]]; then
    # we are here if the error happened in a log function and thus we couldn't print the error
    printf '%s\n%s\n' "Command not found: ⌜${commandNotFound}⌝." "Error in a log function." >&2
    log::getCallStack 2
    printf '%s\n' "${REPLY}" >&2
  else
    GLOBAL_COMMAND_NOT_FOUND="${commandNotFound}"
    log::print "ERROR" "${ICON_ERROR:-}" "CMDMISS" "${errorMessage}"
    log::printCallStack 2
  fi
  unset -v GLOBAL_COMMAND_NOT_FOUND

  GLOBAL_EXPECTED_EXIT=1
  return 1
  # since this runs in a subshell, we don't actually exit the main program
  # but we set $? to 1 so ERR trap is called
}

function funcEager() {
  local -i index
  for (( index = 0; index < 100; index++ )); do
    source bash
    if bash::isCommand "fu"; then
      :;
    fi
  done
}

function funcLazy() {
  local -i index
  for (( index = 0; index < 100; index++ )); do
    if bash::isCommand "fu"; then
      :;
    fi
    unset -f bash::isCommand
  done
}

if bash::isCommand "fu"; then
  log::info "fu exists"
else
  log::info "fu is missing"
fi
unset -f bash::isCommand
if bash::isCommand "bash::isFunction"; then
  log::info "fu exists"
else
  log::info "fu is missing"
fi

log::info "The end"

log::info "LESSONS LEARNED:

- if we return 0 in command_not_found_handle, the main process will continue
  after the failing statement but it will not replay it.
- command_not_found_handle is executed in a separate process
- we do have the missing command and its arguments available in the command_not_found_handle but even if we can re-execute it,
  it is not really usable because it is executed in a different process so we would lose
  any REPLY set with it (for instance).

So unfortunately, this is not a good solution to auto source libraries on missing commands.
"