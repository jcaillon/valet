#!/usr/bin/env bash

# shellcheck source=../libraries.d/lib-extension3
source extension3

#===============================================================
# >>> command: extension3
#===============================================================

: <<"COMMAND_YAML"
command: extension3
function: extension3
shortDescription: Do nothing.
description: |-
  Really, it does nothing.
examples:
- name: extension3
  description: |-
    Just run the command and do nothing.
COMMAND_YAML
function extension3() {
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults

  extension3::doNothing
  :;
}
