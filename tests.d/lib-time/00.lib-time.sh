#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-time
source time

function main() {
  test::setProgramElapsedFunction 0 increment=1000000 incrementIncrement=0

  test_time::isTimeElapsed
  test_time::getMicrosecondsFromSeconds
  test_time::getSecondsFromMicroseconds
  test_time::startTimer
  test_time::getDate
  test_time::getHumanTimeFromMicroseconds
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

function test_time::getMicrosecondsFromSeconds() {
  test::title "✅ Testing time::getMicrosecondsFromSeconds function"

  test::func time::getMicrosecondsFromSeconds 987
  test::func time::getMicrosecondsFromSeconds 1.5
  test::func time::getMicrosecondsFromSeconds 1.234567
  test::func time::getMicrosecondsFromSeconds 33.00405
  test::func time::getMicrosecondsFromSeconds 1234567890.123456
}

function test_time::getSecondsFromMicroseconds() {
  test::title "✅ Testing time::getSecondsFromMicroseconds function"

  test::func time::getSecondsFromMicroseconds 1
  test::func time::getSecondsFromMicroseconds 1000 precision=3
  test::func time::getSecondsFromMicroseconds 1234567890
  test::func time::getSecondsFromMicroseconds 1234567890 precision=3
  test::func time::getSecondsFromMicroseconds 1234567890 precision=6
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

function test_time::getHumanTimeFromMicroseconds() {
  test::title "✅ Testing time::getHumanTimeFromMicroseconds function"

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
  test::func time::getHumanTimeFromMicroseconds ${ms} format="\"\${format}\""
  test::func time::getHumanTimeFromMicroseconds ${ms}
  test::func time::getHumanTimeFromMicroseconds ${ms} format='%U'
}

main