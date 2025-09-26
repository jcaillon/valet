#!/usr/bin/env bash

# Importing libraries from the core (note that we could do that in the function that needs it as well)
# shellcheck disable=SC1091
source interactive
# shellcheck disable=SC1091
source progress
# shellcheck disable=SC1091
source sfzf

#===============================================================
# >>> command: showcase interactive
#===============================================================

: <<"COMMAND_YAML"
command: showcase interactive
function: showcaseInteractive
shortDescription: A showcase command that demonstrates how to interact with the user.
description: |-
  This command demonstrates how to interact with the user using valet's interactive library.
COMMAND_YAML
function showcaseInteractive() {
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults

  log::info "Getting the cursor size:"
  terminal::getCursorPosition
  log::info "GLOBAL_CURSOR_LINE: ⌜${GLOBAL_CURSOR_LINE}⌝"
  log::info "GLOBAL_CURSOR_COLUMN: ⌜${GLOBAL_CURSOR_COLUMN}⌝"

  log::info "Getting the terminal size:"
  terminal::getTerminalSize
  log::info "GLOBAL_LINES: ⌜${GLOBAL_LINES}⌝"
  log::info "GLOBAL_COLUMNS: ⌜${GLOBAL_COLUMNS}⌝"

  log::info "Displaying a question box."
  interactive::displayQuestion "What is your favorite color?"

  log::info "Displaying an answer box."
  interactive::displayAnswer "My favorite color is blue."

  ############################
  # Confirmation
  ############################

  log::info "Getting user confirmation:"
  interactive::continue "Please press ENTER to continue."

  ############################
  # Yes/no
  ############################

  log::info "Getting user yes/no:"
  if interactive::confirm "Do you want to abort this demo?" default=false; then
    log::warning "Aborting the demo."
    return 0
  fi

  log::info "Creating some space below this line."
  terminal::createSpace 4

  ############################
  # Fsfs
  ############################

  log::warning "Display a full screen selection."

  declare -g -a SELECTION_ARRAY
  # shellcheck disable=SC2034
  SELECTION_ARRAY=("blue" "red" "green" "yellow")
  # shellcheck disable=SC2317

  function getColorSample() { local -n color="ESC__FG_${1^^}"; REPLY="${color}ESC__FG_${1^^}${ESC__TEXT_RESET}"; }
  sfzf::show SELECTION_ARRAY prompt="What's your favorite color?" itemDetailsCallback="getColorSample" previewTitle="Color sample"
  log::info "You selected: ⌜${REPLY}⌝ (index: ⌜${REPLY2}⌝)"

  ############################
  # Spinner
  ############################

  log::warning "Now displaying a spinner"

  progress::start template="<spinner>" size=20 frameDelay=50 spinnerFrames="⢄⢂⢁⡁⡈⡐⡠"

  IDX=0
  while [[ ${IDX} -lt 3 ]]; do
    IDX=$((IDX + 1))
    log::info "We can still output logs while the spinner runs..."
    sleep 1
  done

  progress::stop


  ############################
  # Progress bar
  ############################

  log::warning "Now displaying a progress bar."

  IDX=0
  while [[ ${IDX} -le 50 ]]; do
    progress::update percent=$((IDX * 2)) message="doing something ${IDX}..."
    IDX=$((IDX + 1))
    # log::info "alright ${IDX}..."
    sleep 0.1
  done

  progress::stop


  log::info "End of demo!"


}
