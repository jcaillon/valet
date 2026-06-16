#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include yaml test

REPLY=""

yaml::parseFile tests.d/lib-yaml/resources/ok/arrays.yaml

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
