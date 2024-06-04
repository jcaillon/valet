# Test suite 1004-lib-system

## Test script 00.tests

### Testing system::os

Exit code: `0`

**Standard** output:

```plaintext
→ OSTYPE=linux-bsd system::os
linux

→ OSTYPE=msys system::os
windows

→ OSTYPE=darwin-stuff system::os
darwin

→ OSTYPE=nop system::os
unknown

```

### Testing system::env

Exit code: `0`

**Standard** output:

```plaintext
→ system::env
Found environment variables.
```

### Testing system::date

Exit code: `0`

**Standard** output:

```plaintext
→ system::date
Returned date with length 22.

→ system::date %(%H:%M:%S)T
Returned date with length 8.
```

