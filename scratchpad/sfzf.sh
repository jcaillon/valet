#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include progress interactive

log::info "Displaying a question box."
interactive::displayQuestion "What is your favorite color?"

log::info "Displaying an answer box."
interactive::displayAnswer "My favorite color is blue."

############################
# Confirmation
############################

log::info "Getting user confirmation:"
interactive::askForConfirmation "Please press ENTER to continue."

############################
# Yes/no
############################

log::info "Getting user yes/no:"
if interactive::promptYesNo "Do you want to abort this demo?" false; then
  log::warning "Aborting the demo."
  return 0
fi

log::info "Creating some space below this line."
tui::createSpace 4

############################
# Fsfs
############################

log::warning "Display a full screen selection."

declare -g -a SELECTION_ARRAY
# shellcheck disable=SC2034
SELECTION_ARRAY=("blue" "red" "green" "yellow")
# shellcheck disable=SC2317

function getColorSample() { local -n color="AC__FG_${1^^}"; RETURNED_VALUE="${color}AC__FG_${1^^}${AC__TEXT_RESET}"; }
sfzf::show "What's your favorite color?" SELECTION_ARRAY "getColorSample" "Color sample"
log::info "You selected: ⌜${RETURNED_VALUE}⌝ (index: ⌜${RETURNED_VALUE2}⌝)"

log::warning "Now displaying a spinner"

_OPTION_SPINNER="⢄⢂⢁⡁⡈⡐⡠" progress::start "<spinner>" "20" 50

IDX=0
while [[ ${IDX} -lt 3 ]]; do
  IDX=$((IDX + 1))
  log::info "We can still output logs while the spinner runs..."
  sleep 1
done

progress::stop

