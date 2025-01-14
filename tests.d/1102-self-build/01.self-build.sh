#!/usr/bin/env bash

function testSelfBuild() {
  io::createTempFile && local tempFile="${RETURNED_VALUE}"

  export VALET_CONFIG_BUMP_VERSION_ON_BUILD=false
  if [[ ! -x "${GLOBAL_VALET_HOME}/commands.d/self-build.sh" ]]; then
    chmod +x "${GLOBAL_VALET_HOME}/commands.d/self-build.sh"
  fi
  "${GLOBAL_VALET_HOME}/commands.d/self-build.sh" --output "${tempFile}" --core-only

  test::endTest "Testing self build" 0
}

function main() {
  testSelfBuild
}

main
