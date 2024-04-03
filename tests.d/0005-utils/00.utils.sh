#!/usr/bin/env bash

# shellcheck source=../../valet.d/utils
source "${VALET_HOME}/valet.d/utils"

function testBumpSemanticVersion() {

  echo "→ bumping 0.0.0 minor"
  bumpSemanticVersion "0.0.0" "minor" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 major"
  bumpSemanticVersion "1.2.3-alpha+zae345" "major" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 minor"
  bumpSemanticVersion "1.2.3-alpha+zae345" "minor" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 patch"
  bumpSemanticVersion "1.2.3-alpha+zae345" "patch" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha+zae345 major false"
  bumpSemanticVersion "1.2.3-alpha+zae345" "major" "false" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ bumping 1.2.3-alpha patch false"
  bumpSemanticVersion "1.2.156-alpha" "patch" "false" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing bumpSemanticVersion" 0
}

function testCamelCaseToSnakeCase() {

  echo "→ camelCaseToSnakeCase thisIsATest0"
  camelCaseToSnakeCase thisIsATest0 && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ camelCaseToSnakeCase AnotherTest"
  camelCaseToSnakeCase AnotherTest && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing camelCaseToSnakeCase" 0

}

function testKebabCaseToSnakeCase() {

  echo "→ kebabCaseToSnakeCase this-is-a-test0"
  kebabCaseToSnakeCase this-is-a-test0 && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ kebabCaseToSnakeCase --another-test"
  kebabCaseToSnakeCase --another-test && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing kebabCaseToSnakeCase" 0

}

function testKebabCaseToCamelCase() {

  echo "→ kebabCaseToCamelCase this-is-a-test0"
  kebabCaseToCamelCase this-is-a-test0 && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ kebabCaseToCamelCase --another-test"
  kebabCaseToCamelCase --another-test && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing kebabCaseToCamelCase" 0

}

function testTrimAll() {

  echo "→ trimAll '  a  super test  '"
  trimAll '  a  super test  ' && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ trimAll 'this is a command  '"
  trimAll 'this is a command  ' && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing trimAll" 0

}

function testToAbsolutePath() {

  echo "→ toAbsolutePath \${PWD}/00.utils.sh"
  toAbsolutePath "${PWD}/00.utils.sh" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ toAbsolutePath 00.utils.sh"
  toAbsolutePath "00.utils.sh" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ toAbsolutePath ./00.utils.sh"
  toAbsolutePath "./00.utils.sh" && echo "${LAST_RETURNED_VALUE}"

  echo
  echo "→ toAbsolutePath ../0003-self/00.utils.sh"
  toAbsolutePath "../0003-self/00.utils.sh" && echo "${LAST_RETURNED_VALUE}"

  endTest "Testing toAbsolutePath" 0

}

function testSortArray() {

  declare -g MYARRAY=(
    breakdown
    constitutional
    conventional
    baby
    holiday
    abundant
    deliver
    position
    economics
  )
  declare -p MYARRAY

  echo "→ sortArray MYARRAY"
  sortArray MYARRAY

  declare -p MYARRAY

  endTest "Testing sortArray" 0
}

function testAppendToArrayIfNotPresent() {

  declare -g MYARRAY=(
    breakdown
    constitutional
  )
  declare -p MYARRAY

  echo "→ appendToArrayIfNotPresent MYARRAY 'deliver'"
  appendToArrayIfNotPresent MYARRAY 'deliver'

  declare -p MYARRAY

  echo
  echo "→ appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday'"
  appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday'

  declare -p MYARRAY

  echo
  echo "→ appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday' 'economics'"
  appendToArrayIfNotPresent MYARRAY 'deliver' 'holiday' 'economics'

  declare -p MYARRAY

  endTest "Testing appendToArrayIfNotPresent" 0
}

function testIsInArray() {

  declare -g MYARRAY=(
    breakdown
    constitutional
    deliver
    position
    economics
  )
  declare -p MYARRAY

  echo "→ isInArray MYARRAY 'deliver'"
  isInArray MYARRAY 'deliver' && echo "$?"

  echo
  echo "→ isInArray MYARRAY 'holiday'"
  isInArray MYARRAY 'holiday' || echo "$?"

  endTest "Testing isInArray" 0
}

function main() {
  testBumpSemanticVersion
  testKebabCaseToSnakeCase
  testKebabCaseToSnakeCase
  testKebabCaseToCamelCase
  testTrimAll
  testToAbsolutePath
  testSortArray
  testAppendToArrayIfNotPresent
  testIsInArray
}

main