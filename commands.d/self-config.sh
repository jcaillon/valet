#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../libraries.d/core
  source "$(dirname -- "$(command -v valet)")/libraries.d/core"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> command: self config
#===============================================================

: "---
command: self config
function: selfConfig
author: github.com/jcaillon
shortDescription: Open the configuration file of Valet with your default editor.
description: |-
  Open the configuration file of Valet with your default editor.

  This allows you to set advanced options for Valet.
options:
- name: --no-edit
  description: |-
    Create the configuration file if it does not exist but do not open it.
- name: --override
  description: |-
    Override of the configuration file even if it already exists.
    Unless the option --export-current-values is used, the existing values will be reset.
- name: --export-current-values
  description: |-
    When writing the configuration file, export the current values of the variables.
examples:
- name: self config
  description: |-
    Open the configuration file of Valet with your default editor.
- name: self config --no-edit --override --export-current-values
  description: |-
    Create (or recreate) the configuration file of Valet reusing the possible current values of the variables.
---"
function selfConfig() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  core::getConfigurationDirectory
  local valetConfigFile="${VALET_CONFIG_FILE:-"${RETURNED_VALUE}/config"}"

  if [[ ! -f "${valetConfigFile}" || ${override:-} == "true" ]]; then
    log::info "Creating the valet config file ⌜${valetConfigFile}⌝."
    selfConfig_writeConfigFile "${exportCurrentValues:-}"
  fi

  if [[ ${noEdit:-} == "true" ]]; then
    log::debug "The valet config file ⌜${valetConfigFile}⌝ has been created, now leaving."
    return 0
  fi

  if ! command -v "${EDITOR:-vi}" &>/dev/null; then
    core::fail "The editor ⌜${EDITOR:-vi}⌝ is not available, please set the EDITOR environment variable to your editor (nano, vim, neovim...)."
  fi

  # open the config file
  log::info "Opening the valet config file ⌜${valetConfigFile}⌝."
  "${EDITOR:-vi}" "${valetConfigFile}"
}

function selfConfig_writeConfigFile() {
  if [[ ! -d "${valetConfigFile%/*}" ]]; then
    mkdir -p "${valetConfigFile%/*}"
  fi

  selfConfig::getFileContent "${@}"

  printf '%s\n' "${RETURNED_VALUE}" >"${valetConfigFile}"
}

