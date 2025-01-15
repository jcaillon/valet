#!/usr/bin/env bash

function main() {
  test::title "Testing lib-bash"
  test::commentTest "This is a comment"
  test::exec printf '%s' 'ergihezrghgeruh zefzfe'

  test::execExiting fuu
}

function fuu() {
  exit 2
}

main
