#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include yaml test

REPLY=""

log::setLevel debug silent=true

yaml::parseFile tests.d/lib-yaml/resources/ok-not-supported/test.yaml
# yaml::parseFile tests.d/lib-yaml/resources/ok/root-array.yaml
# yaml::parseFile tests.d/lib-yaml/resources/ok/any-indent.yaml

echo "${REPLY}"

keys=("${!REPLY_MAP[@]}")
include array
array::sort keys

REPLY="REPLY_MAP=("$'\n'
for key in "${keys[@]}"; do
  REPLY+="[\"${key}\"]='${REPLY_MAP[${key}]//\'/\'\"\'\"\'}'"$'\n'
done
REPLY+=")"$'\n'

echo "${REPLY}"
