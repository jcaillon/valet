#!/usr/bin/env bash

if [[ -o noglob ]]; then
  echo "noglob is set"
fi
if shopt -q dotglob; then
  echo "dotglob is set"
fi

function fu() {
  local -
  if ! shopt -q dotglob &>/dev/null; then
    trap 'shopt -u dotglob' RETURN
  fi

  set -o noglob
  if [[ -o noglob ]]; then
    echo "noglob is set inside function"
  fi
  shopt -s dotglob
  if shopt -q dotglob; then
    echo "dotglob is set inside function"
  fi
}

fu

if [[ -o noglob ]]; then
  echo "noglob is set"
fi

if shopt -q dotglob; then
  echo "dotglob is set"
fi

echo 'LESSONS LEARNED:

- we can use `local -` to make all chanegs with `set` local to a function
- this does not work for shopt, but we can use `trap` to reset the shopt options at the end of the function
'
