#!/usr/bin/env bash

# shellcheck source=../libs.d/lib-extension1
source extension1

#===============================================================
# >>> command: extension1
#===============================================================

##<<VALET_COMMAND
# command: extension1
# function: extension1
# shortDescription: Do nothing.
# description: |-
#   Really, it does nothing.
# examples:
# - name: extension1
#   description: |-
#     Just run the command and do nothing.
##VALET_COMMAND
function extension1() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  extension1::doNothing
  :;
}
