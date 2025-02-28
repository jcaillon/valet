# Test suite lib-core

## Test script 00.tests

### ✅ Test source

❯ `core::resetIncludedFiles`

```text
CMD_LIBRARY_DIRECTORIES=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/ext2'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/ext1'
)
_CORE_INCLUDED_LIBRARIES=''
```

Including the stuff library twice, expecting to be sourced once.

❯ `source stuff`

**Standard output**:

```text
We sourced lib-stuff from core installation directory
We sourced lib-stuff from extension2
We sourced lib-stuff from extension1
```

❯ `source stuff`

Including a user defined library.

❯ `source stuff2`

**Standard output**:

```text
We sourced lib-stuff2 from extension1
```

Including a script using relative path twice, expecting to be sourced once.

❯ `source resources/script1.sh`

**Standard output**:

```text
We sourced script1.sh
```

❯ `source resources/script1.sh`

Including a script using an absolute path twice, expecting to be sourced once.

❯ `source $GLOBAL_INSTALLATION_DIRECTORY/script1.sh`

**Standard output**:

```text
We sourced script1.sh
```

❯ `source $GLOBAL_INSTALLATION_DIRECTORY/script1.sh`

Including non existing library.

❯ `source NOPNOP`

Exited with code: `1`

**Error output**:

```text
ERROR    Cannot source the file ⌜NOPNOP⌝ because it does not exist.
```

```text
_CORE_INCLUDED_LIBRARIES='
stuff

stuff2
'
```

