#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-time
source time

function main() {
  test_time::getMicrosecondsToSeconds
  test_time::startTimer
  test_time::getDate
  test_time::getMicrosecondsToHuman
}

function test_time::getMicrosecondsToSeconds() {
  test::title "✅ Testing time::getMicrosecondsToSeconds function"

  test::func time::getMicrosecondsToSeconds 1
  test::func time::getMicrosecondsToSeconds 1000 precision=3
  test::func time::getMicrosecondsToSeconds 1234567890
  test::func time::getMicrosecondsToSeconds 1234567890 precision=3
  test::func time::getMicrosecondsToSeconds 1234567890 precision=6
}

function test_time::startTimer() {
  test::title "✅ Testing time::startTimer function"

  test::exec time::startTimer
  test::func time::getTimerMicroseconds
  test::func time::getTimerMicroseconds logElapsedTime=true
  test::func time::getTimerMicroseconds format=%L logElapsedTime=true
}

function test_time::getDate() {
  test::title "✅ Testing time::getDate"

  test::func time::getDate
  test::func time::getDate format="'%(%H:%M:%S)T'"
}

function test_time::getMicrosecondsToHuman() {
  test::title "✅ Testing time::getMicrosecondsToHuman function"

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
  test::func time::getMicrosecondsToHuman ${ms} format="\"\${format}\""
  test::func time::getMicrosecondsToHuman ${ms}
  test::func time::getMicrosecondsToHuman ${ms} format='%U'
}

main