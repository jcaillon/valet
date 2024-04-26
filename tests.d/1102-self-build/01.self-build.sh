#!/usr/bin/env bash

function testSelfBuild() {
  setTempFilesNumber 500
  io::createTempFile && local tempFile="${RETURNED_VALUE}"

  (
    "${GLOBAL_VALET_HOME}/valet.d/commands.d/self-build.sh" --output "${tempFile}" --user-directory ""

    local varName var
    for varName in ${!CMD_*}; do
      local -n var="${varName}"
      var="${var//[⌜⌝→]/}"
      echo "${varName}=${var@Q}"
    done
  )

  endTest "Testing selfbuild" 0
}

function main() {
  testSelfBuild
}

main
