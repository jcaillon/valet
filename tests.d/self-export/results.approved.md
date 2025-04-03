# Test suite self-export

## Test script 01.self-export

### ✅ Testing self export command

❯ `selfExport`

**Standard output**:

```text
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/core"

```

❯ `selfExport -a`

**Standard output**:

```text
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/core"
source array
source bash
source benchmark
source command
source curl
source exe
source fs
source http
source interactive
source list
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

❯ `selfExport -p`

**Standard output**:

```text
GLOBAL_EXPORTED_FOR_PROMPT=true;
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/core"
function core::fail() { log::error "$@"; }
set +o errexit
trap SIGINT; trap SIGQUIT; trap SIGHUP; trap SIGTERM; trap ERR; trap EXIT

```

❯ `selfExport -E`

**Standard output**:

```text
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/core"
function core::fail() { log::error "$@"; }
set +o errexit

```

❯ `eval "$(valet self export)"`

❯ `eval "$(valet self export -a)"`

❯ `eval "$(valet self export -p)"`

