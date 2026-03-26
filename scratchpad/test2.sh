#!/usr/bin/env bash

if [[ -o noglob ]]; then
  echo "noglob is set"
fi

if shopt -q dotglob; then
  echo "dotglob is set"
fi

function fu() {
  local -
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
