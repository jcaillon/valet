#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include yaml test time

log::setLevel debug silent=true

function parse() {
  # json
  local jsonLine jsonTempString jsonCumulatedLf="" isJsonQuoteOpen=0 jsonKeyName="" jsonPart jsonFullKey jsonLastString="" isJsonValueOpen=0 jsonCumulatedString="" jsonLastQuoteChar="" jsonValueTag
  local -a jsonKeyPaths=() jsonArrayIndexes=() jsonOpenChars=()
  local -i jsonDepth=-1

  local IFS errorPrefix="ERROR " noFail=false fullKey="@"
  local -i lineNumber=0
  while IFS=$'\n' read -rd $'\n' jsonLine || [[ -n ${jsonLine:-} ]]; do
    lineNumber+=1
    IFS='.'
    yaml_jsonHandleString
  done <"tests.d/lib-yaml/resources/ok-not-supported/test2.yaml"

  log::debug "jsonDepth: ${jsonDepth}, jsonKeyPaths: ${jsonKeyPaths[*]@Q}, jsonArrayIndexes: ${jsonArrayIndexes[*]@Q}, jsonOpenChars: ${jsonOpenChars[*]@Q}"
}

time::startTimer
parse
time::logTimerElapsedTime

keys=("${!REPLY_MAP[@]}")
include array
array::sort keys

REPLY="REPLY_MAP=("$'\n'
for key in "${keys[@]}"; do
  REPLY+="[\"${key}\"]='${REPLY_MAP[${key}]//\'/\'\"\'\"\'}'"$'\n'
done
REPLY+=")"$'\n'

echo "${REPLY}"
