#!/usr/bin/env bash
# shellcheck disable=SC1091
export TMPDIR=tmp
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
exec {LOG_FD}>&2
export VALET_CONFIG_LOG_FD=${LOG_FD}
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:<subshell>{1s}] <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"

source "libraries.d/core"
include bash time


trap -- 'log::error EXIT WITH CODE $?' EXIT
trap -- 'log::error ERR CODE $?' ERR

log::info "PID: ${BASHPID}"
bash::getBuiltinOutput trap -p
ORIGINAL_TRAPS="${RETURNED_VALUE}"
bash::getBuiltinOutput shopt -p
ORIGINAL_SHOPT="${RETURNED_VALUE}"
bash::getBuiltinOutput shopt -p -o
ORIGINAL_SET="${RETURNED_VALUE}"

log::info "======= Testing a subshell in expansion ======="
TEST="$(
  log::info "SUBSHELL PID: ${BASHPID}"
  ((0/0))
  bash::getBuiltinOutput shopt -p -o
  if [[ ${ORIGINAL_SET} == "${RETURNED_VALUE}" ]]; then
    log::info "Inherited the set options."
  else
    log::warning "Set options have changed (set +e because we are in a substitution shell)."
  fi

  log::warning "We do get here, because the subshell does not exit on error since sub"
)"



log::info "======= Testing another subshell in a list of commands ======="

(
  log::info "SUBSHELL PID: ${BASHPID}"
  ((0/0))

  bash::getBuiltinOutput trap -p
  if [[ ${ORIGINAL_TRAPS} == "${RETURNED_VALUE}" ]]; then
    log::info "Inherited the traps."
  else
    log::error "Trap settings have changed."
  fi
  bash::getBuiltinOutput shopt -p
  if [[ ${ORIGINAL_SHOPT} == "${RETURNED_VALUE}" ]]; then
    log::info "Inherited the shopt settings."
  else
    log::error "Shopt settings have changed."
  fi
  bash::getBuiltinOutput shopt -p -o
  if [[ ${ORIGINAL_SET} == "${RETURNED_VALUE}" ]]; then
    log::info "Inherited the set options."
  else
    log::error "Set options have changed."
  fi

  anUnknownCommandThatDoesNotTriggerAnErrorCode1OnThisLine
  # Instead it continues...

  log::info "If we re-register the traps it still does nothing"
  trap -- 'log::error EXIT WITH CODE $?' EXIT
  core::setShellOptions
  anotherUnknownCommandButThisTimeItExits

  log::info "We do get here and the return code of this last command will be the return code of the subshell."
) || log::info "Hmmmmm"


(
  log::info "SUBSHELL PID: ${BASHPID}"
  exit 1
) || log::info "The EXIT trap is not triggered"

(
  log::info "SUBSHELL PID: ${BASHPID}"
  anUnknownCommand
) || log::info "If the last command in the subshell is in error, we do have the subshell in error"

(
  log::info "SUBSHELL PID: ${BASHPID}"
  ((0/0))
) || log::info "If the last command in the subshell is in error, we do have the subshell in error"

(
  trap -- 'log::error EXIT WITH CODE $?' EXIT
  exit 1
) || log::info "If we re register the traps, the EXIT trap is triggered in the subshell"


log::info "======= Testing subshell in a if ======="

if (
  log::info "SUBSHELL PID: ${BASHPID}"
  ((0/0))
  log::info "continue here even if the subshell exits on error"
); then
  log::info "Does not detect an error in the subshell"
fi

BAD_STUFF="((0/0)); echo ok"
if (eval "${BAD_STUFF}"); then
  log::info "Does not detect an error in the subshell"
fi

EXPECT_EXIT="((0/0)); exit 1; echo ok"
if ! (eval "${EXPECT_EXIT}"); then
  log::info "If we expect an explicit exit, then I guess it is fine to use this..."
fi

function withAProblem() {
  log::info "SUBSHELL PID: ${BASHPID}"
  ((10/0))
  log::info "continue here even if the subshell exits on error"
}

if (
  withAProblem || exit 1
  log::info "continue here even if the subshell exits on error"
); then
  log::info "Does not detect an error in the subshell"
fi

# this is the only thing that works:

if (
  log::info "SUBSHELL PID: ${BASHPID}"
  ((0/0))
  log::info "continue here even if the subshell exits on error"
); then
  log::info "Does not detect an error in the subshell"
fi



log::info "======= The only way to make this work as expected (half as expected) ======="

set +o errexit
(
  set -o errexit
  log::info "SUBSHELL PID: ${BASHPID}"
  anUnknownCommand
  log::error "we don't get here because the subshell exits on error!"
)
if [[ $? -ne 0 ]]; then
  log::info "The subshell exited with an error code as expected."
  log::info "But the EXIT trap was not triggered in the subshell."
else
  log::error "The subshell did not exit with an error code as expected."
fi
set +o errexit

#TODO: implement this in a function; use it in lib-test (test::exit) + in self-extend (source extension script)
set +o errexit
(
  set -o errexit
  trap -- 'log::error EXIT WITH CODE $?' EXIT
  log::info "SUBSHELL PID: ${BASHPID}"
  anUnknownCommand
  log::error "we don't get here because the subshell exits on error!"
)
if [[ $? -ne 0 ]]; then
  log::info "The subshell exited with an error code as expected."
  log::info "AND the EXIT trap is triggered in the subshell."
else
  log::error "The subshell did not exit with an error code as expected."
fi
set +o errexit

log::info "End"


log::info "LESSONS LEARNED:

see bash::runInSubshell for a clean implementation.

- https://www.gnu.org/software/bash/manual/bash.html#Command-Execution-Environment
- Subshells inherit the traps, shopt settings, set options, etc... From the parent shell.

SUPER IMPORTANT:

- In command substitutions Bash clears the -e option in subshells (at least when not in POSIX mode which is our case).
- Never use the '() ||' or 'if ()' construct because the behavior is not comprehensible...
    - Even with the set -e option it does not stop on errors
    - the ERR trap and the EXIT trap are not respected
    - if we reregister the EXIT trap is does apply (but not the ERR trap)
    - it will runs all the commands in the subshell even when command fails and the subshell exit code
      will be the exit code of the last command executed in the subshell.
    - The only way to stop it is an exit command on each line, e.g. ((0/0)) || exit 1
- The only way to have the expected behavior is to:
  set +o errexit on main
  (
    enter the subshell and set -o errexit
    failing commands will make the subshell exit on error
  )
  capture the exit code of the subshell with \$?
  reactivate the set +o errexit on main
  and then check the exit code of the subshell

  However, even with this, the EXIT trap is not triggered in the subshell.
  To have the EXIT trap triggered in the subshell, we need to re-register it in the subshell.
"