# Test suite self-add-library

## Test script 00.self-add-library

### ✅ Testing self add-library

❯ `selfAddLibrary new-cool-lib`

**Standard output**:

```text
🙈 mocking interactive::promptYesNo It does not look like the current directory ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/self-add-library/resources/gitignored⌝ is a valet extension, do you want to proceed anyway?
```

**Error output**:

```text
WARNING  The current directory is not under the valet user directory ⌜/tmp/valet.valet.d⌝.
SUCCESS  The library ⌜new-cool-lib⌝ has been created with the file ⌜$GLOBAL_INSTALLATION_DIRECTORY/tests.d/self-add-library/resources/gitignored/libraries.d/lib-new-cool-lib⌝.
```

❯ `selfAddLibrary new-cool-lib`

**Standard output**:

```text
🙈 mocking interactive::promptYesNo Do you want to override the existing library file?
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
# new-cool-lib::myFunction hi
# new-cool-lib::myFunction hi true --- myOption=true
# echo "${REPLY}"
# ```
#
# > A note about the function.
function new-cool-lib::myFunction() {
  local \
    arg1="${1}" \
    myOption=false
  core::parseShellParameters "${@}"
  eval "${REPLY}"
  shift 1
  echo "arg1: ${arg1}, myOption: ${myOption}, remaining args: '${*}'"
}
```

