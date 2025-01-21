#!/usr/bin/env bash

# shellcheck source=../../commands.d/self-build-utils
source "${GLOBAL_VALET_HOME}/commands.d/self-build-utils"

function main() {
  unset -v ${!CMD_*}
  test_selfBuild_extractCommandYamls
  test_selfBuild_extractFirstLongNameFromOptionString
  test_selfBuild_commandVariables
}


function test_selfBuild_extractCommandYamls() {
  test::title "✅ Testing selfBuild_extractCommandYamls"

  test::func selfBuild_extractCommandYamls "resources/extract-command-yamls-test-file"
}

function test_selfBuild_extractFirstLongNameFromOptionString() {
  test::title "✅ Testing selfBuild_extractFirstLongNameFromOptionString"

  test::func selfBuild_extractFirstLongNameFromOptionString "-x, --profiling"
}

function test_selfBuild_commandVariables() {
  test::title "✅ Testing to extract command definition to variables"

  test::printVars _VALID_YAML

  test::exec selfBuild_extractCommandDefinitionToVariables "\"\${_VALID_YAML}\""

  # shellcheck disable=SC2086
  test::printVars ${!TEMP_CMD_BUILD_*}

  # declare common variables
  test::exec declareFinalCommandDefinitionCommonVariables "func" "cmd"

  # declare help variables
  test::exec declareFinalCommandDefinitionHelpVariables "func"

  # declare options and arguments for the parser
  test::exec declareFinalCommandDefinitionParserVariables "func"

  # shellcheck disable=SC2086
  test::printVars ${!CMD_*}

  # verify that the command definition is valid
  test::exec selfBuild_verifyCommandDefinition "func" "cmd"
  # test::printVars SELF_BUILD_ERRORS
}

function printVars() {
  local varName var
  for varName in "$@"; do
    local -n var="${varName}"
    printf "%s=%q\n" "${varName}" "${var[*]}"
  done
}

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

main
