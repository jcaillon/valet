#!/usr/bin/env bash

# shellcheck source=../libraries.d/lib-extension3
source extension3

#===============================================================
# >>> command: extension3
#===============================================================

##<<VALET_COMMAND
# command: extension3
# function: extension3
# shortDescription: Do nothing.
# description: |-
#   Really, it does nothing.
# examples:
# - name: extension3
#   description: |-
#     Just run the command and do nothing.
##VALET_COMMAND
function extension3() {
  command::parseArguments "$@" && eval "${RETURNED_VALUE}"
  command::checkParsedResults

  extension3::doNothing
  :;
}
