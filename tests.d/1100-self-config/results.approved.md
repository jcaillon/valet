# Test suite 1100-self-config

## Test script 01.self-config

### Testing selfConfig

Exit code: `0`

**Standard** output:

```plaintext
→ selfConfig
▶ called myEditor: /tmp/valet.d/f401-0

cat ${configFile}
#!/usr/bin/env bash
# description: This script declares global variables used to configure Valet
# shellcheck disable=SC2034

# This file is sourced by Valet on startup which allows you to setup global
# variables to configure Valet. You can define the variables here or export
# them in your shell or in your .bashrc file.
#
# Empty variables will be replaced by the default values during the execution.
# You should not define all the variables, only the ones you want to change.

# -----------
# General config
# -----------
# The path to this Valet config file: MUST BE declared outside this file!
# Default to the 'config' file in your config directory.
# VALET_CONFIG_FILE

# The directory in which to find user commands.
# Defaults to the 'valet.d' directory in the user home directory.
VALET_USER_DIRECTORY="${VALET_USER_DIRECTORY:-}"

# The path to the configuration directory, where we store that should be kept between sessions.
# You can backup this directory to keep your configuration.
# Defaults to the '.config' directory in the user home directory.
VALET_CONFIG_DIRECTORY="${VALET_CONFIG_DIRECTORY:-}"

# The path to the directory in which to store the data that should be kept between sessions
# but are not essential for the user configuration (e.g. last choices in menus).
# Defaults to the '.local/state' directory in the user home directory.
VALET_CONFIG_LOCAL_STATE_DIRECTORY="${VALET_CONFIG_LOCAL_STATE_DIRECTORY:-}"

# The directory in which to write work files (small files to capture output of programs).
# You can set it to a tmpfs directory (such as /dev/shm) to speed up the execution of valet.
# Defaults to the temporary directory (TMPDIR or /tmp).
VALET_CONFIG_WORK_FILES_DIRECTORY="${VALET_CONFIG_WORK_FILES_DIRECTORY:-}"

# The directory in which to find executables required by Valet.
# Defaults to the 'bin' directory in the Valet home directory.
# /!\ will dissapear once we get rid of fzf and go with pure bash.
VALET_CONFIG_BIN_PATH="${VALET_CONFIG_BIN_PATH:-}"

# If true, valet will use the executable from the PATH even if they exist in the valet bin/ directory.
VALET_CONFIG_DISABLE_LOCAL_BIN="${VALET_CONFIG_DISABLE_LOCAL_BIN:-}"

# Number of last choices to remember when selecting an item from a command menu.
# Set to 0 to disable this feature and always display items in the alphabetical order.
VALET_CONFIG_REMEMBER_LAST_CHOICES="${VALET_CONFIG_REMEMBER_LAST_CHOICES:-}"

# -----------
# Log/output configuration
# -----------
# If true, will simplify the log output for CI/CD environments:
# will display the logs without colors, without icons, without wrapping lines and with the full date.
VALET_CONFIG_ENABLE_CI_MODE="${VALET_CONFIG_ENABLE_CI_MODE:-}"

# If true, will disable the icons (using nerd font).
VALET_CONFIG_DISABLE_NERDFONT_ICONS="${VALET_CONFIG_DISABLE_NERDFONT_ICONS:-}"

# If true, will disable the color output (colors are still needed for interactive mode).
VALET_CONFIG_DISABLE_COLORS="${VALET_CONFIG_DISABLE_COLORS:-}"

# If true, will disable the text wrapping for logs.
VALET_CONFIG_DISABLE_LOG_WRAP="${VALET_CONFIG_DISABLE_LOG_WRAP:-}"

# Sets the maximum width for the log output (used only when log wrapping is enabled).
VALET_CONFIG_LOG_COLUMNS="${VALET_CONFIG_LOG_COLUMNS:-}"

# If true, will disable the timestamp for logs.
VALET_CONFIG_DISABLE_LOG_TIMESTAMP="${VALET_CONFIG_DISABLE_LOG_TIMESTAMP:-}"

# -----------
# Profiler configuration
# -----------
# The path to the file in which to write the profiling information for the command.
# Defaults to the ~/profile_valet_cmd.txt file.
VALET_CONFIG_COMMAND_PROFILING_FILE="${VALET_CONFIG_COMMAND_PROFILING_FILE:-}"

# The profiler log will be cleanup to only keep lines relevant for your command script
# If true, it disables this behavior and you can see all the profiler lines.
VALET_CONFIG_KEEP_ALL_PROFILER_LINES="${VALET_CONFIG_KEEP_ALL_PROFILER_LINES:-}"

# If true, will enable debug mode with profiling for valet ON STARTUP.
# This is intended for Valet developers to debug the startup of Valet.
# To debug your commands, use the -x option.
VALET_CONFIG_STARTUP_PROFILING="${VALET_CONFIG_STARTUP_PROFILING:-}"

# The path to the file in which to write the profiling information for the startup of Valet.
# Defaults to the ~/profile_valet.txt file.
VALET_CONFIG_STARTUP_PROFILING_FILE="${VALET_CONFIG_STARTUP_PROFILING_FILE:-}"

# -----------
# Colors to use in Valet.
# -----------
# You should define a color using an ANSI escape sequence.
# See https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797.
# E.g., this will set the INFO levels logs to blue:
# VALET_CONFIG_COLOR_INFO=$'\e[44m'

# Colors for logs
VALET_CONFIG_COLOR_DEFAULT="${VALET_CONFIG_COLOR_DEFAULT:-}"
VALET_CONFIG_COLOR_DEBUG="${VALET_CONFIG_COLOR_DEBUG:-}"
VALET_CONFIG_COLOR_INFO="${VALET_CONFIG_COLOR_INFO:-}"
VALET_CONFIG_COLOR_WARNING="${VALET_CONFIG_COLOR_WARNING:-}"
VALET_CONFIG_COLOR_SUCCESS="${VALET_CONFIG_COLOR_SUCCESS:-}"
VALET_CONFIG_COLOR_ERROR="${VALET_CONFIG_COLOR_ERROR:-}"
VALET_CONFIG_COLOR_TIMESTAMP="${VALET_CONFIG_COLOR_TIMESTAMP:-}"
VALET_CONFIG_COLOR_HIGHLIGHT="${VALET_CONFIG_COLOR_HIGHLIGHT:-}"

# Colors for help
VALET_CONFIG_COLOR_TITLE="${VALET_CONFIG_COLOR_TITLE:-}"
VALET_CONFIG_COLOR_OPTION="${VALET_CONFIG_COLOR_OPTION:-}"
VALET_CONFIG_COLOR_ARGUMENT="${VALET_CONFIG_COLOR_ARGUMENT:-}"
VALET_CONFIG_COLOR_COMMAND="${VALET_CONFIG_COLOR_COMMAND:-}"

# Colors for the interactive mode
VALET_CONFIG_COLOR_ACTIVE_BUTTON="${VALET_CONFIG_COLOR_ACTIVE_BUTTON:-}"
VALET_CONFIG_COLOR_UNACTIVE_BUTTON="${VALET_CONFIG_COLOR_UNACTIVE_BUTTON:-}"



```

