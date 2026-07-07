#!/usr/bin/env bash
# shellcheck disable=SC2317
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark

LONG_STRING="Paste data in either format and get a validated, properly formatted output in the other. The tool handles complex nested structures, arrays, multi-line strings, comments (in YAML), and special data types. Convert a Kubernetes manifest from YAML to JSON, turn a Docker Compose file into JSON for a script, or rewrite a GitHub Actions workflow from JSON back to YAML. It also helps when converting an OpenAPI or Swagger spec between formats, fixing YAML indentation errors, or pasting a config to validate its structure. Everything runs in your browser - your configuration data stays private. "
STRING="${LONG_STRING}${LONG_STRING}${LONG_STRING}${LONG_STRING}${LONG_STRING}"

# ================================================
echo "split a condition in string/arithmetic context vs only string context"
# ================================================
function test1() {
  if [[ ${STRING} == *[^[:space:]]* && ${#STRING} -gt 10 ]]; then
    :
  fi
}

function test2() {
  if [[ ${STRING} == *[^[:space:]]* ]] && ((${#STRING} > 10)); then
    :
  fi
}

benchmark::run test1 test2
# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test2         ░ 0.000s 015µs ░ N/A
# test1         ░ 0.000s 015µs ░ +3%

# LESSON : almost equivalent, but best put all conditions in a single [[ ... ]] test

# ================================================
echo "check if the string contains at least one non-whitespace character"
# ================================================
function test1() {
  if [[ -n ${STRING//[\t ]/} ]]; then
    :
  fi
}

function test2() {
  if [[ ${STRING} == *[^[:space:]]* ]]; then
    :
  fi
}

benchmark::run test1 test2
# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test2         ░ 0.000s 013µs ░ N/A
# test1         ░ 0.000s 907µs ░ +6773%

# LESSON : it is DRAMATICALLY faster to check for a non-empty string by using a glob pattern than to use parameter expansion to remove whitespace and check for a non-empty string

# ================================================
echo "check for non empty string"
# ================================================
function test1() {
  if ((${#STRING} > 0)); then
    :
  fi
}

function test2() {
  if [[ ${#STRING} -gt 0 ]]; then
    :
  fi
}

function test3() {
  if [[ -n ${STRING} ]]; then
    :
  fi
}

benchmark::run test1 test2 test3
# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test1         ░ 0.000s 008µs ░ N/A
# test2         ░ 0.000s 008µs ░ +3%
# test3         ░ 0.000s 010µs ░ +27%

STRING="Paste"
benchmark::run test1 test2 test3
# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test3         ░ 0.000s 006µs ░ N/A
# test1         ░ 0.000s 007µs ░ +3%
# test2         ░ 0.000s 007µs ░ +6%#

# LESSON : testing the length of a string is the best option. For very short strings, -n is slightly faster, but for longer strings, the length check is significantly faster.

# ================================================
echo "check for a string starting with a specific prefix"
# ================================================
function test1() {
  if [[ ${STRING} == '- '* ]]; then
    :
  fi
}

function test2() {
  if [[ ${STRING:0:2} == '- ' ]]; then
    :
  fi
}

function test3() {
  if [[ ${STRING} =~ ^'- ' ]]; then
    :
  fi
}

benchmark::run test1 test2 test3
# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test1         ░ 0.000s 007µs ░ N/A
# test2         ░ 0.000s 008µs ░ +9%
# test3         ░ 0.000s 009µs ░ +15%

STRING="${LONG_STRING}${LONG_STRING}${LONG_STRING}${LONG_STRING}${LONG_STRING}"
benchmark::run test1 test2 test3
# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# test2         ░ 0.000s 011µs ░ N/A
# test1         ░ 0.000s 016µs ░ +39%
# test3         ░ 0.000s 198µs ░ +1605%

## LESSON : it is best to substring and test only for few characters (also for small strings it is slightly faster to use the glob pattern than to use substring extraction) ; regex is the slowest of the three methods (even more slow as the string gets longer)
