#!/usr/bin/env bash

function func1() {
  trap 'echo trap from func1' RETURN
  func3
}
function func2() {
  trap 'echo trap from func2' RETURN
  (func3)
  return 1
}
function func3() {
  return 1
}

trap 'echo trap from main' RETURN

func1
func2 || true
func3

echo '-----------'

set -o functrace

func1
func2 || true
trap 'echo trap from main' RETURN
func3

echo 'LESSONS LEARNED:

- by default (set +o functrace), RETURN traps are "local" to a function
- with set -o functrace, RETURN traps are global (apply to all functions) and are inherited in subshells

'
