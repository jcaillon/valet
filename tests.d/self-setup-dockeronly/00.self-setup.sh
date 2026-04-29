#!/usr/bin/env bash

# cancel the test suite if not running on windows
if ! command -v docker &>/dev/null; then
  test::skipTestSuite "This test suite is only runnable on systems with Docker installed, skipping it."
fi

function main() {
  test::title "✅ Testing valet installation"

  docker run \
    --rm \
    -i \
    --entrypoint /usr/local/bin/bash-5.0 \
    --volume "${GLOBAL_INSTALLATION_DIRECTORY}:/home/me/valet" \
    --volume "${PWD}/test-script:/home/me/test-script" \
    noyacode/valet-tests-slimdeb:latest \
    -c "source /home/me/test-script 2>&1"

  test::flush

  test::title "✅ Testing valet installation with root permission"

  docker run \
    --rm \
    -i \
    --user root \
    --entrypoint /usr/local/bin/bash-5.3 \
    --volume "${GLOBAL_INSTALLATION_DIRECTORY}:/opt/valet" \
    --volume "${PWD}/test-script-root:/root/test-script-root" \
    noyacode/valet-tests-slimdeb:latest \
    -c "source /root/test-script-root 2>&1"

  test::flush
}

main
