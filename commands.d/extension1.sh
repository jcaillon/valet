#!/usr/bin/env bash

# shellcheck source=../libraries.d/lib-extension1
source extension1

#===============================================================
# >>> command: extension1
#===============================================================

: <<"COMMAND_YAML"
command: extension1
function: extension1
shortDescription: Do nothing.
description: |-
  Really, it does nothing.
examples:
- name: extension1
  description: |-
    Just run the command and do nothing.
COMMAND_YAML
function extension1() {
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults

  extension1::doNothing
  :;
}
