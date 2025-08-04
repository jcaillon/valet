#!/usr/bin/env bash
# shellcheck disable=SC1091
# shellcheck disable=SC1090
source "$(valet --source)"
include benchmark

function read1() {
  read -rd '' REPLY < 'tests.d/lib-fs/resources/file-to-read' || [[ ${#REPLY} -gt 0 ]]
}

function read2() {
  local IFS=''
  read -rd '' REPLY < 'tests.d/lib-fs/resources/file-to-read' || [[ ${#REPLY} -gt 0 ]]
}

function read3() {
  read -rd '' < 'tests.d/lib-fs/resources/file-to-read' || [[ ${#REPLY} -gt 0 ]]
}


function read1bis() {
  read -rd '' REPLY < 'tests.d/lib-fs/resources/file-to-read' || [[ -n ${#REPLY} ]]
}


benchmark::run read1 read2 read3 read1bis

# Function name ░ Average time  ░ Compared to fastest
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# read1bis      ░ 0.005s 424µs ░ N/A
# read1         ░ 0.005s 486µs ░ +1%
# read2         ░ 0.005s 508µs ░ +1%
# read3         ░ 0.005s 552µs ░ +2%
#
echo "LESSONS LEARNED:

To read a file:

- -d '' allows to read the entire file (the default delimiter is a newline and read reads 1 line);
- -r disables backslash escaping;
- IFS is not necessary when we assign the result to a single variable
- read will exit with an error code if we reached the end of the file, so we || and check that REPLY is not empty.
"