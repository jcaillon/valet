#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include benchmark progress bash
# core::dump


include exe string

function fu() {
  fs::readFile "./tmp/${2}"
  local ca="${RETURNED_VALUE}"
  exe::invoke5 true 0 true /dev/null openssl s_client -showcerts -connect "${1}":443
  local _out="${RETURNED_VALUE}"
  string::extractBetween _out "-----BEGIN CERTIFICATE-----" "-----END CERTIFICATE-----"
  echo "-----BEGIN CERTIFICATE-----""${RETURNED_VALUE}""-----END CERTIFICATE-----"$'\n'"${ca}" > ./tmp/${1%%'.'*}.pem
}

fu FF7C52F164E54E2A0AB3C82C1836CDA3.yl4.eu-west-3.eks.amazonaws.com oz-pprod-a1.crt
fu 39E3E7776D751853D818BBD74BE2BB20.gr7.eu-central-1.eks.amazonaws.com p2.crt
fu 571DC18BA5EEC503B9D79585D8579F86.gr7.eu-west-3.eks.amazonaws.com sandbox-a1.crt
fu D3C340A8E39B1150377A683EAB052B4B.gr7.eu-west-3.eks.amazonaws.com prod-a1.crt
fu 0A829FD3D7524A80836D321EEF5CCC2D.gr7.eu-west-3.eks.amazonaws.com qualif-a1.crt
fu E4A213424487AC1C46898B2DE0B92E62.yl4.eu-west-3.eks.amazonaws.com pprod-a1.crt
fu 11211E228C4FCAA0642BD1213F88868B.yl4.eu-west-3.eks.amazonaws.com oz-prod-a1.crt
fu FBADBA89B3251E5C6CEE78F442CF2412.gr7.eu-central-1.eks.amazonaws.com oz2.crt

exit 0


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

VALET_CONFIG_LOG_PATTERN="<colorFaded><time>{(%H:%M:%S)T} (+<elapsedTimeSinceLastLog>{7s}) [<pid>{05s}:<subshell>{1s}] <levelColor><level><colorDefault> <colorFaded><sourceFile>{10s}:<line>{-4s}<colorDefault> -- <message>"
VALET_CONFIG_LOG_PATTERN="<colorFaded>╭─<time>{(%H:%M:%S)T}──<levelColor><level>{7s}<colorFaded>────────<sourceFile>{10s}:<line>{-4s}───░<colorDefault>"$'\n'"<colorFaded>│<colorDefault>  <message>"$'\n'"<colorFaded>╰─ +<elapsedTimeSinceLastLog>{7s}──────────────────────────────────░<colorDefault>"$'\n'
VALET_CONFIG_LOG_PATTERN="<colorFaded><elapsedTime>{8s} (+<elapsedTimeSinceLastLog>{7s}) [<pid>{05s}:<subshell>{1s}] <levelColor><level>{7s}<colorDefault> <colorFaded><sourceFile>{10s}:<line>{-4s}<colorDefault> <message>"

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