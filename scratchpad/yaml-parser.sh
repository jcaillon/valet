#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include yaml test

log::setLevel debug silent=true

time::startTimer
yaml::parseFile tests.d/lib-yaml/resources/ok-not-supported/test.yaml
time::logTimerElapsedTime

# yaml::parseFile tests.d/lib-yaml/resources/ok/root-array.yaml
# yaml::parseFile tests.d/lib-yaml/resources/ok/any-indent.yaml

echo "${REPLY}"

keys=("${!REPLY_MAP[@]}")
include array
array::sort keys

REPLY="REPLY_MAP=("$'\n'
for key in "${keys[@]}"; do
  printf -v QUOTED '%q' "${REPLY_MAP[${key}]}"
  REPLY+="[\"${key}\"]=${QUOTED}"$'\n'
done
REPLY+=")"$'\n'

echo "${REPLY}"

keys=("${!REPLY_MAP2[@]}")
include array
array::sort keys

REPLY="REPLY_MAP2=("$'\n'
for key in "${keys[@]}"; do
  printf -v QUOTED '%q' "${REPLY_MAP2[${key}]}"
  REPLY+="[\"${key}\"]=${QUOTED}"$'\n'
done
REPLY+=")"$'\n'

echo "${REPLY}"
