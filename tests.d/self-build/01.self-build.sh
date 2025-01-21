#!/usr/bin/env bash

function main() {
  test::title "✅ Testing self-build script"

  export VALET_CONFIG_BUMP_VERSION_ON_BUILD=false

  if [[ ! -x "${GLOBAL_VALET_HOME}/commands.d/self-build.sh" ]]; then
    chmod +x "${GLOBAL_VALET_HOME}/commands.d/self-build.sh"
  fi

  test::exec "${GLOBAL_VALET_HOME}/commands.d/self-build.sh" --output "${GLOBAL_TEST_TEMP_FILE}" --core-only
}

main
