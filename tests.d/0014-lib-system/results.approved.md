# Test suite 0014-lib-system

## Test script 00.tests

### Testing system::getOsName

Exit code: `0`

**Standard** output:

```plaintext
→ OSTYPE=linux-bsd system::getOsName
linux

→ OSTYPE=msys system::getOsName
windows

→ OSTYPE=darwin-stuff system::getOsName
darwin

→ OSTYPE=nop system::getOsName
unknown

```

