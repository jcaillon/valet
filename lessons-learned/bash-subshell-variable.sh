#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"

log::info "${BASH_SUBSHELL} ${SHLVL}"
(
  log::info "${BASH_SUBSHELL} ${SHLVL}"
  (
    log::info "${BASH_SUBSHELL} ${SHLVL}"
  )
)
(
  log::info "${BASH_SUBSHELL} ${SHLVL}"
  (
    log::info "${BASH_SUBSHELL} ${SHLVL}"
  )
)

log::info "# LESSONS LEARNED:

- BASH_SUBSHELL indicates the level of nested shells;
- SHLVL does not seem to work.
"
