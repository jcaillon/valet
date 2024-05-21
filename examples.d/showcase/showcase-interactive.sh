#!/usr/bin/env bash

# Importing libraries from the core (note that we could do that in the function that needs it as well)
# shellcheck disable=SC1091
source interactive

#===============================================================
# >>> command: showcase interactive
#===============================================================

: "---
command: showcase interactive
function: showcaseInteractive
shortDescription: A showcase command that demonstrates how to interact with the user.
description: |-
  This command demonstrates how to interact with the user using valet's interactive library.
---"
function showcaseInteractive() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  interactive::getCursorPosition
  echo "CURSOR_LINE: ${CURSOR_LINE}"
  echo "CURSOR_COLUMN: ${CURSOR_COLUMN}"

  interactive::askForConfirmationRaw
}
