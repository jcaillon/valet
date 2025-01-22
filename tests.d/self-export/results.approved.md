# Test suite self-export

## Test script 01.self-export

### ✅ Testing self export command

❯ `eval "$(valet self export)"`

❯ `selfExport`

**Standard output**:

```text
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/core"
trap SIGINT; trap SIGQUIT; trap SIGHUP; trap SIGTERM;

```

❯ `eval "$(valet self export -a)"`

❯ `selfExport -a`

**Standard output**:

```text
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/core"
trap SIGINT; trap SIGQUIT; trap SIGHUP; trap SIGTERM;
source ansi-codes
source array
source bash
source benchmark
source command
source curl
source fsfs
source http
source interactive
source io
source profiler
source progress
source prompt
source string
source system
source test
source tui
source version

```

