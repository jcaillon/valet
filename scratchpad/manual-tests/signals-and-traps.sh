#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"

include bash

function trap::onCleanUp() {
  log::info "Cleaning up after tryout."
  false
}

function trap::onInterrupt() {
  log::warning "Tryout interrupted. Cleaning up..."
  return 0
}

function trap::onTerminate() {
  log::warning "Tryout terminated. Cleaning up..."
  return 0
}

function trap::onResize() {
  log::info "Terminal resized during tryout: ${GLOBAL_COLUMNS} columns, ${GLOBAL_LINES} lines."
}

function trap::onSuspend() {
  log::info "Terminal suspended during."
  return 0
}

function trap::onContinue() {
  log::info "Terminal continued after suspension."
}

trap::register trap::onCleanUp on-exit
trap::register trap::onInterrupt on-interrupt
trap::register trap::onTerminate on-terminate
trap::register trap::onResize on-resize
trap::register trap::onSuspend on-suspend
trap::register trap::onContinue on-continue

log::info "Trying CTRL+C, CTRL+Z then fg.."
bash::sleep 10
:
