#!/usr/bin/env bash
# shellcheck disable=SC2034
GLOBAL_EXPECTED_EXIT=true
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include yaml

yaml::parseFile "${GLOBAL_INSTALLATION_DIRECTORY}/tests.d/lib-yaml/resources/ok/full.yaml"

keys=("${!REPLY_MAP[@]}")
include array
array::sort keys

REPLY="REPLY_MAP=("$'\n'
for key in "${keys[@]}"; do
  REPLY+="[\"${key}\"]='${REPLY_MAP[${key}]//\'/\'\"\'\"\'}'"$'\n'
done
REPLY+=")"$'\n'

keys=("${!REPLY_MAP2[@]}")
include array
array::sort keys

REPLY+="REPLY_MAP2=("$'\n'
for key in "${keys[@]}"; do
  REPLY+="[\"${key}\"]='${REPLY_MAP2[${key}]//\'/\'\"\'\"\'}'"$'\n'
done
REPLY+=")"$'\n'

echo "${REPLY}"

echo "==========="

yaml::writeString REPLY_MAP REPLY_MAP2
echo "${REPLY}"
