#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-time
source time

function main() {
  test_time::isSpamming
  test_time::getMicrosecondsFromSeconds
  test_time::getSecondsFromMicroseconds
  test_time::startTimer
  test_time::getDate
  test_time::getHumanTimeFromMicroseconds
}

function test_time::isSpamming() {
  test::title "✅ Testing time::isSpamming function"

  test::setProgramElapsedFunction 0 increment=1000000 incrementIncrement=0

  test::exit time::isSpamming xxx

  test::func time::isSpamming 900us
  test::func time::isSpamming 1000000us
  test::func time::isSpamming 900000us
  test::func time::isSpamming 1100ms
  test::func time::isSpamming 900ms
  test::func time::isSpamming 2s
  test::func time::isSpamming 1s
  test::func time::isSpamming 2s timerName=xxx
  test::func time::isSpamming 2s timerName=xxx

  function test_time::isSpamming_sub() {
    if time::isSpamming 0s; then
      test::fail "time::isSpamming bad returned value"
    fi
  }
  function test_time::isSpamming_sub2() {
    if time::isSpamming 900ms timerName=myTimerName; then
      test::fail "time::isSpamming bad returned value"
    fi
  }
  test_time::isSpamming_sub
  test_time::isSpamming_sub2
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

  test::setProgramElapsedFunction 0 increment=1000000 incrementIncrement=0

  test::exit time::isTimerElapsed 2s
  test::exit time::getTimerMicroseconds
  test::exit time::isTimerElapsed 23

  test::func time::startTimer
  test::func time::logTimerElapsedTime
  test::func time::getTimerMicroseconds
  test::func time::logTimerElapsedTime format=%L
  test::func time::getTimerMicroseconds format=%L
  test::func time::isTimerElapsed 2s

  test::func time::startTimer timerName=myTimer
  test::func time::isTimerElapsed 2s timerName=myTimer
  test::func time::getTimerMicroseconds timerName=myTimer
  test::func time::logTimerElapsedTime timerName=myTimer format=%L
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
