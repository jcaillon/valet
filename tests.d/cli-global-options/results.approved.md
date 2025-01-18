# Test suite cli-global-options

## Test script 01.options

### ✅ Testing unknown option

Prompt:

```bash
valet --logging-leeeevel
```

Exited with code: `1`

**Error output**:

```text
ERROR    Unknown option ⌜--logging-leeeevel⌝, valid options are:
-x --profiling
-l --log-level --log
-v --verbose
-w --very-verbose
--disable-progress-bars
-i --force-interactive-mode
--version
-h --help
```

### ✅ Testing unknown single letter

Prompt:

```bash
valet -prof
```

Exited with code: `1`

**Error output**:

```text
ERROR    Unknown option letter ⌜p⌝ in group ⌜-p⌝. Valid single letter options are: ⌜x⌝, ⌜l⌝, ⌜v⌝, ⌜w⌝, ⌜i⌝, ⌜h⌝.
```

### ✅ Testing option --version corrected with fuzzy match

Prompt:

```bash
valet --versin
```

**Standard output**:

```text
1.42.69
```

**Error output**:

```text
INFO     Fuzzy matching the option ⌜--versin⌝ to ⌜--version⌝.
```

### ✅ Testing group of single letter options

Prompt:

```bash
valet -vwvw --versin
```

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
```

