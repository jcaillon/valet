#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-progress
source progress

function main() {
  test_progress_getProgressBarString
}

function test_progress_getProgressBarString() {
  test::title "✅ Testing progress_getProgressBarString"

  test::func progress_getProgressBarString 0 1
  test::func progress_getProgressBarString 10 1
  test::func progress_getProgressBarString 50 1
  test::func progress_getProgressBarString 90 1
  test::func progress_getProgressBarString 100 1
  test::func progress_getProgressBarString 22 10
  test::func progress_getProgressBarString 50 15
  test::func progress_getProgressBarString 83 30
}

main
