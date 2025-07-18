# Test suite self-add-library

## Test script 00.self-add-library

### ✅ Testing self add-library

❯ `selfAddLibrary new-cool-lib`

**Standard output**:

```text
🙈 mocking interactive::promptYesNo It does not look like the current directory ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/self-add-library/resources/gitignored⌝ is a valet extension, do you want to proceed anyway? true
```

**Error output**:

```text
WARNING  The current directory is not under the valet user directory ⌜/tmp/valet.valet.d⌝.
SUCCESS  The library ⌜new-cool-lib⌝ has been created with the file ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/self-add-library/resources/gitignored/libraries.d/lib-new-cool-lib⌝.
```

❯ `selfAddLibrary new-cool-lib`

**Standard output**:

```text
🙈 mocking interactive::promptYesNo Do you want to override the existing library file? true
```

**Error output**:

```text
WARNING  The library file ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/self-add-library/resources/gitignored/libraries.d/lib-new-cool-lib⌝ already exists.
SUCCESS  The library ⌜new-cool-lib⌝ has been created with the file ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/self-add-library/resources/gitignored/libraries.d/lib-new-cool-lib⌝.
```

❯ `fs::cat libraries.d/lib-new-cool-lib`

**Standard output**:

```text
#!/usr/bin/env bash

#===============================================================
# >>> library: new-cool-lib
#===============================================================

# ## new-cool-lib::myFunction
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
# - ${REPLY}: The value to return
#
# ```bash
# new-cool-lib::myFunction hi
# _OPTION_THIRD_OPTION=10 new-cool-lib::myFunction hi true
# echo "${REPLY}"
# ```
#
# > A note about the function.
function new-cool-lib::myFunction() {
  :;
}
```

