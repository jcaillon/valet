#!/usr/bin/env bash
# shellcheck disable=SC1091
export VALET_CONFIG_WARNING_ON_UNEXPECTED_EXIT=false
export VALET_CONFIG_LOG_PATTERN="<colorFaded>[<processName>{04s}:pid>{04s}:<subshell>{1s}](<pid>{05d}) <colorFaded>line <line>{-4s}<colorDefault> <levelColor><level>{-4s} <colorDefault> <message>"
export VALET_LOG_LEVEL="debug"

# shellcheck disable=SC1090
source "$(valet --source)"
include curl http fs

log::info "Downloading a file to a specific path:"
curl::download https://api.ip2location.io/ --- path=tmp/output.json
fs::cat tmp/output.json

log::info "Downloading a file to a temp file:"
curl::download https://api.ip2location.io/ -H "header: value" --- failOnError=true acceptableCodes=200,201
fs::cat "${REPLY}"

log::info "Request github API"
curl::request "https://api.github.com/repos/jcaillon/valet/releases/latest" -H "Accept: application/vnd.github.v3+json" --- acceptableCodes=200
echo "${REPLY}"

log::info "Testing http::request with a GET request:"
# shellcheck disable=SC2034
VALET_CONFIG_ENABLE_INSECURE_WEB_REQUESTS=true
log::setLevel trace
http::request GET http://httpbin.org/get
echo "Returns HTTP code was ${REPLY3}, response:"$'\n'"${REPLY2}"$'\n'"${REPLY}"