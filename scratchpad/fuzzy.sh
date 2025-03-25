#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
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

