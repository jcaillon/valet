# Test suite self-export

## Test script 01.self-export

### ✅ Testing self export command

❯ `eval "$(valet self export)"`

❯ `selfExport`

**Standard output**:

```text
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/core"
trap SIGINT; trap SIGQUIT; trap SIGHUP; trap SIGTERM;
GLOBAL_EXPORTED=true;

```

❯ `eval "$(valet self export -a)"`

❯ `selfExport -a`

**Standard output**:

```text
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/core"
trap SIGINT; trap SIGQUIT; trap SIGHUP; trap SIGTERM;
GLOBAL_EXPORTED=true;
source array
source bash
source benchmark
source command
source curl
source exe
source fs
source http
source interactive
source multi-line-prompt
source profiler
source progress
source prompt
source regex
source sfzf
source string
source system
source test
source time
source tui
source version
source windows

```

