#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
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

VALET_CONFIG_LOG_PATTERN="<colorFaded><time>{(%H:%M:%S)T} (+<elapsedTimeSinceLastLog>{7s}) [<pid>{05d}:<subshell>{1s}] <levelColor><level><colorDefault> <colorFaded><sourceFile>{10s}:<line>{-4s}<colorDefault> -- <message>"
VALET_CONFIG_LOG_PATTERN="<colorFaded>╭─<time>{(%H:%M:%S)T}──<levelColor><level>{7s}<colorFaded>────────<sourceFile>{10s}:<line>{-4s}───░<colorDefault>"$'\n'"<colorFaded>│<colorDefault>  <message>"$'\n'"<colorFaded>╰─ +<elapsedTimeSinceLastLog>{7s}──────────────────────────────────░<colorDefault>"$'\n'
VALET_CONFIG_LOG_PATTERN="<colorFaded><elapsedTime>{8s} (+<elapsedTimeSinceLastLog>{7s}) [<pid>{05d}:<subshell>{1s}] <levelColor><level>{7s}<colorDefault> <colorFaded><sourceFile>{10s}:<line>{-4s}<colorDefault> <message>"

log::init

log::errorTrace "This is an error trace message which is always displayed."
log::trace "This is a trace message."
log::debug "This is a debug message."
log::info "This is an info message with a super long sentence. The value of life is not in its duration, but in its donation. You are not important because of how long you live, you are important because of how effective you live. Give a man a fish and you feed him for a day; ⌜teach a man⌝ to fish and you feed him for a lifetime. Surround yourself with the best people you can find, delegate authority, and don't interfere as long as the policy you've decided upon is being carried out."
log::success "This is a success message."
log::warning "This is a warning message."$'\n'"With a second line."

sleep 1
log::info coucou

core::dump