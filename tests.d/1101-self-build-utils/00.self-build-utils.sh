#!/usr/bin/env bash

# shellcheck source=../../valet.d/commands.d/self-build-utils
source "${GLOBAL_VALET_HOME}/valet.d/commands.d/self-build-utils"

function testExtractCommandYamls() {

  extractCommandYamls "resources/extract-command-yamls-test-file"

  local content
  for content in "${LAST_RETURNED_VALUE_ARRAY[@]}"; do
    echo "content:"$'\n'"⌜${content}⌝"
  done

  endTest "Testing extractCommandYamls" 0
}

function testExtractCommandDefinitionToVariables() {
  local content="
command: test
author: github.com/jcaillon
fileToSource: source
shortDescription: Short description.
description: |-
  A long description.

  In a multi-line string.

  With 3 paragraphs.
arguments:
- name: arg1
  description: Description of arg 1.
- name: arg2
  description: Description of arg 2.
  thirdProp: ok2
- name: arg3
  description: Description of arg 3.
  fourthProp: ok3
options:
- name: option1
  description: |-
    Description of option 1.

    Another line.
- name: option2
  description: |-
    Description of option 2.

    Another line.
- description: |-
    Description of option 3.

    Another line.
"
  echo "${content}"

  extractCommandDefinitionToVariables "${content}"

  local varName var
  for varName in ${!TEMP_CMD_BUILD_*}; do
    local -n var="${varName}"
    echo "${varName}=${var@Q}"
  done

  endTest "Testing extractCommandDefinitionToVariables" 0
}

function testExtractFirstLongNameFromOptionString() {

  local optionString="-x, --profiling"

  echo "→ extractFirstLongNameFromOptionString '${optionString}'"
  extractFirstLongNameFromOptionString "${optionString}" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing extractFirstLongNameFromOptionString" 0
}

function main() {
  testExtractCommandYamls
  testExtractCommandDefinitionToVariables
  testExtractFirstLongNameFromOptionString
}
main
