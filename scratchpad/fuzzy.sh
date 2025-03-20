#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include progress interactive

function main() {
  local fuzzy
  local _STRING_FUZZY_FILTER_REGEX
  fuzzy=a+bc\\

  regex::getFuzzySearchRegexFromSearchString fuzzy
  echo "${fuzzy} -> ${_STRING_FUZZY_FILTER_REGEX}"

  echo "----"
}

main

