# Test suite cli-features

## Test script 01.misc

### ✅ Testing exit cleanup

Prompt:

```bash
valet self mock1 create-temp-files
```

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

Prompt:

```bash
VALET_LOG_LEVEL=warning valet self mock1 logging-level
```

**Error output**:

```text
WARNING  Skipping the build of scripts in user directory ⌜/tmp/valet.d/d3-2/non-existing⌝ because it does not exist.
TRACE    This is an error trace message which is always displayed.
WARNING  This is a warning message.
With a second line.
```

