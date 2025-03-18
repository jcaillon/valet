#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark progress bash

bash::getScriptDirectory
echo "Script directory: ${RETURNED_VALUE}"

pushd /c/Users/jcaillon/data/repo/innersource/sres/sres-cloud/enablers/yg

(source extension.setup.sh)

popd

exit 0

function func1() {
  cd libraries.d &>/dev/null
  cd - &>/dev/null
}
function func2() {
  pushd libraries.d &>/dev/null
  popd &>/dev/null
}

benchmark::run func1 func2

progress::start
progress::update 0 "Running test suites."

JOB_NAMES=(name{1..30})
JOB_COMMANDS=()
for i in {1..30}; do
  JOB_COMMANDS+=("sleep $((RANDOM % 3 + 1)); log::warning 'Job $i done'")
done

function callback() {
  progress::update ${4} "Done running ⌜${2}⌝ at index ${1}: ${3}."
  if [[ ${3} -eq 1 ]]; then
    return 1
  fi
}

bash::runInParallel JOB_NAMES JOB_COMMANDS 5 callback

progress::stop

