#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark

function subFunction1b() {
  local \
    arg1="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    arg2="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    myOption="${_OPTION_MY_OPTION:-1}" \
    myOption2="${_OPTION_MY_OPTION2:-2}" \
    myOption3="${_OPTION_MY_OPTION3:-3}" \
    myOption4="${_OPTION_MY_OPTION4:-4}"
  shift 2
}

function func1b() {
  _OPTION_MY_OPTION=1 _OPTION_MY_OPTION3="my value" subFunction1b other arguments 1 2 3
}

function subFunction2a() {
  local \
    arg1="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    arg2="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    myOption="1" \
    myOption2="2" \
    myOption3="3" \
    myOption4="4"
  shift 2
  local IFS=$' '
  eval "local a= ${*@Q}"
}

function func2a() {
  subFunction2a other arguments myOption=1 myOption3="my value"
}

function subFunction2b() {
  local \
    arg1="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    arg2="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    myOption="1" \
    myOption2="2" \
    myOption3="3" \
    myOption4="4"
  shift 2
  local IFS=$' ' && eval "local a= ${*@Q}"
}

function func2b() {
  subFunction2b other arguments myOption=1 myOption3="my value"
}

function subFunction2c() {
  local \
    arg1="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    arg2="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    myOption="1" \
    myOption2="2" \
    myOption3="3" \
    myOption4="4"
  shift 2
  local IFS=$' '
  [[ $# -gt 0 ]] && eval "local ${*@Q}"
}

function func2c() {
  subFunction2c other arguments myOption=1 myOption3="my value"
}

function subFunction3a() {
  local \
    arg1="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    arg2="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    myOption="1" \
    myOption2="2" \
    myOption3="3" \
    myOption4="4"
  shift 2
  getToEval "${@}"
  eval "${REPLY}"
}

function func3a() {
  subFunction3a --other arguments 1 2 3 --- myOption=1 myOption3="my value"
}

function subFunction3b() {
  local \
    arg1="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    arg2="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    myOption="1" \
    myOption2="2" \
    myOption3="3" \
    myOption4="4"
  shift 2
  getToEval2 "${@}"
  eval "${REPLY}"
}

function func3b() {
  subFunction3b --other arguments 1 2 3 --- myOption=1 myOption3="my value"
}

function getToEval() {
  local IFS=$'\a'
  local options=$'\a'"${*}"$'\a'
  if [[ ${options} != *$'\a'---$'\a'* ]]; then
    REPLY=":"
    return 0
  fi
  options="${options##*$'\a'---$'\a'}"
  options="${options%$'\a'}"
  local -i remainingArgsLength=$((${#} - 2 - ${#options}))
  if ((${#options} == 0)); then
    REPLY="set -- \"\${@:1:$((remainingArgsLength + 1))}\""
    return 0
  fi
  REPLY="local '${options//$'\a'/"' '"}'; "
  options="${options//$'\a'/}"
  REPLY+="set -- \"\${@:1:$((remainingArgsLength + ${#options}))}\""
}

function getToEval2() {
  local param
  local -i nb=0
  for param; do
    if [[ ${param} == "---" ]]; then
      break
    fi
    nb+=1
  done
  if (( $# == nb )); then
    REPLY=":"
    return 0
  fi
  shift "$((nb + 1))"
  if (( $# == 0 )); then
    REPLY="set -- \"\${@:1:${nb}}\""
    return 0
  fi
  local IFS=$' '
  REPLY="local ${*@Q}; set -- \"\${@:1:${nb}}\""
}


benchmark::run func1b func2a func2b func2c func3a func3b

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func4         ░ 0.000s 024µs ░ N/A
# func3         ░ 0.000s 025µs ░ +5%
# func1         ░ 0.000s 025µs ░ +6%
# func2         ░ 0.000s 029µs ░ +22%
# func5         ░ 0.000s 032µs ░ +32%
