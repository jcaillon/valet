#!/usr/bin/env bash

# shellcheck source=../../valet.d/commands.d/utils
source "${VALET_HOME}/valet.d/commands.d/utils"

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


function main() {
  testBumpSemanticVersion
}

main