**Error** output:

```log
INFO     Creating the valet config file ⌜/tmp/valet.d/f401-0⌝.
INFO     Opening the valet config file ⌜/tmp/valet.d/f401-0⌝.
```

### Testing selfConfig (should only open, file exists)

Exit code: `0`

**Standard** output:

```plaintext
→ selfConfig
▶ called myEditor: /tmp/valet.d/f401-0
```

**Error** output:

```log
INFO     Opening the valet config file ⌜/tmp/valet.d/f401-0⌝.
```

### Testing selfConfig override no edit

Exit code: `0`

**Standard** output:

```plaintext
→ selfConfig --override --no-edit
```

**Error** output:

```log
INFO     Creating the valet config file ⌜/tmp/valet.d/f401-0⌝.
```

### Testing selfConfig override export

Exit code: `0`

**Standard** output:

```plaintext
→ (selfConfig --override --export-current-values)
▶ called myEditor: /tmp/valet.d/f401-0

cat ${configFile}
#!/usr/bin/env bash
# description: This script declares global variables used to configure Valet
# shellcheck disable=SC2034

# This file is sourced by Valet on startup which allows you to setup global
# variables to configure Valet. You can define the variables here or export
# them in your shell or in your .bashrc file.
#
# Empty variables will be replaced by the default values during the execution.
# You should not define all the variables, only the ones you want to change.

# -----------
# General config
# -----------
# The path to this Valet config file: MUST BE declared outside this file!
# Default to the 'config' file in your config directory.
# VALET_CONFIG_FILE

# The directory in which to find user commands.
# Defaults to the 'valet.d' directory in the user home directory.
VALET_USER_DIRECTORY="${VALET_USER_DIRECTORY:-}"

# The path to the configuration directory, where we store that should be kept between sessions.
# You can backup this directory to keep your configuration.
# Defaults to the '.config' directory in the user home directory.
VALET_CONFIG_DIRECTORY="${VALET_CONFIG_DIRECTORY:-}"

# The path to the directory in which to store the data that should be kept between sessions
# but are not essential for the user configuration (e.g. last choices in menus).
# Defaults to the '.local/state' directory in the user home directory.
VALET_CONFIG_LOCAL_STATE_DIRECTORY="${VALET_CONFIG_LOCAL_STATE_DIRECTORY:-}"

# The directory in which to write work files (small files to capture output of programs).
# You can set it to a tmpfs directory (such as /dev/shm) to speed up the execution of valet.
# Defaults to the temporary directory (TMPDIR or /tmp).
VALET_CONFIG_WORK_FILES_DIRECTORY="${VALET_CONFIG_WORK_FILES_DIRECTORY:-}"

# The directory in which to find executables required by Valet.
# Defaults to the 'bin' directory in the Valet home directory.
# /!\ will dissapear once we get rid of fzf and go with pure bash.
VALET_CONFIG_BIN_PATH="${VALET_CONFIG_BIN_PATH:-}"

# If true, valet will use the executable from the PATH even if they exist in the valet bin/ directory.
VALET_CONFIG_DISABLE_LOCAL_BIN="${VALET_CONFIG_DISABLE_LOCAL_BIN:-}"

# Number of last choices to remember when selecting an item from a command menu.
# Set to 0 to disable this feature and always display items in the alphabetical order.
VALET_CONFIG_REMEMBER_LAST_CHOICES="${VALET_CONFIG_REMEMBER_LAST_CHOICES:-}"

# -----------
# Log/output configuration
# -----------
# If true, will simplify the log output for CI/CD environments:
# will display the logs without colors, without icons, without wrapping lines and with the full date.
VALET_CONFIG_ENABLE_CI_MODE="${VALET_CONFIG_ENABLE_CI_MODE:-true}"

# If true, will disable the icons (using nerd font).
VALET_CONFIG_DISABLE_NERDFONT_ICONS="${VALET_CONFIG_DISABLE_NERDFONT_ICONS:-}"

# If true, will disable the color output (colors are still needed for interactive mode).
VALET_CONFIG_DISABLE_COLORS="${VALET_CONFIG_DISABLE_COLORS:-}"

# If true, will disable the text wrapping for logs.
VALET_CONFIG_DISABLE_LOG_WRAP="${VALET_CONFIG_DISABLE_LOG_WRAP:-}"

# Sets the maximum width for the log output (used only when log wrapping is enabled).
VALET_CONFIG_LOG_COLUMNS="${VALET_CONFIG_LOG_COLUMNS:-20}"

# If true, will disable the timestamp for logs.
VALET_CONFIG_DISABLE_LOG_TIMESTAMP="${VALET_CONFIG_DISABLE_LOG_TIMESTAMP:-}"

# -----------
# Profiler configuration
# -----------
# The path to the file in which to write the profiling information for the command.
# Defaults to the ~/profile_valet_cmd.txt file.
VALET_CONFIG_COMMAND_PROFILING_FILE="${VALET_CONFIG_COMMAND_PROFILING_FILE:-}"

# The profiler log will be cleanup to only keep lines relevant for your command script
# If true, it disables this behavior and you can see all the profiler lines.
VALET_CONFIG_KEEP_ALL_PROFILER_LINES="${VALET_CONFIG_KEEP_ALL_PROFILER_LINES:-}"

# If true, will enable debug mode with profiling for valet ON STARTUP.
# This is intended for Valet developers to debug the startup of Valet.
# To debug your commands, use the -x option.
VALET_CONFIG_STARTUP_PROFILING="${VALET_CONFIG_STARTUP_PROFILING:-}"

# The path to the file in which to write the profiling information for the startup of Valet.
# Defaults to the ~/profile_valet.txt file.
VALET_CONFIG_STARTUP_PROFILING_FILE="${VALET_CONFIG_STARTUP_PROFILING_FILE:-}"

# -----------
# Colors to use in Valet.
# -----------
# You should define a color using an ANSI escape sequence.
# See https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797.
# E.g., this will set the INFO levels logs to blue:
# VALET_CONFIG_COLOR_INFO=$'\e[44m'

# Colors for logs
VALET_CONFIG_COLOR_DEFAULT="${VALET_CONFIG_COLOR_DEFAULT:-}"
VALET_CONFIG_COLOR_DEBUG="${VALET_CONFIG_COLOR_DEBUG:-$'\E[44m'}"
VALET_CONFIG_COLOR_INFO="${VALET_CONFIG_COLOR_INFO:-}"
VALET_CONFIG_COLOR_WARNING="${VALET_CONFIG_COLOR_WARNING:-}"
VALET_CONFIG_COLOR_SUCCESS="${VALET_CONFIG_COLOR_SUCCESS:-}"
VALET_CONFIG_COLOR_ERROR="${VALET_CONFIG_COLOR_ERROR:-}"
VALET_CONFIG_COLOR_TIMESTAMP="${VALET_CONFIG_COLOR_TIMESTAMP:-}"
VALET_CONFIG_COLOR_HIGHLIGHT="${VALET_CONFIG_COLOR_HIGHLIGHT:-}"

# Colors for help
VALET_CONFIG_COLOR_TITLE="${VALET_CONFIG_COLOR_TITLE:-}"
VALET_CONFIG_COLOR_OPTION="${VALET_CONFIG_COLOR_OPTION:-}"
VALET_CONFIG_COLOR_ARGUMENT="${VALET_CONFIG_COLOR_ARGUMENT:-}"
VALET_CONFIG_COLOR_COMMAND="${VALET_CONFIG_COLOR_COMMAND:-}"

# Colors for the interactive mode
VALET_CONFIG_COLOR_ACTIVE_BUTTON="${VALET_CONFIG_COLOR_ACTIVE_BUTTON:-}"
VALET_CONFIG_COLOR_UNACTIVE_BUTTON="${VALET_CONFIG_COLOR_UNACTIVE_BUTTON:-}"



```

**Error** output:

```log
INFO     Creating the valet config file ⌜/tmp/valet.d/f401-0⌝.
INFO     Opening the valet config file ⌜/tmp/valet.d/f401-0⌝.
```

