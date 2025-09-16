#!/usr/bin/env bash
# shellcheck disable=SC1091
# shellcheck disable=SC1090
source "$(valet --source)"
include benchmark

TEST_STRING="apple
banana
{1,10}
cherry
!2
/*
date"

function split1() {
  local IFS=$'\n'
  set -o noglob
  REPLY_ARRAY=(${TEST_STRING})
  set +o noglob
}

function split2() {
  IFS=$'\n' read -rd '' -a REPLY_ARRAY <<<"${TEST_STRING}" || [[ -v REPLY_ARRAY ]]
}

split1
IFS=$'\n'
echo "split:"$'\n'"${REPLY_ARRAY[*]}"
result1="${REPLY_ARRAY[*]}"
split2
if [[ "${result1}" != "${REPLY_ARRAY[*]}" ]]; then
  echo "❌ split1 and split2 do not return the same result"
  echo "split1:"$'\n'"'${result1}'"
  echo "split2:"$'\n'"'${REPLY_ARRAY[*]}'"
  exit 1
fi

benchmark::run split1 split2

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# split1        ░ 0.000s 015µs ░ N/A
# split2        ░ 0.000s 164µs ░ +944%
#
echo "LESSONS LEARNED:

- Splitting a string into an array is much much faster using bash expansion but we need to turn off all special character expansion
- history is turned off by default in Valet and brace expansion happens before word splitting so it we only need to worry about globbing (wildcards)
- see: https://www.gnu.org/software/bash/manual/bash.html#Shell-Expansions-1
"