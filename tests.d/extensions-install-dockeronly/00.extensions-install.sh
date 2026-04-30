#!/usr/bin/env bash

# cancel the test suite if not running on windows
if ! command -v docker &>/dev/null; then
  test::skipTestSuite "This test suite is only runnable on systems with Docker installed, skipping it."
fi

function main() {
  test::title "✅ Testing extensions installation"

  docker run \
    --rm \
    -i \
    --entrypoint /usr/local/bin/bash-5.3 \
    --volume "${GLOBAL_INSTALLATION_DIRECTORY}:/home/me/valet" \
    --volume "${PWD}/test-script:/home/me/test-script" \
    noyacode/valet-tests-slimdeb:latest \
    -c "source /home/me/test-script 2>&1"

  test::flush
}

function test::scrubOutput() {
  GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT//Found [[:digit:]][[:digit:]][[:digit:]]/Found XXX}"
  GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT//Found [[:digit:]][[:digit:]]/Found XX}"
}

main
