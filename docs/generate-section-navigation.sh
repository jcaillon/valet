#!/usr/bin/env bash

function main() {
  # list the directories in content/docs

  local directory
  local -a urls=() weights=() titles=()
  for directory in content/docs/*; do
    if [[ ! -d "${directory}" || ! -f "${directory}/_index.md" ]]; then
      continue
    fi

    echo "ℹ️  Checking ${directory}/_index.md"

    # read _index.md
    IFS='' read -rd '' REPLY <"${directory}/_index.md" || :

    # extract url/weight with a regex
    if [[ ${REPLY} =~ "url: "([^$'\n']+) ]]; then
      local url="${BASH_REMATCH[1]}"
      echo "    url: ${url}"
    else
      echo "    url: <not found>"
      exit 1
    fi
    if [[ ${REPLY} =~ "weight: "([^$'\n']+) ]]; then
      local weight="${BASH_REMATCH[1]}"
      echo "    weight: ${weight}"
    else
      echo "    weight: <not found>"
      exit 1
    fi
    if [[ ${REPLY} =~ "title: "([^$'\n']+) ]]; then
      local title="${BASH_REMATCH[1]}"
      echo "    title: ${title}"
    else
      echo "    title: <not found>"
      exit 1
    fi

    urls+=("../${url#"/docs/"}")
    weights+=("${weight}")
    titles+=("${title}")
  done

  : >"layouts/shortcodes/main-section-end.html"

  local -i index
  for ((index = 0; index < ${#urls[@]}; index++)); do
    local prevUrl prevTitle
    if ((index > 0)); then
      prevUrl="${urls[index - 1]}"
      prevTitle="${titles[index - 1]}"
    else
      prevUrl=""
      prevTitle=""
    fi
    local nextUrl nextTitle
    if ((index < ${#urls[@]} - 1)); then
      nextUrl="${urls[index + 1]}"
      nextTitle="${titles[index + 1]}"
    else
      nextUrl=""
      nextTitle=""
    fi
    echo "
{{ if eq .Page.Weight ${weights[index]} }}
{{- partial \"custom/sections-navigation.html\" (dict
\"prevLink\" \"${prevUrl}\"
\"prevTitle\" \"${prevTitle}\"
\"nextLink\" \"${nextUrl}\"
\"nextTitle\" \"${nextTitle}\"
) -}}
{{ end }}
    " >>"layouts/shortcodes/main-section-end.html"
  done
}

main
