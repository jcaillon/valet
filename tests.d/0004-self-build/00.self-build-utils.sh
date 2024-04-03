#!/usr/bin/env bash

# shellcheck source=../../valet.d/commands.d/self-build-utils
source "${VALET_HOME}/valet.d/commands.d/self-build-utils"

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

  declare -p ${!TEMP_CMD_BUILD_*}

  endTest "Testing extractCommandDefinitionToVariables" 0
}

function testMakeArraysSameSize {
  declare -g array1=("a" "b" "c")
  declare -g array2=("" "2")
  declare -g array3=("x" "y" "z" "w")

  makeArraysSameSize array1 array2 array3 array4

  declare -p array1 array2 array3 array4

  endTest "Testing makeArraysSameSize" 0
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
  testMakeArraysSameSize
  testExtractFirstLongNameFromOptionString
}
main
