#!/usr/bin/env bash
# convert .cast in this directory to .gifs

function main() {
  local file
  for file in *.cast; do
    agg -v --theme dracula --font-size 20 --speed 2 --renderer fontdue --font-family "JetBrains Mono,Consolas LNF,Fira Code" "${file}" "${file%.cast}.gif"
  done
}

main