#!/usr/bin/env bash

# shellcheck source=../../commands.d/self-build-utils
source "${GLOBAL_VALET_HOME}/commands.d/self-build-utils"

_VALID_YAML="
command: test
author: github.com/jcaillon
fileToSource: source
shortDescription: Short description.
description: |-
  A long description.

  In a multi-line string.

  With 3 paragraphs.
sudo: false
hideInMenu: false
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
- name: --option1
  description: |-
    Description of option 1.

    Another line.
  noEnvironmentVariable: true
  default: true
- name: --option2
  description: |-
    Description of option 2.

    Another line.
  noEnvironmentVariable: false
- description: |-
    Description of option 3.

    Another line.
  default: default value
examples:
- name: command -o -2 value1 arg1 more1 more2
  description: |-
    Call command with option1, option2 and some arguments.
"

function testExtractCommandYamls() {

  extractCommandYamls "resources/extract-command-yamls-test-file"

  local content
  for content in "${RETURNED_ARRAY[@]}"; do
    log::info "content:"
    log::printFileString "${content}"
  done

  test::endTest "Testing extractCommandYamls" 0
}

function testExtractCommandDefinitionToVariables() {
  log::printFileString "${_VALID_YAML}"

  extractCommandDefinitionToVariables "${_VALID_YAML}"

  printVars ${!TEMP_CMD_BUILD_*}

  test::endTest "Testing extractCommandDefinitionToVariables" 0
}

function testExtractFirstLongNameFromOptionString() {

  local optionString="-x, --profiling"

  echo "→ extractFirstLongNameFromOptionString '${optionString}'"
  extractFirstLongNameFromOptionString "${optionString}" && echo "${RETURNED_VALUE}"

  test::endTest "Testing extractFirstLongNameFromOptionString" 0
}

function testDeclareFinalVariables() {
  log::printFileString "${_VALID_YAML}"

  # declare common variables
  declareFinalCommandDefinitionCommonVariables "func" "cmd"

  # declare help variables
  declareFinalCommandDefinitionHelpVariables "func"

  # declare options and arguments for the parser
  declareFinalCommandDefinitionParserVariables "func"

  printVars ${!CMD_*}

  test::endTest "Testing declareFinalCommandDefinition*" 0
}

function testVerifyCommandDefinition() {
  log::printFileString "${_VALID_YAML}"

  # verify that the command definition is valid
  verifyCommandDefinition "func" "cmd"
  echo
  echo "${SELF_BUILD_ERRORS:-}"

  test::endTest "Testing verifyCommandDefinition" 0
}

function printVars() {
  local varName var
  for varName in "$@"; do
    local -n var="${varName}"
    echo "${varName}=${var[*]@K}"
  done
}

function main() {
  testExtractCommandYamls
  testExtractCommandDefinitionToVariables
  testExtractFirstLongNameFromOptionString

  testDeclareFinalVariables
  testVerifyCommandDefinition
}
# save all CMD_* variables into a temporary string
io::invoke declare -p ${!CMD_*}
_ALL_CMD_VARIABLES="${RETURNED_VALUE//declare -? /}"
unset -v ${!CMD_*} _LINE

main

# reset all CMD_* as they were
unset -v _VALID_YAML
unset -v ${!CMD_*}
eval "${_ALL_CMD_VARIABLES}"