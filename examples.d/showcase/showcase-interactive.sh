#!/usr/bin/env bash

# Importing libraries from the core (note that we could do that in the function that needs it as well)
# shellcheck disable=SC1091
source interactive

# shellcheck disable=SC1091
source fsfs

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

  log::info "Getting the cursor size:"
  interactive::getCursorPosition
  log::info "CURSOR_LINE: ⌜${CURSOR_LINE}⌝"
  log::info "CURSOR_COLUMN: ⌜${CURSOR_COLUMN}⌝"

  log::info "Getting the terminal size:"
  system::exportTerminalSize
  log::info "GLOBAL_LINES: ⌜${GLOBAL_LINES}⌝"
  log::info "GLOBAL_COLUMNS: ⌜${GLOBAL_COLUMNS}⌝"

  log::info "Displaying a question box."
  interactive::displayQuestion "What is your favorite color?"

  # log::info "Getting user input"

  log::info "Displaying an answer box."
  interactive::displayAnswer "My favorite color is blue."

  log::info "Getting user confirmation:"
  interactive::askForConfirmation "Please press ENTER to continue."

  log::info "Getting user yes/no:"
  if interactive::promptYesNo "Do you want to abort this demo?" false; then
    log::warning "Aborting the demo."
    return 0
  fi

  log::info "Creating some space below this line."
  interactive::createSpace 4

  log::info "Display a full screen selection."

  declare -g -a SELECTION_ARRAY
  # shellcheck disable=SC2034
  SELECTION_ARRAY=("blue" "red" "green" "yellow")
  # shellcheck disable=SC2317

  function getColorSample() { local -n color="AC__FG_${1^^}"; RETURNED_VALUE="${color}AC__FG_${1^^}${AC__TEXT_RESET}"; }
  fsfs::itemSelector "What's your favorite color?" SELECTION_ARRAY "getColorSample" "Color sample"
  log::info "You selected: ⌜${RETURNED_VALUE}⌝ (index: ⌜${RETURNED_VALUE2}⌝)"


  log::info "Now displaying a spinner"

  interactive::startSpinner

  IDX=0
  while [[ ${IDX} -lt 5 ]]; do
    IDX=$((IDX + 1))
    log::info "We can still output logs while the spinner runs..."
    sleep 1
  done

  interactive::stopSpinner

  log::info "End of demo!"


}
