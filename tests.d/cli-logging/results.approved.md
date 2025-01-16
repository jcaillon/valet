# Test suite cli-logging

## Test script 01.logging

### Passing logging level through an environment variable

Prompt:

```bash
printf %s\\n coucou hello\ 2nd
```

**Standard output**:

```text
coucou
hello 2nd
```

Prompt:

```bash
VALET_LOG_LEVEL=success ${GLOBAL_VALET_HOME}/valet self mock1 logging-level
```

**Error output**:

```text
TRACE    This is an error trace message which is always displayed.
SUCCESS  This is a success message.
WARNING  This is a warning message.
With a second line.
```

