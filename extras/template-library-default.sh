#!/usr/bin/env bash

#===============================================================
# >>> library: _LIBRARY_NAME_
#===============================================================

# ## _LIBRARY_NAME_::myFunction
#
# Description of the function goes there.
#
# - $1: **first argument** _as string_:
#       description of the first argument
# - $@: more args _as string_:
#       For functions that take an undetermined number of arguments, you can use $@.
# - ${myOption} _as bool_:
#       (optional) Description of the option.
#       This describes an optional parameter passed as a shell parameter (e.g. `myOption=true`).
#       (defaults to false)
#
# Returns:
#
# - $?: The exit code of the function.
# - ${REPLY}: The value to return
#
# ```bash
# _LIBRARY_NAME_::myFunction hi
# _LIBRARY_NAME_::myFunction hi true --- myOption=true
# echo "${REPLY}"
# ```
#
# > A note about the function.
function _LIBRARY_NAME_::myFunction() {
  local \
    arg1="${1}" \
    myOption=false
  core::parseFunctionOptions "${@}"
  eval "${REPLY}"
  shift 1
  echo "arg1: ${arg1}, myOption: ${myOption}, remaining args: '${*}'"
}