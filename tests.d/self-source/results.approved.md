# Test suite self-source

## Test script 01.self-source

### ✅ Testing self source command

❯ `selfSource`

**Standard output**:

```text
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main"

```

❯ `selfSource -a`

**Standard output**:

```text
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main"
source array
source bash
source benchmark
source command
source coproc
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
source terminal
source test
source time
source tui
source version
source windows

```

❯ `selfSource -p`

**Standard output**:

```text
GLOBAL_SOURCED_FOR_PROMPT=true;
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main"
function core::fail() { log::error "$@"; }
function core::exit() { local exitCode=${1:-0} silent=false IFS=$' '; shift 1; eval "local a= ${*@Q}"; if [[ ${silent} != "true" ]]; then log::error "Caught exit with code ${exitCode}:"; fi; }
set +o errexit
trap SIGINT; trap SIGQUIT; trap SIGHUP; trap SIGTERM; trap ERR; trap EXIT

```

❯ `selfSource -E`

**Standard output**:

```text
source "$GLOBAL_INSTALLATION_DIRECTORY/libraries.d/main"
function core::fail() { log::error "$@"; }
function core::exit() { local exitCode=${1:-0} silent=false IFS=$' '; shift 1; eval "local a= ${*@Q}"; if [[ ${silent} != "true" ]]; then log::error "Caught exit with code ${exitCode}:"; fi; }
set +o errexit

```

❯ `eval "$(valet self source)"`

❯ `eval "$(valet self source -a)"`

❯ `eval "$(valet self source -p)"`

