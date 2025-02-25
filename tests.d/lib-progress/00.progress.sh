#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-progress
source progress

function main() {
  test_progress_getStringToDisplay
  test_progress_getProgressBarString
}

function test_progress_getStringToDisplay() {
  test::title "✅ Testing progress_getStringToDisplay"

  test::func GLOBAL_COLUMNS=10 progress_getStringToDisplay "'░<bar>░'" 10 50 "Message"
  test::func GLOBAL_COLUMNS=10 progress_getStringToDisplay "'<spinner> <percent> ░<bar>░'" 10 0 "Message"
  test::func GLOBAL_COLUMNS=0 progress_getStringToDisplay "'<spinner> <percent> ░<bar>░'" 0 0 ""
  test::func GLOBAL_COLUMNS=20 progress_getStringToDisplay "'<spinner> <percent> ░<bar>░ <message>'" 9 0 "Message"
  test::func GLOBAL_COLUMNS=24 progress_getStringToDisplay "'<spinner> <percent> ░<bar>░ <message>'" 10 0 "Message"
  test::func GLOBAL_COLUMNS=29 progress_getStringToDisplay "'<spinner> <percent> ░<bar>░ <message>'" 10 0 "Message"
  test::func GLOBAL_COLUMNS=35 progress_getStringToDisplay "'<spinner> <percent> ░<bar>░ <message>'" 10 0 "Message"
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