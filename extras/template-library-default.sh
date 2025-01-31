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
# - $2: second argument _as bool_:
#       (optional) Can be set using the variable `_OPTION_SECOND_ARGUMENT`.
#       Description of the second argument.
#       It should not be emphasized (like the previous **first name**).
#       The convention for optional positional arguments is to use `_OPTION_` followed by
#       the argument name in uppercase. Then you can set `${2:-${_OPTION_SECOND_ARGUMENT}}` to use it.
#       (defaults to false)
# - ${_OPTION_THIRD_OPTION} _as number_:
#       (optional) This one is a pure option and should not be a positional argument.
#       (defaults 0)
# - $@: more args _as string_:
#       For functions that take an undetermined number of arguments, you can use $@.
#
# Returns:
#
# - $?: The exit code of the executable.
# - ${RETURNED_VALUE}: The value to return
#
# ```bash
# _LIBRARY_NAME_::myFunction hi
# _OPTION_THIRD_OPTION=10 _LIBRARY_NAME_::myFunction hi true
# echo "${RETURNED_VALUE}"
# ```
#
# > A note about the function.
function _LIBRARY_NAME_::myFunction() {
  :;
}