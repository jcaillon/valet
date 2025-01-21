# Test suite self-add-library

## Test script 00.self-add-library

### ✅ Testing self add-library

❯ `selfAddLibrary new-cool-lib`

**Standard output**:

```text
🙈 mocking interactive::promptYesNo It does not look like the current directory ⌜$GLOBAL_VALET_HOME/tests.d/self-add-library/resources/gitignored⌝ is a valet extension, do you want to proceed anyway? true
```

**Error output**:

```text
WARNING  The current directory is not under the valet user directory ⌜/tmp/valet.valet.d⌝.
SUCCESS  The library ⌜new-cool-lib⌝ has been created with the file ⌜$GLOBAL_VALET_HOME/tests.d/self-add-library/resources/gitignored/libraries.d/lib-new-cool-lib⌝.
```

❯ `selfAddLibrary new-cool-lib`

**Standard output**:

```text
🙈 mocking interactive::promptYesNo Do you want to override the existing library file? true
```

**Error output**:

```text
WARNING  The library file ⌜$GLOBAL_VALET_HOME/tests.d/self-add-library/resources/gitignored/libraries.d/lib-new-cool-lib⌝ already exists.
SUCCESS  The library ⌜new-cool-lib⌝ has been created with the file ⌜$GLOBAL_VALET_HOME/tests.d/self-add-library/resources/gitignored/libraries.d/lib-new-cool-lib⌝.
```

❯ `io::cat libraries.d/lib-new-cool-lib`

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
# - $2: force _as bool_:
#       (optional) description of the second argument
#       (defaults to false)
#
# Returns:
#
# - $?: The exit code of the executable.
# - `RETURNED_VALUE`: The value to return
#
# ```bash
# new-cool-lib::myFunction hi true
# echo "${RETURNED_VALUE}"
# ```
#
# > A note about the function.
function new-cool-lib::myFunction() {
  :;
}
```

