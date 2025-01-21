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

### ✅ Testing empty user directory rebuilding the commands

❯ `VALET_LOG_LEVEL=warning valet self mock1 logging-level`

**Error output**:

```text
WARNING  Skipping the build of scripts in user directory ⌜/tmp/valet.d/d3-2/non-existing⌝ because it does not exist.
TRACE    This is an error trace message which is always displayed.
WARNING  This is a warning message.
With a second line.
```

## Test script 02.traps

### ✅ Testing error handling (a statement returns != 0)

❯ `valet self mock1 error`

Returned code: `1`

**Error output**:

```text
WARNING  This is for testing valet core functions, the next statement will return 1 and create an error.
ERROR    Error code 1 in selfMock1(), stack:
├─ in selfMock1() at $GLOBAL_VALET_HOME/tests.d/.commands.d/self-mock.sh:52
├─ in main::runFunction() at $GLOBAL_VALET_HOME/libraries.d/main:565
├─ in main::parseMainArguments() at $GLOBAL_VALET_HOME/libraries.d/main:423
└─ in main() at valet:110
```

### ✅ Testing exit code (exit 5) and custom exit function

❯ `valet self mock1 exit`

Returned code: `5`

**Error output**:

```text
WARNING  This is for testing valet core functions, exiting with code 5.
WARNING  This is a custom on exit function.
EXIT     Exiting with code 5, stack:
├─ in selfMock1() at $GLOBAL_VALET_HOME/tests.d/.commands.d/self-mock.sh:1
├─ in main::runFunction() at $GLOBAL_VALET_HOME/libraries.d/main:565
├─ in main::parseMainArguments() at $GLOBAL_VALET_HOME/libraries.d/main:423
└─ in main() at valet:110
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
├─ in selfMock1() at $GLOBAL_VALET_HOME/tests.d/.commands.d/self-mock.sh:70
├─ in main::runFunction() at $GLOBAL_VALET_HOME/libraries.d/main:565
├─ in main::parseMainArguments() at $GLOBAL_VALET_HOME/libraries.d/main:423
└─ in main() at valet:110
```

