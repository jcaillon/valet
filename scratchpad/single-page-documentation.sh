#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"

include terminal fs string regex

OUTPUT="${GLOBAL_INSTALLATION_DIRECTORY}/tmp/doc.md"

: > "${OUTPUT}"

function main() {
  fs::listDirectories "${GLOBAL_INSTALLATION_DIRECTORY}/docs/content/docs"
  local directory
  for directory in "${REPLY_ARRAY[@]}"; do
    fs::readFile "${directory}/_index.md"
    local content="${REPLY}"

    string::extractBetween content --- ---
    local frontMatter="${REPLY}"

    regex::getFirstGroup frontMatter "title: ([^"$'\n'"]*)"
    local title="${REPLY}"
    log::info "title: ${title}"

    content="${content:${#frontMatter} + 8}"

    local line modifiedContent=""
    while [[ -n ${content} ]]; do
      line="${content%%$'\n'*}"
      content="${content:${#line}+1}"

      # ignore links
      if [[ ${line} =~ ^"["[^\]]+"]: "[^" "]+$ ]]; then
        continue
      fi
      # transform headings
      line="${line//"## "/"### "}"
      # remove links
      regex::replace line '\[([^]]+)\]\([^)]+\)' "\1"
      line="${REPLY}"

      modifiedContent+="${line}"$'\n'
    done

    printf "%s\n\n%s\n" "## ${title}" "${modifiedContent}" >> "${OUTPUT}"
  done
}

main
