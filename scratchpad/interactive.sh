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
