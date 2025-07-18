#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test::title "✅ Testing self-build script"

  export VALET_CONFIG_BUMP_VERSION_ON_BUILD=false

  if [[ ! -x "${GLOBAL_INSTALLATION_DIRECTORY}/commands.d/self-build.sh" ]]; then
    chmod +x "${GLOBAL_INSTALLATION_DIRECTORY}/commands.d/self-build.sh"
  fi

  fs::createTempDirectory
  test::exec "${GLOBAL_INSTALLATION_DIRECTORY}/commands.d/self-build.sh" --output "${REPLY}" --core-only
}

main