# Return the content of the valet config file.
# Optionally export the current values of the variables.
#
# - $1: exportCurrentValues: if true, export the current values of the variables.
#
# Returns:
#
# - `RETURNED_VALUE`: the content of the valet config file.
function selfConfig::getFileContent() {
  local exportCurrentValues="${1}"

  # shellcheck disable=SC2086
  unset -v ${!EXPORTED_VALET_*}

  if [[ ${exportCurrentValues} == "true" ]]; then
    log::debug "Exporting the current values of the variables in the valet config file."

    # exporting the value of each VALET_CONFIG_* variable, but quoted
    local exportedVariable
    for exportedVariable in ${!VALET_CONFIG_*} VALET_USER_DIRECTORY; do
      local -n variable="${exportedVariable}"
      if [[ -z "${variable:-}" ]]; then
        continue
      fi
      printf -v "EXPORTED_${exportedVariable}" "%q" "${variable}"
      log::debug "Exported the variable ⌜EXPORTED_${exportedVariable}⌝ with the value ⌜${variable}⌝."
    done
  fi

  RETURNED_VALUE="#""!/usr/bin/env bash
# description: This script declares global variables used to configure Valet
# shellcheck disable=SC2034

# This file is sourced by Valet on startup which allows you to setup global
# variables to configure Valet. You can define the variables here or export
# them in your shell or in your .bashrc file.
#
# Empty variables will be replaced by the default values during the execution.
# You should not define all the variables, only the ones you want to change.

# Do not add custom code to this script, use the custom startup script instead.

# If you break this file, valet will fail to start.
# You can delete it and run the 'valet self config' command to recreate it.

## -----------
## Custom startup script
## -----------

# You can define a custom startup script that will be sourced by Valet on startup.*
# This allows you to define custom functions or variables that will be available in Valet.
# For example, it is convenient to translate CI_* variables to VALET_* variables.
#
# The script should be named 'startup' and be in the same directory as this file.
_CONFIG_DIR=\"\${BASH_SOURCE[0]}\"
if [[ \"\${_CONFIG_DIR}\" != /* ]]; then
  # resolve relative path
  if pushd \"\${_CONFIG_DIR%/*}\" &>/dev/null; then _CONFIG_DIR=\"\${PWD}\"; popd &>/dev/null;
  else _CONFIG_DIR=\"\${PWD}\"; fi
else
  _CONFIG_DIR=\"\${_CONFIG_DIR%/*}\" # strip filename
fi
if [[ -f \"\${_CONFIG_DIR}/startup\" ]]; then
  source \"\${_CONFIG_DIR}/startup\"
fi

## -----------
## General config
## -----------

# The path to this Valet config file: MUST BE declared outside this file!
# Default to the 'config' file in your config directory.
# VALET_CONFIG_FILE

# The directory in which to find user commands.
# Defaults to the '.valet.d' directory in the user home directory.
VALET_USER_DIRECTORY=\"\${VALET_USER_DIRECTORY:-${EXPORTED_VALET_USER_DIRECTORY:-}}\"

# The path to the configuration directory, where we store that should be kept between sessions.
# You can backup this directory to keep your configuration.
# Defaults to the '.config' directory in the user home directory.
VALET_CONFIG_DIRECTORY=\"\${VALET_CONFIG_DIRECTORY:-${EXPORTED_VALET_CONFIG_DIRECTORY:-}}\"

# The path to the directory in which to store the data that should be kept between sessions
# but are not essential for the user configuration (e.g. last choices in menus).
# Defaults to the '.local/state' directory in the user home directory.
VALET_CONFIG_LOCAL_STATE_DIRECTORY=\"\${VALET_CONFIG_LOCAL_STATE_DIRECTORY:-${EXPORTED_VALET_CONFIG_LOCAL_STATE_DIRECTORY:-}}\"

# The directory in which to write work files (small files to capture output of programs).
# You can set it to a tmpfs directory (such as /dev/shm) to speed up the execution of valet.
# Defaults to the temporary directory (TMPDIR or /tmp).
VALET_CONFIG_WORK_FILES_DIRECTORY=\"\${VALET_CONFIG_WORK_FILES_DIRECTORY:-${EXPORTED_VALET_CONFIG_WORK_FILES_DIRECTORY:-}}\"

# Number of last choices to remember when selecting an item from a command menu.
# Set to 0 to disable this feature and always display items in the alphabetical order.
VALET_CONFIG_REMEMBER_LAST_CHOICES=\"\${VALET_CONFIG_REMEMBER_LAST_CHOICES:-${EXPORTED_VALET_CONFIG_REMEMBER_LAST_CHOICES:-}}\"

# The name of a script which will be sourced by Valet on startup if it is present in
# the current directory. This allows you to define custom functions or variables that
# will be available in Valet.
# Defaults to the '.env' file in the current directory.
VALET_CONFIG_DOT_ENV_SCRIPT=\"\${VALET_CONFIG_DOT_ENV_SCRIPT:-${EXPORTED_VALET_CONFIG_DOT_ENV_SCRIPT:-}}\"

# The command (with arguments) that will be used to diff files in the Valet test command.
# The command should have 2 placeholders: %APPROVED_FILE% and %RECEIVED_FILE%. They
# will be replaced by the paths of the approved and received files.
# You can change that command to use your favorite diff tool.
#
# This defaults to:
# - 'delta --paging=never --no-gitconfig --line-numbers --side-by-side %APPROVED_FILE% %RECEIVED_FILE%' if delta is available
# - 'diff --color -u %APPROVED_FILE% %RECEIVED_FILE%' if diff is available
# - 'internalCompare %APPROVED_FILE% %RECEIVED_FILE%' otherwise (internalCompare is a bash function that compares 2 files)
VALET_CONFIG_TEST_DIFF_COMMAND=\"\${VALET_CONFIG_TEST_DIFF_COMMAND:-${EXPORTED_VALET_CONFIG_TEST_DIFF_COMMAND:-}}\"

# Set this to 'true' to disable fuzzy matching of commands and options.
#
# By default, Valet will try to match the command or option you typed with the closest
# command or option available. If you set this to 'true', Valet will only match
# commands and options that are exactly the same as what you typed.
#
# This is useful in a CI environment where you want to make sure that the command
# you typed is the exact command that will be executed.
VALET_CONFIG_STRICT_MATCHING=\"\${VALET_CONFIG_STRICT_MATCHING:-${EXPORTED_VALET_CONFIG_STRICT_MATCHING:-}}\"

# Set this to 'true' to disable all progress bars / spinners in Valet.
# Useful in a CI environment where you want to disable all animations.
VALET_CONFIG_DISABLE_PROGRESS=\"\${VALET_CONFIG_DISABLE_PROGRESS:-${EXPORTED_VALET_CONFIG_DISABLE_PROGRESS:-}}\"

# If true, will enable the icons (using nerd font).
VALET_CONFIG_ENABLE_NERDFONT_ICONS=\"\${VALET_CONFIG_ENABLE_NERDFONT_ICONS:-${EXPORTED_VALET_CONFIG_ENABLE_NERDFONT_ICONS:-}}\"

# If true, will forcibly enable the color output (otherwise we try to detect color support on start).
VALET_CONFIG_ENABLE_COLORS=\"\${VALET_CONFIG_ENABLE_COLORS:-${EXPORTED_VALET_CONFIG_ENABLE_COLORS:-}}\"

## -----------
## Log/output configuration
## -----------

# If true, will disable the text wrapping for logs.
VALET_CONFIG_LOG_DISABLE_WRAP=\"\${VALET_CONFIG_LOG_DISABLE_WRAP:-${EXPORTED_VALET_CONFIG_LOG_DISABLE_WRAP:-}}\"

# Sets the maximum width for the log output (used only when log wrapping is enabled).
VALET_CONFIG_LOG_COLUMNS=\"\${VALET_CONFIG_LOG_COLUMNS:-${EXPORTED_VALET_CONFIG_LOG_COLUMNS:-}}\"

# If true, will disable the time for logs.
VALET_CONFIG_LOG_DISABLE_TIME=\"\${VALET_CONFIG_LOG_DISABLE_TIME:-${EXPORTED_VALET_CONFIG_LOG_DISABLE_TIME:-}}\"

# If true, will print a timestamp instead of simple time in the logs.
VALET_CONFIG_LOG_ENABLE_TIMESTAMP=\"\${VALET_CONFIG_LOG_ENABLE_TIMESTAMP:-${EXPORTED_VALET_CONFIG_LOG_ENABLE_TIMESTAMP:-}}\"

# The file descriptor to use for the logs (defaults to 2 to output to stderr).
VALET_CONFIG_LOG_FD=\"\${VALET_CONFIG_LOG_FD:-${EXPORTED_VALET_CONFIG_LOG_FD:-}}\"

# A path to directory in which we will create 1 log file per valet execution, which
# will contain the valet logs.
VALET_CONFIG_LOG_TO_DIRECTORY=\"\${VALET_CONFIG_LOG_TO_DIRECTORY:-${EXPORTED_VALET_CONFIG_LOG_TO_DIRECTORY:-}}\"

# A string that will be evaluated to set a variable 'logFile' which represents
# the name of the file in which to write the logs.
# Only used if VALET_CONFIG_LOG_TO_DIRECTORY is set.
# The default is equivalent to setting this string to:
# printf -v logFile '%s%(%F_%Hh%Mm%Ss)T%s' 'valet-' \${EPOCHSECONDS} '.log'
VALET_CONFIG_LOG_FILENAME_PATTERN=\"\${VALET_CONFIG_LOG_FILENAME_PATTERN:-${EXPORTED_VALET_CONFIG_LOG_FILENAME_PATTERN:-}}\"

# The bash profiler logs will automatically be cleaned up and improved to make them
# more readable.
# This process can be done in awk (by default if found on your system) or
# you can force to use bash by setting this property to true.
VALET_CONFIG_LOG_CLEANUP_USING_BASH=\"\${VALET_CONFIG_LOG_CLEANUP_USING_BASH:-${EXPORTED_VALET_CONFIG_LOG_CLEANUP_USING_BASH:-}}\"

## -----------
## Log icons configuration
## -----------

# The icon to use for the logs.
VALET_CONFIG_ICON_ERROR=\"\${VALET_CONFIG_ICON_ERROR:-${EXPORTED_VALET_CONFIG_ICON_ERROR:-}}\"
VALET_CONFIG_ICON_WARNING=\"\${VALET_CONFIG_ICON_WARNING:-${EXPORTED_VALET_CONFIG_ICON_WARNING:-}}\"
VALET_CONFIG_ICON_SUCCESS=\"\${VALET_CONFIG_ICON_SUCCESS:-${EXPORTED_VALET_CONFIG_ICON_SUCCESS:-}}\"
VALET_CONFIG_ICON_INFO=\"\${VALET_CONFIG_ICON_INFO:-${EXPORTED_VALET_CONFIG_ICON_INFO:-}}\"
VALET_CONFIG_ICON_DEBUG=\"\${VALET_CONFIG_ICON_DEBUG:-${EXPORTED_VALET_CONFIG_ICON_DEBUG:-}}\"
VALET_CONFIG_ICON_TRACE=\"\${VALET_CONFIG_ICON_TRACE:-${EXPORTED_VALET_CONFIG_ICON_TRACE:-}}\"
VALET_CONFIG_ICON_ERROR_TRACE=\"\${VALET_CONFIG_ICON_ERROR_TRACE:-${EXPORTED_VALET_CONFIG_ICON_ERROR_TRACE:-}}\"
VALET_CONFIG_ICON_EXIT=\"\${VALET_CONFIG_ICON_EXIT:-${EXPORTED_VALET_CONFIG_ICON_EXIT:-}}\"
VALET_CONFIG_ICON_STOPPED=\"\${VALET_CONFIG_ICON_STOPPED:-${EXPORTED_VALET_CONFIG_ICON_STOPPED:-}}\"
VALET_CONFIG_ICON_KILLED=\"\${VALET_CONFIG_ICON_KILLED:-${EXPORTED_VALET_CONFIG_ICON_KILLED:-}}\"

## -----------
## Profiler configuration
## -----------

# The path to the file in which to write the profiling information for the command.
# Defaults to the ~/valet-profiler-{PID}-command.txt file.
VALET_CONFIG_COMMAND_PROFILING_FILE=\"\${VALET_CONFIG_COMMAND_PROFILING_FILE:-${EXPORTED_VALET_CONFIG_COMMAND_PROFILING_FILE:-}}\"

# The profiler log will be cleanup to only keep lines relevant for your command script
# If true, it disables this behavior and you can see all the profiler lines.
VALET_CONFIG_KEEP_ALL_PROFILER_LINES=\"\${VALET_CONFIG_KEEP_ALL_PROFILER_LINES:-${EXPORTED_VALET_CONFIG_KEEP_ALL_PROFILER_LINES:-}}\"

# If true, will enable debug mode with profiling for valet ON STARTUP.
# This is intended for Valet developers to debug the startup of Valet.
# To debug your commands, use the -x option.
VALET_CONFIG_STARTUP_PROFILING=\"\${VALET_CONFIG_STARTUP_PROFILING:-${EXPORTED_VALET_CONFIG_STARTUP_PROFILING:-}}\"

# The path to the file in which to write the profiling information for the startup of Valet.
# Defaults to the ~/valet-profiler-{PID}.txt file.
VALET_CONFIG_STARTUP_PROFILING_FILE=\"\${VALET_CONFIG_STARTUP_PROFILING_FILE:-${EXPORTED_VALET_CONFIG_STARTUP_PROFILING_FILE:-}}\"

## -----------
## Colors to use in Valet.
## -----------

# You should define a color using an ANSI escape sequence.
# See https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797.
# E.g., this will set the INFO levels logs to blue:
# VALET_CONFIG_COLOR_INFO=\$'\e[44m'

VALET_CONFIG_COLOR_DEFAULT=\"\${VALET_CONFIG_COLOR_DEFAULT:-${EXPORTED_VALET_CONFIG_COLOR_DEFAULT:-}}\"

# Colors for logs
VALET_CONFIG_COLOR_DEBUG=\"\${VALET_CONFIG_COLOR_DEBUG:-${EXPORTED_VALET_CONFIG_COLOR_DEBUG:-}}\"
VALET_CONFIG_COLOR_INFO=\"\${VALET_CONFIG_COLOR_INFO:-${EXPORTED_VALET_CONFIG_COLOR_INFO:-}}\"
VALET_CONFIG_COLOR_WARNING=\"\${VALET_CONFIG_COLOR_WARNING:-${EXPORTED_VALET_CONFIG_COLOR_WARNING:-}}\"
VALET_CONFIG_COLOR_SUCCESS=\"\${VALET_CONFIG_COLOR_SUCCESS:-${EXPORTED_VALET_CONFIG_COLOR_SUCCESS:-}}\"
VALET_CONFIG_COLOR_ERROR=\"\${VALET_CONFIG_COLOR_ERROR:-${EXPORTED_VALET_CONFIG_COLOR_ERROR:-}}\"
VALET_CONFIG_COLOR_TIMESTAMP=\"\${VALET_CONFIG_COLOR_TIMESTAMP:-${EXPORTED_VALET_CONFIG_COLOR_TIMESTAMP:-}}\"
VALET_CONFIG_COLOR_HIGHLIGHT=\"\${VALET_CONFIG_COLOR_HIGHLIGHT:-${EXPORTED_VALET_CONFIG_COLOR_HIGHLIGHT:-}}\"

# Colors for help
VALET_CONFIG_COLOR_TITLE=\"\${VALET_CONFIG_COLOR_TITLE:-${EXPORTED_VALET_CONFIG_COLOR_TITLE:-}}\"
VALET_CONFIG_COLOR_OPTION=\"\${VALET_CONFIG_COLOR_OPTION:-${EXPORTED_VALET_CONFIG_COLOR_OPTION:-}}\"
VALET_CONFIG_COLOR_ARGUMENT=\"\${VALET_CONFIG_COLOR_ARGUMENT:-${EXPORTED_VALET_CONFIG_COLOR_ARGUMENT:-}}\"
VALET_CONFIG_COLOR_COMMAND=\"\${VALET_CONFIG_COLOR_COMMAND:-${EXPORTED_VALET_CONFIG_COLOR_COMMAND:-}}\"

# Colors for the interactive mode
VALET_CONFIG_COLOR_ACTIVE_BUTTON=\"\${VALET_CONFIG_COLOR_ACTIVE_BUTTON:-${EXPORTED_VALET_CONFIG_COLOR_ACTIVE_BUTTON:-}}\"
VALET_CONFIG_COLOR_INACTIVE_BUTTON=\"\${VALET_CONFIG_COLOR_INACTIVE_BUTTON:-${EXPORTED_VALET_CONFIG_COLOR_INACTIVE_BUTTON:-}}\"

# Colors for fsfs
VALET_CONFIG_FSFS_RESET_TEXT=\"\${VALET_CONFIG_FSFS_RESET_TEXT:-${EXPORTED_VALET_CONFIG_FSFS_RESET_TEXT:-}}\"
VALET_CONFIG_FSFS_STATIC=\"\${VALET_CONFIG_FSFS_STATIC:-${EXPORTED_VALET_CONFIG_FSFS_STATIC:-}}\"
VALET_CONFIG_FSFS_FOCUS=\"\${VALET_CONFIG_FSFS_FOCUS:-${EXPORTED_VALET_CONFIG_FSFS_FOCUS:-}}\"
VALET_CONFIG_FSFS_FOCUS_RESET=\"\${VALET_CONFIG_FSFS_FOCUS_RESET:-${EXPORTED_VALET_CONFIG_FSFS_FOCUS_RESET:-}}\"
VALET_CONFIG_FSFS_LETTER_HIGHLIGHT=\"\${VALET_CONFIG_FSFS_LETTER_HIGHLIGHT:-${EXPORTED_VALET_CONFIG_FSFS_LETTER_HIGHLIGHT:-}}\"
VALET_CONFIG_FSFS_LETTER_HIGHLIGHT_RESET=\"\${VALET_CONFIG_FSFS_LETTER_HIGHLIGHT_RESET:-${EXPORTED_VALET_CONFIG_FSFS_LETTER_HIGHLIGHT_RESET:-}}\"
VALET_CONFIG_FSFS_SELECTED_ITEM=\"\${VALET_CONFIG_FSFS_SELECTED_ITEM:-${EXPORTED_VALET_CONFIG_FSFS_SELECTED_ITEM:-}}\"
VALET_CONFIG_FSFS_SELECTED_ITEM_RESET=\"\${VALET_CONFIG_FSFS_SELECTED_ITEM_RESET:-${EXPORTED_VALET_CONFIG_FSFS_SELECTED_ITEM_RESET:-}}\"
VALET_CONFIG_FSFS_PROMPT_STRING=\"\${VALET_CONFIG_FSFS_PROMPT_STRING:-${EXPORTED_VALET_CONFIG_FSFS_PROMPT_STRING:-}}\"
VALET_CONFIG_FSFS_PROMPT_STRING_RESET=\"\${VALET_CONFIG_FSFS_PROMPT_STRING_RESET:-${EXPORTED_VALET_CONFIG_FSFS_PROMPT_STRING_RESET:-}}\"
VALET_CONFIG_FSFS_COUNT=\"\${VALET_CONFIG_FSFS_COUNT:-${EXPORTED_VALET_CONFIG_FSFS_COUNT:-}}\"
VALET_CONFIG_FSFS_COUNT_RESET=\"\${VALET_CONFIG_FSFS_COUNT_RESET:-${EXPORTED_VALET_CONFIG_FSFS_COUNT_RESET:-}}\"

## -----------
## Interactive mode configuration.
## -----------

# Change the default progress bar template.
# See interactive::startProgress.
VALET_CONFIG_PROGRESS_BAR_TEMPLATE=\"\${VALET_CONFIG_PROGRESS_BAR_TEMPLATE:-${EXPORTED_VALET_CONFIG_PROGRESS_BAR_TEMPLATE:-}}\"

# Change the default progress bar size
VALET_CONFIG_PROGRESS_BAR_SIZE=\"\${VALET_CONFIG_PROGRESS_BAR_SIZE:-${EXPORTED_VALET_CONFIG_PROGRESS_BAR_SIZE:-}}\"

# Change the default time between two frames for the animation of the spinner in the progress
# (in seconds, can be a float number).
# See interactive::startProgress.
VALET_CONFIG_PROGRESS_ANIMATION_DELAY=\"\${VALET_CONFIG_PROGRESS_ANIMATION_DELAY:-${EXPORTED_VALET_CONFIG_PROGRESS_ANIMATION_DELAY:-}}\"

# The default number of animation frames to wait between two updates of the progress bar.
VALET_CONFIG_PROGRESS_BAR_UPDATE_INTERVAL=\"\${VALET_CONFIG_PROGRESS_BAR_UPDATE_INTERVAL:-${EXPORTED_VALET_CONFIG_PROGRESS_BAR_UPDATE_INTERVAL:-}}\"

# Change the default spinner characters (one character represents one frame of the animation).
# See interactive::startProgress.
VALET_CONFIG_SPINNER_CHARACTERS=\"\${VALET_CONFIG_SPINNER_CHARACTERS:-${EXPORTED_VALET_CONFIG_SPINNER_CHARACTERS:-}}\"

# The default character to use to represent the selected item in the interactive mode.
# Used in fsfs, autocompletion, etc...
VALET_CONFIG_INTERACTIVE_SELECTED_ITEM_CHARACTER=\"\${VALET_CONFIG_INTERACTIVE_SELECTED_ITEM_CHARACTER:-${EXPORTED_VALET_CONFIG_INTERACTIVE_SELECTED_ITEM_CHARACTER:-}}\"

# The default character to use to represent the prompt in the interactive mode.
VALET_CONFIG_INTERACTIVE_PROMPT_CHARACTER=\"\${VALET_CONFIG_INTERACTIVE_PROMPT_CHARACTER:-${EXPORTED_VALET_CONFIG_INTERACTIVE_PROMPT_CHARACTER:-}}\"


## -----------
## Other configs.
## -----------

# If true, will enable the automatic bump of the version of Valet on build.
# Intended for Valet developers only.
VALET_CONFIG_BUMP_VERSION_ON_BUILD=\"\${VALET_CONFIG_BUMP_VERSION_ON_BUILD:-${EXPORTED_VALET_CONFIG_BUMP_VERSION_ON_BUILD:-}}\"

"
}