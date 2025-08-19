#!/usr/bin/env bash
# convert .cast in this directory to .gifs

function main() {
  local file
  for file in *.cast; do
    if [[ -f ${file%.cast}.gif ]]; then
      echo "The git file ⌜${file%.cast}.gif⌝ already exists, skipping."
      continue
    fi
    agg -v --theme dracula --font-size 20 --speed 1 --renderer fontdue --font-family "JetBrains Mono,Consolas LNF,Fira Code" "${file}" "${file%.cast}.gif"
  done
}

main