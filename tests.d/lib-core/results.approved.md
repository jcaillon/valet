# Test suite lib-core

## Test script 00.lib-core

### ✅ Test core::dump

❯ `core::dump`

Returned variables:

```text
REPLY='/tmp/valet.valet.d/core-dumps/1987-05-25T01-00-00+0000--PID_001234'
```

❯ `fs::head /tmp/valet.valet.d/core-dumps/1987-05-25T01-00-00+0000--PID_001234 2`

**Standard output**:

```text
=================
BASHPID: 1234
```

HOME is set to '$GLOBAL_INSTALLATION_DIRECTORY/home'

### ✅ Test core::get*Directory

❯ `core::getConfigurationDirectory`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/home/.config/valet'
```

❯ `core::getUserDataDirectory`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/home/.local/share/valet'
```

❯ `core::getUserCacheDirectory`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/home/.cache/valet'
```

❯ `core::getUserStateDirectory`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/home/.local/state/valet'
```

❯ `core::getExtensionsDirectory`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/home/.valet.d'
```

### ✅ Test core::createSavedFilePath

❯ `core::createSavedFilePath`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/home/.local/state/valet/saved-files/1987-05-25T01-00-00+0000--PID_001234'
```

❯ `core::createSavedFilePath suffix=suffix`

Returned variables:

```text
REPLY='$GLOBAL_INSTALLATION_DIRECTORY/home/.local/state/valet/saved-files/1987-05-25T01-00-00+0000--PID_001234--suffix'
```

Content of HOME directory:

❯ `fs::listDirectories $GLOBAL_INSTALLATION_DIRECTORY/home recursive=true includeHidden=true`

Returned variables:

```text
REPLY_ARRAY=(
[0]='$GLOBAL_INSTALLATION_DIRECTORY/home/.cache'
[1]='$GLOBAL_INSTALLATION_DIRECTORY/home/.config'
[2]='$GLOBAL_INSTALLATION_DIRECTORY/home/.local'
[3]='$GLOBAL_INSTALLATION_DIRECTORY/home/.valet.d'
[4]='$GLOBAL_INSTALLATION_DIRECTORY/home/.cache/valet'
[5]='$GLOBAL_INSTALLATION_DIRECTORY/home/.config/valet'
[6]='$GLOBAL_INSTALLATION_DIRECTORY/home/.local/share'
[7]='$GLOBAL_INSTALLATION_DIRECTORY/home/.local/state'
[8]='$GLOBAL_INSTALLATION_DIRECTORY/home/.local/share/valet'
[9]='$GLOBAL_INSTALLATION_DIRECTORY/home/.local/state/valet'
[10]='$GLOBAL_INSTALLATION_DIRECTORY/home/.local/state/valet/saved-files'
)
```

### ✅ Test core::fail

❯ `core::fail Failure\ message.`

Exited with code: `1`

**Error output**:

```text
FAIL     Failure message.
```

❯ `core::fail Failure\ message. exitCode=255`

Exited with code: `255`

**Error output**:

```text
FAIL     Failure message.
```

### ✅ Test core::exit

❯ `core::exit`

Exited with code: `1`

**Error output**:

```text
CMDERR   Error code ⌜1⌝ for the command:
╭ shift 1
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
```

❯ `core::exit 255`

Exited with code: `255`

**Error output**:

```text
EXIT     Explicit exit with code 255, stack:
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
```

❯ `core::exit 1 silent=true`

Exited with code: `1`

### ✅ Test normal exit

❯ `exit`

❯ `exit 1`

Exited with code: `1`

**Error output**:

```text
EXIT     Explicit exit with code 1, stack:
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
```

### ✅ Test core::parseShellParameters

❯ `core::parseShellParameters ---`

Returned variables:

```text
REPLY='set -- "${@:1:0}"'
```

❯ `core::parseShellParameters arg1 arg2 arg3`

Returned variables:

```text
REPLY=':'
```

❯ `core::parseShellParameters arg1 arg2 arg3 ---`

Returned variables:

```text
REPLY='set -- "${@:1:3}"'
```

❯ `core::parseShellParameters arg1 arg2 arg3 --- myOption=one`

Returned variables:

```text
REPLY='local '"'"'myOption=one'"'"'; set -- "${@:1:3}"'
```

❯ `core::parseShellParameters arg1 arg2 --- myOption=one myOption2=my\ value`

Returned variables:

```text
REPLY='local '"'"'myOption=one'"'"' '"'"'myOption2=my value'"'"'; set -- "${@:1:2}"'
```

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

❯ `source resources/script1.sh my arguments 1 2 3`

**Standard output**:

```text
We sourced script1.sh: my arguments 1 2 3
```

❯ `source resources/script1.sh my arguments 1 2 3`

Including a script using an absolute path twice, expecting to be sourced once.

❯ `source $GLOBAL_INSTALLATION_DIRECTORY/script1.sh`

**Standard output**:

```text
We sourced script1.sh: 
```

❯ `source $GLOBAL_INSTALLATION_DIRECTORY/script1.sh`

Including non existing library.

❯ `source NOPNOP`

Exited with code: `1`

**Error output**:

```text
FAIL     Cannot source the file ⌜NOPNOP⌝ because it does not exist.
```

❯ `_OPTION_CONTINUE_IF_NOT_FOUND=true source NOPNOP`

Returned code: `1`

```text
_CORE_INCLUDED_LIBRARIES='
stuff

stuff2
'
```

Returning a different code if already included.

❯ `_OPTION_RETURN_CODE_IF_ALREADY_INCLUDED=2 source $GLOBAL_INSTALLATION_DIRECTORY/script1.sh`

Returned code: `2`

❯ `core::resetIncludedFile $GLOBAL_INSTALLATION_DIRECTORY/script1.sh`

❯ `_OPTION_RETURN_CODE_IF_ALREADY_INCLUDED=2 source $GLOBAL_INSTALLATION_DIRECTORY/script1.sh`

**Standard output**:

```text
We sourced script1.sh: 
```

