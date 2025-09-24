#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-time
source time

function main() {
  test::setProgramElapsedFunction 0 increment=1000000 incrementIncrement=0

  test_time::isTimeElapsed
  test_time::getSecondsToMicroseconds
  test_time::getMicrosecondsToSeconds
  test_time::startTimer
  test_time::getDate
  test_time::getMicrosecondsToHuman
}

function test_time::isTimeElapsed() {
  test::title "✅ Testing time::isTimeElapsed function"

  test::func time::isTimeElapsed 1900000
  test::func time::isTimeElapsed 1900000
  test::func time::isTimeElapsed 1900000

  test::title "✅ Testing time::isTimeElapsed called from a different function"
  if time::isTimeElapsed 1900000; then
    test::fail "time::isTimeElapsed should have returned false"
  fi
  if time::isTimeElapsed 1900000; then
    test::fail "time::isTimeElapsed should have returned false"
  fi
  function test_time::isTimeElapsed_sub() {
    if time::isTimeElapsed 1900000; then
      test::fail "time::isTimeElapsed should have returned false"
    fi
  }
  test_time::isTimeElapsed_sub
  if ! time::isTimeElapsed 1900000; then
    test::fail "time::isTimeElapsed should have returned true"
  fi

  test::title "✅ Testing time::isTimeElapsed using timerName"
  if time::isTimeElapsed 1900000 timerName=myTimerName; then
    test::fail "time::isTimeElapsed should have returned false"
  fi
  if time::isTimeElapsed 1900000 timerName=myTimerName; then
    test::fail "time::isTimeElapsed should have returned false"
  fi
  function test_time::isTimeElapsed_sub2() {
    if ! time::isTimeElapsed 1900000 timerName=myTimerName; then
      test::fail "time::isTimeElapsed should have returned true"
    fi
  }
  test_time::isTimeElapsed_sub2
}

function test_time::getSecondsToMicroseconds() {
  test::title "✅ Testing time::getSecondsToMicroseconds function"

  test::func time::getSecondsToMicroseconds 987
  test::func time::getSecondsToMicroseconds 1.5
  test::func time::getSecondsToMicroseconds 1.234567
  test::func time::getSecondsToMicroseconds 33.00405
  test::func time::getSecondsToMicroseconds 1234567890.123456
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