# Test suite cli-global-options

## Test script 01.options

### ✅ Testing unknown option

❯ `command::parseProgramArguments --logging-leeeevel`

Exited with code: `1`

**Error output**:

```text
FAIL     Unknown option ⌜--logging-leeeevel⌝, valid options are:
--profiler
--log-level --log
-v --verbose
--disable-progress-bars
--interactive
--source
--version
-h --help
```

### ✅ Testing unknown single letter

❯ `command::parseProgramArguments -prof`

Exited with code: `1`

**Error output**:

```text
FAIL     Unknown option letter ⌜p⌝ in group ⌜-prof⌝. Valid single letter options are: ⌜v⌝, ⌜h⌝.
```

### ✅ Testing option --version corrected with fuzzy match

❯ `command::parseProgramArguments --versin`

**Standard output**:

```text
1.42.69
```

**Error output**:

```text
INFO     Fuzzy matching the option ⌜--versin⌝ to ⌜--version⌝.
```

### ✅ Testing group of single letter options

❯ `command::parseProgramArguments -vvv --versin`

**Standard output**:

```text
1.42.69
```

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
INFO     Fuzzy matching the option ⌜--versin⌝ to ⌜--version⌝.
DEBUG    Exiting subshell depth 3 with code 0.
```

### ✅ Testing invalid single letter options

❯ `command::parseProgramArguments -w --versin`

Exited with code: `1`

**Error output**:

```text
FAIL     Unknown option letter ⌜w⌝ in group ⌜-w⌝. Valid single letter options are: ⌜v⌝, ⌜h⌝.
```

### ✅ Testing invalid letter options

❯ `command::parseProgramArguments -vvw --versin`

Exited with code: `1`

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
FAIL     Unknown option letter ⌜w⌝ in group ⌜-vvw⌝. Valid single letter options are: ⌜v⌝, ⌜h⌝.
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
DEBUG    Exiting subshell depth 3 with code 1.
```

