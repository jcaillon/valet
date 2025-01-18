# Test suite cli-traps

## Test script 01.traps

### ✅ Testing error handling (a statement returns != 0)

Prompt:

```bash
valet self mock1 error
```

Exited with code: `1`

**Error output**:

```text
WARNING  This is for testing valet core functions, the next statement will return 1 and create an error.
ERROR    Error code 1 in selfMock1(), stack:
├─ in selfMock1() at $GLOBAL_VALET_HOME/tests.d/commands.d/self-mock.sh:49
├─ in main::runFunction() at $GLOBAL_VALET_HOME/libraries.d/main:564
├─ in main::parseMainArguments() at $GLOBAL_VALET_HOME/libraries.d/main:423
└─ in main() at valet:110
```

### ✅ Testing exit code (exit 5) and custom exit function

Prompt:

```bash
valet self mock1 exit
```

Exited with code: `5`

**Error output**:

```text
WARNING  This is for testing valet core functions, exiting with code 5.
WARNING  This is a custom on exit function.
EXIT     Exiting with code 5, stack:
├─ in selfMock1() at $GLOBAL_VALET_HOME/tests.d/commands.d/self-mock.sh:1
├─ in main::runFunction() at $GLOBAL_VALET_HOME/libraries.d/main:564
├─ in main::parseMainArguments() at $GLOBAL_VALET_HOME/libraries.d/main:423
└─ in main() at valet:110
```

### ✅ Testing the core::fail function

Prompt:

```bash
valet self mock1 fail
```

Exited with code: `1`

**Error output**:

```text
ERROR    This is for testing valet core functions, failing now.
```

### ✅ Testing the core::failWithCode function

Prompt:

```bash
valet self mock1 fail2
```

Exited with code: `255`

**Error output**:

```text
ERROR    This is for testing valet core functions, failing now with exit code 255.
```

### ✅ Testing the unknown command handler

Prompt:

```bash
valet self mock1 unknown-command
```

Exited with code: `1`

**Error output**:

```text
WARNING  This is for testing valet core functions, the next statement will call a non existing command, causing a call to command_not_found_handle.
ERROR    Command not found: ⌜thisIsAnUnknownCommandForTesting⌝.
Please check your ⌜PATH⌝ variable.
ERROR    Error code 1 in selfMock1(), stack:
├─ in selfMock1() at $GLOBAL_VALET_HOME/tests.d/commands.d/self-mock.sh:67
├─ in main::runFunction() at $GLOBAL_VALET_HOME/libraries.d/main:564
├─ in main::parseMainArguments() at $GLOBAL_VALET_HOME/libraries.d/main:423
└─ in main() at valet:110
```

