#!/usr/bin/env bash

# shellcheck source=../libraries.d/lib-extension2
source extension2

#===============================================================
# >>> command: extension2
#===============================================================

: <<"COMMAND_YAML"
command: extension2
function: extension2
shortDescription: Do nothing.
description: |-
  Really, it does nothing.
examples:
- name: extension2
  description: |-
    Just run the command and do nothing.
COMMAND_YAML
function extension2() {
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults

  extension2::doNothing
  :;
}
