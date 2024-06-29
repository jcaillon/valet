#!/usr/bin/env bash

function testSelfBuild() {
  io::createTempFile && local tempFile="${RETURNED_VALUE}"

  (
    export VALET_CONFIG_BUMP_VERSION_ON_BUILD=false
    "${GLOBAL_VALET_HOME}/valet.d/commands.d/self-build.sh" --output "${tempFile}" --core-only

    local varName var
    for varName in ${!CMD_*}; do
      local -n var="${varName}"
      var="${var//[⌜⌝→]/}"
      echo "${varName}=${var[*]@K}"
    done
  )

  test::endTest "Testing selfbuild" 0
}

function main() {
  testSelfBuild
}

main
