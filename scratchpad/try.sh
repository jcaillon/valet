#!/usr/bin/env bash
source "$(valet --source)"

include system
system::getOs
log::success "You are running Valet on ${REPLY}, cool beans!"