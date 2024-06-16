```bash {linenos=table,linenostart=1,filename="~/.config/valet/config"}
#!/usr/bin/env bash
# description: This script declares global variables used to configure Valet
# shellcheck disable=SC2034

# This file is sourced by Valet on startup which allows you to setup global
# variables to configure Valet. You can define the variables here or export
# them in your shell or in your .bashrc file.
#
# Empty variables will be replaced by the default values during the execution.
# You should not define all the variables, only the ones you want to change.

# If you break this file, valet will fail to start.
# You can delete it and run the 'valet self config' command to recreate it.

# -----------
# Custom startup script
# -----------
# You can define a custom startup script that will be sourced by Valet on startup.*
# This allows you to define custom functions or variables that will be available in Valet.
# For example, it is convenient to translate CI_* variables to VALET_* variables.
#
# The script should be named 'startup' and be in the same directory as this file.
_CONFIG_DIR="${BASH_SOURCE[0]}"
if [[ "${_CONFIG_DIR}" != /* ]]; then
  # resolve relative path
  if pushd "${_CONFIG_DIR%/*}" &>/dev/null; then _CONFIG_DIR="${PWD}"; popd &>/dev/null;
  else _CONFIG_DIR="${PWD}"; fi
else
  _CONFIG_DIR="${_CONFIG_DIR%/*}" # strip filename
fi
if [[ -f "${_CONFIG_DIR}/startup" ]]; then
  source "${_CONFIG_DIR}/startup"
fi

# -----------
# General config
# -----------
# The path to this Valet config file: MUST BE declared outside this file!
# Default to the 'config' file in your config directory.
# VALET_CONFIG_FILE

# The directory in which to find user commands.
# Defaults to the '.valet.d' directory in the user home directory.
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

# Number of last choices to remember when selecting an item from a command menu.
# Set to 0 to disable this feature and always display items in the alphabetical order.
VALET_CONFIG_REMEMBER_LAST_CHOICES="${VALET_CONFIG_REMEMBER_LAST_CHOICES:-}"

# The name of a script which will be sourced by Valet on startup if it is present in
# the current directory. This allows you to define custom functions or variables that
# will be available in Valet.
# Defaults to the '.env' file in the current directory.
VALET_CONFIG_DOT_ENV_SCRIPT="${VALET_CONFIG_DOT_ENV_SCRIPT:-}"

# -----------
# Log/output configuration
# -----------
# If true, will enable the icons (using nerd font).
VALET_CONFIG_ENABLE_NERDFONT_ICONS="${VALET_CONFIG_ENABLE_NERDFONT_ICONS:-}"

# If true, will forcibly enable the color output (otherwise we try to detect color support on start).
VALET_CONFIG_ENABLE_COLORS="${VALET_CONFIG_ENABLE_COLORS:-}"

# If true, will disable the text wrapping for logs.
VALET_CONFIG_DISABLE_LOG_WRAP="${VALET_CONFIG_DISABLE_LOG_WRAP:-}"

# Sets the maximum width for the log output (used only when log wrapping is enabled).
VALET_CONFIG_LOG_COLUMNS="${VALET_CONFIG_LOG_COLUMNS:-}"

# If true, will disable the time for logs.
VALET_CONFIG_DISABLE_LOG_TIME="${VALET_CONFIG_DISABLE_LOG_TIME:-}"

# If true, will print a timestamp instead of simple time in the logs.
VALET_CONFIG_ENABLE_LOG_TIMESTAMP="${VALET_CONFIG_ENABLE_LOG_TIMESTAMP:-}"

# The file descriptor to use for the logs (defaults to 2 to output to stderr).
VALET_CONFIG_LOG_FD="${VALET_CONFIG_LOG_FD:-}"

# A path to directory in which we will create 1 log file per valet execution, which
# will contain the valet logs.
VALET_CONFIG_LOG_TO_DIRECTORY="${VALET_CONFIG_LOG_TO_DIRECTORY:-}"

# A string that will be evaluated to set a variable 'logFile' which represents
# the name of the file in which to write the logs.
# Only used if VALET_CONFIG_LOG_TO_DIRECTORY is set.
# The default is equivalent to setting this string to:
# printf -v logFile '%s%(%F_%Hh%Mm%Ss)T%s' 'valet-' ${EPOCHSECONDS} '.log'
VALET_CONFIG_LOG_FILENAME_PATTERN="${VALET_CONFIG_LOG_FILENAME_PATTERN:-}"

# -----------
# Log icons configuration
# -----------
# The icon to use for the logs.
VALET_CONFIG_ICON_ERROR="${VALET_CONFIG_ICON_ERROR:-}"
VALET_CONFIG_ICON_WARNING="${VALET_CONFIG_ICON_WARNING:-}"
VALET_CONFIG_ICON_SUCCESS="${VALET_CONFIG_ICON_SUCCESS:-}"
VALET_CONFIG_ICON_INFO="${VALET_CONFIG_ICON_INFO:-}"
VALET_CONFIG_ICON_DEBUG="${VALET_CONFIG_ICON_DEBUG:-}"
VALET_CONFIG_ICON_TRACE="${VALET_CONFIG_ICON_TRACE:-}"
VALET_CONFIG_ICON_ERROR_TRACE="${VALET_CONFIG_ICON_ERROR_TRACE:-}"
VALET_CONFIG_ICON_EXIT="${VALET_CONFIG_ICON_EXIT:-}"
VALET_CONFIG_ICON_STOPPED="${VALET_CONFIG_ICON_STOPPED:-}"
VALET_CONFIG_ICON_KILLED="${VALET_CONFIG_ICON_KILLED:-}"

# -----------
# Profiler configuration
# -----------
# The path to the file in which to write the profiling information for the command.
# Defaults to the ~/valet-profiler-{PID}-command.txt file.
VALET_CONFIG_COMMAND_PROFILING_FILE="${VALET_CONFIG_COMMAND_PROFILING_FILE:-}"

# The profiler log will be cleanup to only keep lines relevant for your command script
# If true, it disables this behavior and you can see all the profiler lines.
VALET_CONFIG_KEEP_ALL_PROFILER_LINES="${VALET_CONFIG_KEEP_ALL_PROFILER_LINES:-}"

# If true, will enable debug mode with profiling for valet ON STARTUP.
# This is intended for Valet developers to debug the startup of Valet.
# To debug your commands, use the -x option.
VALET_CONFIG_STARTUP_PROFILING="${VALET_CONFIG_STARTUP_PROFILING:-}"

# The path to the file in which to write the profiling information for the startup of Valet.
# Defaults to the ~/valet-profiler-{PID}.txt file.
VALET_CONFIG_STARTUP_PROFILING_FILE="${VALET_CONFIG_STARTUP_PROFILING_FILE:-}"

# -----------
# Colors to use in Valet.
# -----------
# You should define a color using an ANSI escape sequence.
# See https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797.
# E.g., this will set the INFO levels logs to blue:
# VALET_CONFIG_COLOR_INFO=$'\e[44m'

VALET_CONFIG_COLOR_DEFAULT="${VALET_CONFIG_COLOR_DEFAULT:-}"

# Colors for logs
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

# Colors for fsfs
VALET_COLOR_FSFS_RESET_TEXT="${VALET_COLOR_FSFS_RESET_TEXT:-}"
VALET_COLOR_FSFS_STATIC="${VALET_COLOR_FSFS_STATIC:-}"
VALET_COLOR_FSFS_FOCUS="${VALET_COLOR_FSFS_FOCUS:-}"
VALET_COLOR_FSFS_FOCUS_RESET="${VALET_COLOR_FSFS_FOCUS_RESET:-}"
VALET_COLOR_FSFS_LETTER_HIGHLIGHT="${VALET_COLOR_FSFS_LETTER_HIGHLIGHT:-}"
VALET_COLOR_FSFS_LETTER_HIGHLIGHT_RESET="${VALET_COLOR_FSFS_LETTER_HIGHLIGHT_RESET:-}"
VALET_COLOR_FSFS_SELECTED_ITEM="${VALET_COLOR_FSFS_SELECTED_ITEM:-}"
VALET_COLOR_FSFS_SELECTED_ITEM_RESET="${VALET_COLOR_FSFS_SELECTED_ITEM_RESET:-}"
VALET_COLOR_FSFS_PROMPT_STRING="${VALET_COLOR_FSFS_PROMPT_STRING:-}"
VALET_COLOR_FSFS_PROMPT_STRING_RESET="${VALET_COLOR_FSFS_PROMPT_STRING_RESET:-}"
VALET_COLOR_FSFS_COUNT="${VALET_COLOR_FSFS_COUNT:-}"
VALET_COLOR_FSFS_COUNT_RESET="${VALET_COLOR_FSFS_COUNT_RESET:-}"

# -----------
# Other configs.
# -----------

# If true, will enable the automatic bump of the version of Valet on build.
# Intended for Valet developers only.
VALET_CONFIG_BUMP_VERSION_ON_BUILD="${VALET_CONFIG_BUMP_VERSION_ON_BUILD:-}"


```

> Documentation generated for the version 0.17.112 (2024-06-06).
