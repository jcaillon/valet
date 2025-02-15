# Test suite cli-features

## Test script 01.misc

### ✅ Testing exit cleanup

❯ `main::parseMainArguments self mock1 create-temp-files`

**Error output**:

```text
INFO     Created temp file: /tmp/valet.d/f1-2.
INFO     Created temp file: /tmp/valet.d/f2-2.
INFO     Created temp directory: /tmp/valet.d/d1-2.
INFO     Created temp directory: /tmp/valet.d/d2-2.
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
```

### ✅ Testing the bad config

❯ `valet self mock1`

Returned code: `1`

**Error output**:

```text
/tmp/valet.valet.d/config: line 1: 1/0: division by 0 (error token is "0")
ERROR    Error code 1 in source(), stack:
├─ in source() at $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main:47
└─ in main() at valet:95
TRACE    Error sourcing the configuration file ⌜/tmp/valet.valet.d/config⌝.
Check the file for error and try again, or delete the file to discard your config.
```

### ✅ Testing the bad .env

❯ `valet self mock1`

Returned code: `1`

**Error output**:

```text
.env: line 1: 1/0: division by 0 (error token is "0")
ERROR    Error code 1 in source(), stack:
├─ in source() at $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main:54
└─ in main() at valet:95
TRACE    Error sourcing the env file ⌜.env⌝.
Check the file for error and try again, or delete the file to discard your config.
```

### ✅ Testing the bad commands

❯ `valet self mock1`

Returned code: `1`

**Error output**:

```text
/tmp/valet.d/d3-2/commands: line 1: 1/0: division by 0 (error token is "0")
ERROR    Error code 1 in core::sourceUserCommands(), stack:
├─ in core::sourceUserCommands() at $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/core:1714
├─ in source() at $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main:121
└─ in main() at valet:95
TRACE    Error sourcing the commands file ⌜/tmp/valet.d/d3-2/commands⌝.
Please rebuild it using the ⌜valet self build⌝ command.
```

### ✅ Testing empty user directory rebuilding the commands

❯ `valet self mock1`

Returned code: `1`

**Error output**:

```text
INFO     The commands index does not exist ⌜/tmp/valet.d/d3-2/commands⌝.
Now silently building it using ⌜valet self build⌝ command.
WARNING  Entering interactive mode for the function ⌜selfMock1⌝. This is not yet implemented.
ERROR    Expecting ⌜1⌝ argument(s) but got ⌜0⌝.
Use ⌜valet self mock1 --help⌝ to get help.

Usage:
valet [global options] self mock1 [options] [--] <action>
```

## Test script 02.traps

### ✅ Testing error handling (a statement returns != 0)

❯ `valet self mock1 error`

Returned code: `1`

**Error output**:

```text
WARNING  This is for testing valet core functions, the next statement will return 1 and create an error.
ERROR    Error code 1 in selfMock1(), stack:
├─ in selfMock1() at $GLOBAL_INSTALLATION_DIRECTORY/tests.d/.commands.d/self-mock.sh:54
├─ in main::runFunction() at $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main:533
├─ in main::parseMainArguments() at $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main:391
└─ in main() at valet:100
```

### ✅ Testing exit code (exit 5) and custom exit function

❯ `valet self mock1 exit`

Returned code: `5`

**Error output**:

```text
WARNING  This is for testing valet core functions, exiting with code 5.
WARNING  This is a custom on exit function.
EXIT     Exiting with code 5, stack:
├─ in selfMock1() at $GLOBAL_INSTALLATION_DIRECTORY/tests.d/.commands.d/self-mock.sh:1
├─ in main::runFunction() at $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main:533
├─ in main::parseMainArguments() at $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main:391
└─ in main() at valet:100
```

### ✅ Testing the core::fail function

❯ `valet self mock1 fail`

Returned code: `1`

**Error output**:

```text
ERROR    This is for testing valet core functions, failing now.
```

### ✅ Testing the core::failWithCode function

❯ `valet self mock1 fail2`

Returned code: `255`

**Error output**:

```text
ERROR    This is for testing valet core functions, failing now with exit code 255.
```

### ✅ Testing the unknown command handler

❯ `valet self mock1 unknown-command`

Returned code: `1`

**Error output**:

```text
WARNING  This is for testing valet core functions, the next statement will call a non existing command, causing a call to command_not_found_handle.
ERROR    Command not found: ⌜thisIsAnUnknownCommandForTesting⌝.
Please check your ⌜PATH⌝ variable.
ERROR    Error code 1 in selfMock1(), stack:
├─ in selfMock1() at $GLOBAL_INSTALLATION_DIRECTORY/tests.d/.commands.d/self-mock.sh:72
├─ in main::runFunction() at $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main:533
├─ in main::parseMainArguments() at $GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main:391
└─ in main() at valet:100
```

