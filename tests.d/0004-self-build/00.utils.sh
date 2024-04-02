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

function testCamelCaseToSnakeCase() {

  echo "→ camelCaseToSnakeCase thisIsATest0"
  camelCaseToSnakeCase thisIsATest0 && echo "${LAST_RETURNED_VALUE}"

  echo "→ camelCaseToSnakeCase AnotherTest"
  camelCaseToSnakeCase AnotherTest && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing camelCaseToSnakeCase" 0

}

function testKebabCaseToSnakeCase() {

  echo "→ kebabCaseToSnakeCase this-is-a-test0"
  kebabCaseToSnakeCase this-is-a-test0 && echo "${LAST_RETURNED_VALUE}"

  echo "→ kebabCaseToSnakeCase --another-test"
  kebabCaseToSnakeCase --another-test && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing kebabCaseToSnakeCase" 0

}

function testKebabCaseToCamelCase() {

  echo "→ kebabCaseToCamelCase this-is-a-test0"
  kebabCaseToCamelCase this-is-a-test0 && echo "${LAST_RETURNED_VALUE}"

  echo "→ kebabCaseToCamelCase --another-test"
  kebabCaseToCamelCase --another-test && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing kebabCaseToCamelCase" 0

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

  setLogLevelInt "debug"
  extractCommandDefinitionToVariables "${content}"

  declare -p ${!TEMP_CMD_BUILD_*}

  endTest "Testing extractCommandDefinitionToVariables" 0
}

function testTrimAll() {

  echo "→ trimAll '  a  super test  '"
  trimAll '  a  super test  ' && echo "${LAST_RETURNED_VALUE}"

  echo "→ trimAll 'this is a command  '"
  trimAll 'this is a command  ' && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing trimAll" 0

}

function main() {
  testExtractCommandYamls
  testKebabCaseToSnakeCase
  testKebabCaseToSnakeCase
  testKebabCaseToCamelCase
  testTrimAll

  testExtractCommandDefinitionToVariables
}
main
