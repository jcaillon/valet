#!/usr/bin/env bash
# shellcheck source=../libraries.d/main
source "$(valet --source)"
include benchmark

# testing the -k option
set -k
function test() {
  echo "${myOption}"
  echo "${myOption3}"
  echo "${1}"
  echo "${2}"
  local fu="${1}"
  echo "${fu-"The problem is that -k applies to all commands, not just function calls"}"
}
test fu myOption=one myOption3="my value" fu2
echo "${myOption-my option not set in the global scope}"
set +k
echo "===="

# the vanilla way
function subFunction1() {
  local \
    arg1="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    arg2="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    myOption="${_OPTION_MY_OPTION:-1}" \
    myOption2="${_OPTION_MY_OPTION2:-2}" \
    myOption3="${_OPTION_MY_OPTION3:-3}" \
    myOption4="${_OPTION_MY_OPTION4:-4}"
  shift 2

  echo "myOption: '${myOption}', myOption2: '${myOption2}', myOption3: '${myOption3}', myOption4: '${myOption4}', arg1: '${arg1}', arg2: '${arg2}', remaining arguments: '${*}'"
}

echo "Vanilla way:"
_OPTION_MY_OPTION=one _OPTION_MY_OPTION3="my value" subFunction1 other arguments 1 2 3
echo "===="

# test CLI like parameters
function subFunction2() {
  local \
    myOption="1" \
    myOption2="2" \
    myOption3="3" \
    myOption4="4"
  local IFS=$'\a'
  : $'\a'"${*}"$'\a'
  : "${_%%--$'\a'*}"
  : "${_//$'\a'--/"' '"}'"
  eval "local ${_:2}"
  while [[ ${1:-} == "--"* ]]; do
    shift 1
    if [[ ${1:-} == "--" ]]; then
      shift 1
      break
    fi
  done
  local \
    arg1="${1}" \
    arg2="${2}"
  shift 2
  IFS=$' '

  echo "myOption: '${myOption}', myOption2: '${myOption2}', myOption3: '${myOption3}', myOption4: '${myOption4}', arg1: '${arg1}', arg2: '${arg2}', remaining arguments: '${*}'"
}

echo "CLI like parameters:"
subFunction2 --myOption=one --myOption3="my value" -- other arguments 1 2 3
echo "===="

# test with shell parameters syntax
function subFunction3() {
  local \
    arg1="${1}" \
    arg2="${2}" \
    myOption="1" \
    myOption2="2" \
    myOption3="3" \
    myOption4="4"
  shift 2
  local IFS=$' '
  eval "local a= ${*@Q}"

  echo "myOption: '${myOption}', myOption2: '${myOption2}', myOption3: '${myOption3}', myOption4: '${myOption4}', arg1: '${arg1}', arg2: '${arg2}', remaining arguments: '${*}'"
}

echo "Shell parameters syntax (simple):"
subFunction3 other arguments myOption=one myOption3="my value"
echo "===="

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
  if (($# == nb)); then
    # no separators, only arguments
    REPLY=":"
    return 0
  elif (($# == 0)); then
    # a separator but no options after it
    REPLY="set -- \"\${@:1:${nb}}\""
    return 0
  fi
  shift "$((nb + 1))"
  local IFS=$' '
  REPLY="local ${*@Q}; set -- \"\${@:1:${nb}}\""
}

function subFunction4() {
  local \
    arg1="${1}" \
    arg2="${2}" \
    myOption="1" \
    myOption2="2" \
    myOption3="3" \
    myOption4="4"
  shift 2
  getToEval "${@}"
  echo "${REPLY}"
  eval "${REPLY}"

  echo "myOption: '${myOption}', myOption2: '${myOption2}', myOption3: '${myOption3}', myOption4: '${myOption4}', arg1: '${arg1}', arg2: '${arg2}', remaining arguments: '${*}'"
}

echo "Shell parameters syntax (complex, using \$@):"
subFunction4 other arguments 1 2 3 --- myOption=one myOption3="my value"
echo "===="


echo "Starting benchmarking..."



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

function subFunction3c() {
  local \
    arg1="${1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    arg2="${2?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}" \
    myOption="1" \
    myOption2="2" \
    myOption3="3" \
    myOption4="4"
  shift 2
  core::parseShellParameters "${@}"
  eval "${REPLY}"
}

function func3c() {
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


benchmark::run func1b func2a func2b func2c func3a func3b func3c

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# func1b        ░ 0.000s 033µs ░ N/A
# func2a        ░ 0.000s 035µs ░ +6%
# func2b        ░ 0.000s 036µs ░ +9%
# func2c        ░ 0.000s 040µs ░ +21%
# func3c        ░ 0.000s 082µs ░ +170%
# func3b        ░ 0.000s 090µs ░ +174%
# func3a        ░ 0.000s 099µs ░ +200%

log::info "# LESSONS LEARNED:

- The most efficient way to pass options to a function is to use shell parameters syntax:
  _OPTION_1 myFunction arg1 arg2
  But it makes reading the code harder because the options come before the function name.
  Additionally, the passed options are visible to sub functions called from the function which can be a problem.
- A good compromise is to use bash parameter syntax but for normal function arguments and then evaluate
  the options to obtain them as local variables:
  > myFunction arg1 arg2 myOption=1 myOption2=2
  This is more readable and still efficient.
- For functions that take an undetermined number of arguments, we can use the core::parseShellParameters function
  to parse the options that come after a --- separator.
"