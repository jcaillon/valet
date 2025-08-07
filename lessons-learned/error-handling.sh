#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
exec {LOG_FD}>&2
export VALET_CONFIG_LOG_FD=${LOG_FD}
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<subshell>{1s}] <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"

# shellcheck source=../libraries.d/main
source "$(valet --source)"
include bash

#####################

function problems() {
  subProblems
  log::warning "Should never be reached, this is a problem."
}

function subProblems() {
  ((0/0))
  log::warning "Should never be reached, this is a problem."
}

if problems; then
  log::warning "If statements will disable err trap for everything inside the if block so the program does not fail where it should have."
fi

eval "bash::runInSubshell problems"
if (( REPLY != 0 )); then
  log::info "The problems function failed."
fi

bash::runInSubshell problems
if (( REPLY != 0 )); then
  log::info "The problems function failed."
fi

log::info "# LESSONS LEARNED:

- It is crucial to remember that any command executed in a 'until', 'while', 'if', or as part of a '!', '||', '&&' pipeline will not trigger the ERR trap if it fails!
  See: <https://www.gnu.org/software/bash/manual/bash.html#index-trap> and <https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin-1>.
- This is also true for the body of a function that runs in this context where the ERR trap is not triggered.
  Quote from bash manual : 'If a compound command or shell function executes in a context where -e is being ignored, none of the commands executed within the compound command or function body will be affected by the -e setting, even if -e is set and a command returns a failure status.'
- with the bash option nounset will cause bash to exit without triggering the ERR trap if a variable is not set.
  This is because the ERR trap is only triggered by commands that return a non-zero exit status, and an unset variable does not return a non-zero exit status.
"