#!/usr/bin/env bash

# shellcheck source=../libs.d/lib-extension2
source extension2

#===============================================================
# >>> command: extension2
#===============================================================

##<<VALET_COMMAND
# command: extension2
# function: extension2
# shortDescription: Do nothing.
# description: |-
#   Really, it does nothing.
# examples:
# - name: extension2
#   description: |-
#     Just run the command and do nothing.
##VALET_COMMAND
function extension2() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  extension2::doNothing
  :;
}
