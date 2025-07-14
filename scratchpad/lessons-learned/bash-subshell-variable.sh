#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"

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

log::info "LESSONS LEARNED:

- BASH_SUBSHELL indicates the level of nested shells;
- SHLVL does not seem to work.
"
