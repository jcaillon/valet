#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-time
source time

function main() {
  test_time::startTimer
  test_time::getDate
  test_time::convertMicrosecondsToHuman
}

function test_time::startTimer() {
  test::title "✅ Testing time::startTimer function"

  test::exec time::startTimer
  test::func time::getTimerMicroseconds
  test::func _OPTION_LOG_ELAPSED_TIME=true time::getTimerMicroseconds
  test::func _OPTION_LOG_ELAPSED_TIME=true _OPTION_FORMAT=%L time::getTimerMicroseconds
}

function test_time::getDate() {
  test::title "✅ Testing time::getDate"

  test::func time::getDate
  test::func time::getDate "'%(%H:%M:%S)T'"
}

function test_time::convertMicrosecondsToHuman() {
  test::title "✅ Testing time::convertMicrosecondsToHuman function"

  local -i ms=$((234 + 1000 * 2 + 1000000 * 3 + 1000000 * 60 * 4 + 1000000 * 60 * 60 * 5))
  local format="Hours: %HH
Minutes: %MM
Seconds: %SS
Milliseconds: %LL
Microseconds: %UU

Hours: %h
Minutes: %m
Seconds: %s
Milliseconds: %l
Microseconds: %u

Total minutes: %M
Total seconds: %S
Total milliseconds: %L
Total microseconds: %U"
  test::printVars format
  test::func time::convertMicrosecondsToHuman ${ms} "\"\${format}\""
  test::func time::convertMicrosecondsToHuman ${ms}
  test::func _OPTION_FORMAT='%U' time::convertMicrosecondsToHuman ${ms}
}

main