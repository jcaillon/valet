#!/usr/bin/env bash

echo "LESSONS LEARNED:

https://www.gnu.org/software/bash/manual/bash.html#Command-Execution-Environment

Each build/shell command of a pipeline is executed in a subshell, which is a child process of the current shell.
It is this costly to use pipes with builtins.
"

# shellcheck disable=SC2216
echo ${BASHPID} 1>&2 | echo ${BASHPID} 1>&2 | echo ${BASHPID}