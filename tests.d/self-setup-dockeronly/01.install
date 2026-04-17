#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-fs
source fs

# cancel the test suite if not running on windows
if ! command -v docker &>/dev/null; then
  test::skipTestSuite "This test suite is only runnable on systems with Docker installed, skipping it."
fi

function main() {
  test::title "✅ Testing valet installation"

  chmod +x "${GLOBAL_INSTALLATION_DIRECTORY}/install.sh"
  docker run \
    --rm \
    -i \
    --entrypoint /usr/local/bin/bash-5.0 \
    --volume "${GLOBAL_INSTALLATION_DIRECTORY}/install.sh:/home/me/install.sh" \
    --volume "${PWD}/test-script:/home/me/test-script" \
    noyacode/valet-tests-slimdeb:latest \
    -c "source /home/me/test-script 2>&1"

  test::flush
}

main
