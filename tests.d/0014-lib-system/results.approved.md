# Test suite 0014-lib-system

## Test script 00.tests

### Testing getOsName

Exit code: `0`

**Standard** output:

```plaintext
→ OSTYPE=linux-bsd getOsName
linux

→ OSTYPE=msys getOsName
windows

→ OSTYPE=darwin-stuff getOsName
darwin

→ OSTYPE=nop getOsName
unknown

```

