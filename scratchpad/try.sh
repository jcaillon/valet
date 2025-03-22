#!/usr/bin/env bash
# shellcheck disable=SC1091
source "libraries.d/core"
include benchmark progress bash

function func1() {
  func2
}

function func2() {
  func3
}

function func3() {
  echo "ok"
  log::getCallStack
  echo "${RETURNED_VALUE}"
  log::info stack:
  log::printCallStack
}

func1