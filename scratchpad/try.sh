#!/usr/bin/env bash
export VALET_VERBOSE=true
source "$(valet --source)"

include system

function string::getKebabCase() {
  REPLY="${!1?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"

  if [[ ${REPLY} == *[[:upper:]]* && ${REPLY} == *[[:lower:]]* ]]; then
    # from camelCase or PascalCase
    # it is faster to use a regex than loop over each char here
    while [[ ${REPLY} =~ [[:upper:]] ]]; do
      REPLY="${REPLY//"${BASH_REMATCH[0]}"/-"${BASH_REMATCH[0],}"}"
    done
  else
    # from SNAKE_CASE of already in kebab-case
    REPLY="${REPLY,,}"
  fi
  REPLY="${REPLY//[![:lower:][:digit:]-]/-}"
  while [[ ${REPLY} == -* ]]; do
    REPLY="${REPLY:1}"
  done
  while [[ ${REPLY} == *- ]]; do
    REPLY="${REPLY%-}"
  done
}



tests=(
thisIsATest0
AnotherTest
--AnotherTest--
_SNAKE_CASE
__SNAKE_CASE__
kebab-case
--kebab-case--
)

for REPLY in "${tests[@]}"; do
  string::getKebabCase REPLY
  echo "${REPLY}"
done