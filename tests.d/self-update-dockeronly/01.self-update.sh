#!/usr/bin/env bash

# cancel the test suite if not running on windows
if ! command -v docker &>/dev/null; then
  test::skipTestSuite "This test suite is only runnable on systems with Docker installed, skipping it."
fi

function main() {
  test::title "✅ Testing valet update"

  chmod +x "${GLOBAL_INSTALLATION_DIRECTORY}/install.sh"
  docker run \
    --rm \
    -i \
    --entrypoint /usr/local/bin/bash-5.0 \
    --volume "${GLOBAL_INSTALLATION_DIRECTORY}/install.sh:/home/me/install.sh" \
    --volume "${GLOBAL_INSTALLATION_DIRECTORY}/commands.d/self-update.sh:/home/me/self-update.sh" \
    --volume "${PWD}/test-script:/home/me/test-script" \
    noyacode/valet-tests-slimdeb:latest \
    -c "source /home/me/test-script 2>&1"

  # shellcheck disable=SC2317
  function test::scrubOutput() {
    local version="${GLOBAL_TEST_OUTPUT_CONTENT##*"is ⌜"}"
    version="${version%%⌝*}"
    GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT//"${version}"/"X.Y.Z"}"
  }
  test::flush
}

main
