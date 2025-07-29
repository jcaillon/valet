# Test suite cli-global-options

## Test script 01.options

### ✅ Testing unknown option

❯ `main::parseMainArguments --logging-leeeevel`

Exited with code: `1`

**Error output**:

```text
FAIL     Unknown option ⌜--logging-leeeevel⌝, valid options are:
-x --profiling
-l --log-level --log
-v --verbose
-w --very-verbose
--disable-progress-bars
-i --force-interactive-mode
--source
--version
-h --help
```

### ✅ Testing unknown single letter

❯ `main::parseMainArguments -prof`

Exited with code: `1`

**Error output**:

```text
FAIL     Unknown option letter ⌜p⌝ in group ⌜-p⌝. Valid single letter options are: ⌜x⌝, ⌜l⌝, ⌜v⌝, ⌜w⌝, ⌜i⌝, ⌜h⌝.
```

### ✅ Testing option --version corrected with fuzzy match

❯ `main::parseMainArguments --versin`

**Standard output**:

```text
1.42.69
```

**Error output**:

```text
INFO     Fuzzy matching the option ⌜--versin⌝ to ⌜--version⌝.
```

### ✅ Testing group of single letter options

❯ `main::parseMainArguments -vwvw --versin`

**Standard output**:

```text
1.42.69
```

**Error output**:

```text
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Log level set to trace.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Log level set to debug.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
DEBUG    Log level set to trace.
WARNING  Beware that debug log level might lead to secret leak, use it only if necessary.
INFO     Fuzzy matching the option ⌜--versin⌝ to ⌜--version⌝.
TRACE    Explicit exit with code 0, stack:
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
DEBUG    Exiting subshell depth 3 with code 0, stack:
╭ "${@}"
├─ in myCmd::subFunction() at /path/to/subFunction.sh:200
╰─ in myCmd::function() at /path/to/function.sh:300
```

