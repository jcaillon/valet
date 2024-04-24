#!/usr/bin/env bash
set -Eeu -o pipefail
# author: github.com/jcaillon
# Title:         valet.d/build
# Description:   This script is called during development to build the commands script.
#                It reads all the files in which we could find command definitions and generates commands script.
#                You can call this script directly in case calling ⌜valet self build⌝ is broken:
#                $ ./valet.d/commands.d/self-build.sh

_CMD_INCLUDED=1

if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  _NOT_EXECUTED_FROM_VALET=true

  _VALETD_DIR="${BASH_SOURCE[0]}"
  if [[ "${_VALETD_DIR}" != /* ]]; then
    if pushd "${_VALETD_DIR%/*}" &>/dev/null; then _VALETD_DIR="${PWD}"; popd &>/dev/null || :;
    else _VALETD_DIR="${PWD}"; fi
  else _VALETD_DIR="${_VALETD_DIR%/*}"; fi

  # shellcheck source=../core
  source "${_VALETD_DIR%/*}/core"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=self-build-utils
source "${GLOBAL_VALET_HOME}/valet.d/commands.d/self-build-utils"
# shellcheck source=../lib-array
source "${GLOBAL_VALET_HOME}/valet.d/lib-array"
# shellcheck source=../lib-io
source "${GLOBAL_VALET_HOME}/valet.d/lib-io"
# shellcheck source=../lib-string
source "${GLOBAL_VALET_HOME}/valet.d/lib-string"

#===============================================================
# >>> command: self build
#===============================================================
: "---
command: self build
function: selfBuild
author: github.com/jcaillon
shortDescription: Re-build the menu of valet from your commands.
description: |-
  This command can be used to re-build the menu / help / options / arguments in case you have modified, added or removed a Valet command definition.

  Please check https://github.com/jcaillon/valet/blob/main/docs/create-new-command.md or check the examples in ⌜examples.d⌝ directory to learn how to create and modified your commands.

  This scripts:
    - Makes a list of all the elligible files in which we could find command definitions.
    - For each file in this list, extract the command definitions.
    - Build your commands file (in your valet user directory) from these definitions.

  You can call this script directly in case calling ⌜valet self build⌝ is broken:

  → ./valet.d/commands.d.sh
options:
- name: -d, --user-directory <path>
  description: |-
    Specify the directory in which to look for your command scripts.

    This defaults to the path defined in the environment variable VALET_USER_DIRECTORY=\"my/path\" or to ⌜~/.valet.d⌝.

    Can be empty to only build the core commands.
- name: -o, --output <path>
  description: |-
    Specify the file path in which to write the command definition variables.

    This defaults to the ⌜commands⌝ file in your Valet user directory.

    Can be empty to not write the file.
---"
function selfBuild() {
  local userDirectory outputFile

  # parse arguments manually otherwise we have to count on cmd to be valid
  while [[ $# -gt 0 ]]; do
    case "${1}" in
    -d | --user-directory)
      shift
      userDirectory="${1}"
      ;;
    -o | --output)
      shift
      outputFile="${1}"
      ;;
    -*)
      if [[ -v CMD_OPTS_selfBuild ]]; then
        main::fuzzyFindOption "${1}" ${CMD_OPTS_selfBuild[*]}
      else
        LAST_RETURNED_VALUE=""
      fi
      core::fail "Unknown option ⌜${1}⌝${LAST_RETURNED_VALUE:-}." ;;
    *) core::fail "This command takes no arguments." ;;
    esac
    shift
  done

  core::getUserDirectory && userDirectory="${userDirectory-${LAST_RETURNED_VALUE}}"
  outputFile="${outputFile-${userDirectory}/commands}"

  io::toAbsolutePath "${GLOBAL_VALET_HOME}" && GLOBAL_VALET_HOME="${LAST_RETURNED_VALUE}"

  # list all the files in which we need to find command definitions
  log::info "Building the valet user commands from the user directory ⌜${userDirectory}⌝."
  local -a commandDefinitionFiles
  commandDefinitionFiles=(
    "${GLOBAL_VALET_HOME}/valet"
    "${GLOBAL_VALET_HOME}/valet.d/commands.d"/*.sh
  )
  if [[ -d "${userDirectory}" ]]; then
    local file listOfDirectories currentDirectory

    # the shopt globstar does not include files under symbolic link directories
    # so we need to manually force the search in these directories
    listOfDirectories="${userDirectory}"$'\n'
    while [[ -n "${listOfDirectories}" ]]; do
      currentDirectory="${listOfDirectories%%$'\n'*}"
      listOfDirectories="${listOfDirectories#*$'\n'}"
      log::debug "Searching for command definitions in ⌜${currentDirectory}⌝."
      log::debug "listOfDirectories: ⌜${listOfDirectories}⌝."
      for file in "${currentDirectory}"/**; do
        local fileBasename="${file##*/}"
        if [[ -d "${file}" && ${fileBasename} != "."* && ${fileBasename} != "tests.d" ]]; then
          # if directory we need to add it to the search list
          # except if it starts with a . or if it is a tests.d directory
          listOfDirectories+="${file}"$'\n'
          log::debug "adding directory ⌜${file}⌝ to the search list."
          continue
        elif [[ "${file}" != *".sh" ]]; then
          # skip all files not ending with .sh
          continue
        fi
        log::debug "Considering file ⌜${file}⌝."
        commandDefinitionFiles+=("${file}")
      done
    done
  elif [[ -n "${userDirectory}" ]]; then
    log::warning "Skipping user directory ⌜${userDirectory}⌝ because it does not exist."
  else
    log::info "Skipping user directory because it was empty."
  fi

  if log::isDebugEnabled; then
    local IFS=$'\n'
    log::debug "Will extract command definitions from the following files:"$'\n'"${commandDefinitionFiles[*]}"
    unset IFS
  fi

  # make sure to unset all previous CMD_* variables
  unset -v ${!CMD_*} \
    SELF_BUILD_ERRORS

  # extract the command definitions to variables
  extractCommandDefinitionsToVariables "${commandDefinitionFiles[@]}"

  summarize

  unset CMD_ALL_COMMAND_SELECTION_HIDDEN_ITEMS_ARRAY

  if [[ -n "${SELF_BUILD_ERRORS:-}" ]]; then
    core::fail "The valet user commands have not been successfully built. Please check the following errors:"$'\n'"${SELF_BUILD_ERRORS}"
  fi

  if [[ -n "${outputFile}" ]]; then
    writeCommandDefinitionVariablesToFile "${outputFile}"
    log::info "The command definition variables have been written to ⌜${outputFile}⌝."
  fi

  if [[ ${VALET_CONFIG_BUMP_VERSION_ON_BUILD:-false} == "true" ]]; then
    bumpValetBuildVersion
  fi

  log::success "The valet user commands have been successfully built"
}

#===============================================================
# >>> Internal functions
#===============================================================

# This function summarizes the command definitions that have been extracted for the user.
function summarize() {
  local -i numberOfVars=0
  local var
  for var in ${!CMD_*}; do
    numberOfVars+=1
  done

  local message="== Summary of the commands =="$'\n\n'
  message+="- Number of variables declared: ⌜${numberOfVars}⌝."$'\n'
  message+="- Number of functions: ⌜${#CMD_ALL_FUNCTIONS_ARRAY[@]}⌝."$'\n'
  message+="- Number of commands: ⌜${#CMD_ALL_COMMANDS_ARRAY[@]}⌝."$'\n'
  message+="- Maximum sub command level: ⌜${CMD_MAX_SUB_COMMAND_LEVEL:-0}⌝."$'\n'

  message+=$'\n'"== List of all the commands =="$'\n\n'
  local IFS=$'\n'
  message+="${CMD_ALL_COMMAND_SELECTION_ITEMS_ARRAY[*]}"$'\n'

  message+=$'\n'"== List of all the hidden commands =="$'\n\n'
  message+="${CMD_ALL_COMMAND_SELECTION_HIDDEN_ITEMS_ARRAY[*]}"$'\n'

  log::info "${message}"
}

# Bump the valet build version by one patch.
function bumpValetBuildVersion() {
  local versionFile
  versionFile="${GLOBAL_VALET_HOME}/valet.d/version"

  io::readFile "${versionFile}"
  local currentVersion="${LAST_RETURNED_VALUE:-0.0.0}"
  currentVersion="${currentVersion%%$'\n'*}"

  string::bumpSemanticVersion "${currentVersion}" "patch" "false"

  echo -n "${LAST_RETURNED_VALUE}" >"${versionFile}"

  log::info "The valet build version has been bumped to ⌜${LAST_RETURNED_VALUE}⌝."
}

# This function extracts the command definitions from the files and stores them in
# CMD_BUILD_* global variables.
#
# $@: The files to extract from.
function extractCommandDefinitionsToVariables() {
  while [[ $# -gt 0 ]]; do
    local file="${1}"
    shift
    log::info "Extracting commands from ⌜${file}⌝."
    extractCommandYamls "${file}"
    local content
    for content in "${LAST_RETURNED_ARRAY[@]}"; do

      if log::isDebugEnabled; then log::debug "Extracting command definition for: ⌜${content%%$'\n'*}...⌝."; fi

      extractCommandDefinitionToVariables "${content}"

      local function command
      string::trimAll "${TEMP_CMD_BUILD_function:-}" && function="${LAST_RETURNED_VALUE}"
      string::trimAll "${TEMP_CMD_BUILD_command:-}" && command="${LAST_RETURNED_VALUE}"

      # trim the leading "valet" from the command
      command="${command#valet }"
      command="${command#valet}"

      log::info "                         ├── ⌜${command}⌝."

      io::toAbsolutePath "${file}" && TEMP_CMD_BUILD_fileToSource="${LAST_RETURNED_VALUE}"
      TEMP_CMD_BUILD_fileToSource="${TEMP_CMD_BUILD_fileToSource#"${GLOBAL_VALET_HOME}"/}"

      # make sure that all these arrays exists and have the same size
      array::makeArraysSameSize TEMP_CMD_BUILD_options_name TEMP_CMD_BUILD_options_description TEMP_CMD_BUILD_options_noEnvironmentVariable
      array::makeArraysSameSize TEMP_CMD_BUILD_arguments_name TEMP_CMD_BUILD_arguments_description
      array::makeArraysSameSize TEMP_CMD_BUILD_examples_name TEMP_CMD_BUILD_examples_description

      if log::isDebugEnabled; then
        io::invoke declare -p ${!TEMP_CMD_BUILD_*}
        log::debug "Declared variables for this command:"$'\n'"${LAST_RETURNED_VALUE}"
      fi

      # verify that the command definition is valid
      verifyCommandDefinition "${function}" "${command}"

      # declare common variables
      declareFinalCommandDefinitionCommonVariables "${function}" "${command}"

      # declare help variables
      declareFinalCommandDefinitionHelpVariables "${function}"

      # declare options and arguments for the parser
      declareFinalCommandDefinitionParserVariables "${function}"
    done
  done

  # declare complementary variables
  declareOtherCommmandVariables
}

# This function uses the global TEMP_CMD_BUILD_* variables to declare the final
# command definition variables that are needed in the commands file.
#
# Declared variables:
# CMD_ALL_FUNCTIONS_ARRAY = array of all the functions callable with a command
# CMD_ALL_COMMANDS_ARRAY = array of all the commands
# CMD_ALL_MENU_COMMANDS_ARRAY = array of all the commands that should open a sub menu to show a list of sub commands
# CMD_MAX_SUB_COMMAND_LEVEL = maximum number of sub command levels; e.g. 'command subcommand subsubcommand' has 2 levels
# CMD_MAX_COMMAND_WIDTH = get the maximum width (nb characters) among all commands
# CMD_FUNCTION_NAME_yyy = the function name for the given yyy command
# CMD_COMMAND_xxx = the command of the function
# CMD_FILETOSOURCE_xxx = the file to source for the function
# CMD_HIDEINMENU_xxx = true to hide the command in the menu
function declareFinalCommandDefinitionCommonVariables() {
  local function command
  function="${1}"
  command="${2}"

  # add to the list of all the functions
  CMD_ALL_FUNCTIONS_ARRAY+=("${function}")

  # add to the list of all the commands
  if [[ -n "${command}" ]]; then
    CMD_ALL_COMMANDS_ARRAY+=("${command}")
  fi

  # get the maximum number of sub command levels; e.g. 'command subcommand subsubcommand' has 2 levels,
  # we count the number of spaces in the command name
  local -i level=-1
  local word
  # shellcheck disable=SC2034
  for word in ${command}; do
    level+=1
  done
  if [[ "${level}" -gt "${CMD_MAX_SUB_COMMAND_LEVEL:--1}" ]]; then
    CMD_MAX_SUB_COMMAND_LEVEL="${level}"
  fi

  # make a list of all the commands that should open a sub menu to show a list of sub commands
  # takes each word of the command except the last one
  local parentCommand=""
  local -i index=0
  for word in ${command}; do
    if [[ index -lt level ]]; then
      parentCommand+=" ${word}"
    else
      break
    fi
    index+=1
  done
  parentCommand="${parentCommand# }"
  if [[ -n "${parentCommand}" ]]; then
    if ! array::appendIfNotPresent CMD_ALL_MENU_COMMANDS_ARRAY "${parentCommand# }"; then
      declare -g "CMD_FUNCTION_NAME_${parentCommand//[^[:alnum:]]/_}"="_menu"
    fi
  fi

  # get the maximum width (nb characters) among all commands
  local -i width="${#command}"
  if [[ "${width}" -gt "${CMD_MAX_COMMAND_WIDTH:-0}" ]]; then
    CMD_MAX_COMMAND_WIDTH="${width}"
  fi

  # get the function name from a command
  declare -g "CMD_FUNCTION_NAME_${command//[^[:alnum:]]/_}"="${function}"

  # declare basic properties
  declare -g "CMD_COMMAND_${function}"="${command}"
  declare -g "CMD_FILETOSOURCE_${function}"="${TEMP_CMD_BUILD_fileToSource}"
  if [[ ${TEMP_CMD_BUILD_hideInMenu:-false} == "true" ]]; then
    declare -g "CMD_HIDEINMENU_${function}"=true
  fi
}

# This function uses the global TEMP_CMD_BUILD_* variables to declare the final
# command definition variables that are needed in the commands file.
#
# Declared variables:
# CMD_SHORTDESCRIPTION_xxx = the short description of the function
# CMD_DESCRIPTION_xxx = the description of the function
# CMD_SUDO_xxx = true if the function requires sudo
# CMD_EXAMPLES_NAME_xxx = array with each example name
# CMD_EXAMPLES_DESCRIPTION_xxx = array with each example description
# CMD_OPTIONS_NAME_xxx = array with each option name
# CMD_OPTIONS_DESCRIPTION_xxx = array with each option description
# CMD_ARGUMENTS_NAME_xxx = array with each argument name
# CMD_ARGUMENTS_DESCRIPTION_xxx = array with each argument description
#
# shellcheck disable=SC2154
function declareFinalCommandDefinitionHelpVariables() {
  local function="${1}"

  declare -g "CMD_SHORT_DESCRIPTION_${function}"="${TEMP_CMD_BUILD_shortDescription}"
  declare -g "CMD_DESCRIPTION_${function}"="${TEMP_CMD_BUILD_description}"
  if [[ -n "${TEMP_CMD_BUILD_sudo:-}" ]]; then declare -g "CMD_SUDO_${function}"="${TEMP_CMD_BUILD_sudo}"; fi

  # add the default --help option
  TEMP_CMD_BUILD_options_name+=("-h, --help")
  TEMP_CMD_BUILD_options_description+=("Display the help for this command.")
  TEMP_CMD_BUILD_options_noEnvironmentVariable+=("true")

  # for each option, add the text to specify the possibility to define it with an env var
  local -i index
  local optionValue
  for ((index = 0; index < ${#TEMP_CMD_BUILD_options_name[@]}; index++)); do
    if [[ "${TEMP_CMD_BUILD_options_noEnvironmentVariable[index]}" != "true" ]]; then
      optionValue="${TEMP_CMD_BUILD_options_name[index]}"
      if [[ ${optionValue} == *"<"* ]]; then optionValue="<${optionValue##*<}"; else optionValue="true"; fi
      extractFirstLongNameFromOptionString "${TEMP_CMD_BUILD_options_name[index]}"
      string::kebabCaseToSnakeCase "${LAST_RETURNED_VALUE}"
      TEMP_CMD_BUILD_options_description[index]+=$'\n'"This option can be set by exporting the variable VALET_${LAST_RETURNED_VALUE}='${optionValue}'."
    fi
  done

  # declare examples, arguments and options for the help
  if [[ "${#TEMP_CMD_BUILD_examples_name[@]}" -gt 0 ]]; then eval "CMD_EXAMPLES_NAME_${function}=(\"\${TEMP_CMD_BUILD_examples_name[@]}\")"; fi
  if [[ "${#TEMP_CMD_BUILD_examples_description[@]}" -gt 0 ]]; then eval "CMD_EXAMPLES_DESCRIPTION_${function}=(\"\${TEMP_CMD_BUILD_examples_description[@]}\")"; fi
  eval "CMD_OPTIONS_NAME_${function}=(\"\${TEMP_CMD_BUILD_options_name[@]}\")"
  eval "CMD_OPTIONS_DESCRIPTION_${function}=(\"\${TEMP_CMD_BUILD_options_description[@]}\")"
  if [[ "${#TEMP_CMD_BUILD_arguments_name[@]}" -gt 0 ]]; then eval "CMD_ARGUMENTS_NAME_${function}=(\"\${TEMP_CMD_BUILD_arguments_name[@]}\")"; fi
  if [[ "${#TEMP_CMD_BUILD_arguments_description[@]}" -gt 0 ]]; then eval "CMD_ARGUMENTS_DESCRIPTION_${function}=(\"\${TEMP_CMD_BUILD_arguments_description[@]}\")"; fi

  return 0
}

# Declare the following variables:
# CMD_OPTS_xxx = array with each option separated by a space
# CMD_OPTS_HAS_VALUE_xxx = array which indicates for each option if it has a value or not
# CMD_OPTS_NAME_xxx = array with each option names in camel case
# CMD_OPTS_NAME_SC_xxx = array with each option names in snake case
# CMD_ARGS_NAME_xxx = array with each argument names in camel case
# CMD_ARGS_LAST_IS_ARRAY_xxx = true/false to indicate if the last argument of the function is an array (contains with ...)
# CMD_ARGS_NB_OPTIONAL_xxx = integer to indicate the number of optional arguments (contains ?)
function declareFinalCommandDefinitionParserVariables() {
  local function="${1}"

  # for each option
  local -i index
  local option optionName optionNameSc optionNameCc optionHasValue optionNoEnvVar
  for ((index = 0; index < ${#TEMP_CMD_BUILD_options_name[@]}; index++)); do
    option="${TEMP_CMD_BUILD_options_name[index]}"
    optionNoEnvVar="${TEMP_CMD_BUILD_options_noEnvironmentVariable[index]}"
    if [[ ${option} == *"<"* ]]; then
      optionHasValue="true"
      option="${option%%<*}"
    else
      optionHasValue="false"
    fi
    option="${option//,/ }"
    string::trimAll "${option}" && option="${LAST_RETURNED_VALUE}"
    extractFirstLongNameFromOptionString "${option}" && optionName="${LAST_RETURNED_VALUE}"
    string::kebabCaseToCamelCase "${optionName}" && optionNameCc="${LAST_RETURNED_VALUE}"
    if [[ "${optionNoEnvVar}" != "true" ]]; then
      string::kebabCaseToSnakeCase "${optionName}" && optionNameSc="VALET_${LAST_RETURNED_VALUE}"
    else
      optionNameSc=""
    fi

    eval "CMD_OPTS_${function}+=(\"${option}\")"
    eval "CMD_OPTS_HAS_VALUE_${function}+=(\"${optionHasValue}\")"
    eval "CMD_OPTS_NAME_${function}+=(\"${optionNameCc}\")"
    eval "CMD_OPTS_NAME_SC_${function}+=(\"${optionNameSc}\")"
  done

  # for each arguments
  if [[ "${#TEMP_CMD_BUILD_arguments_name[@]}" -gt 0 ]]; then
    local argument argumentNameCc lastArgumentIsArray
    local -i nbOptionalArguments=0
    for ((index = 0; index < ${#TEMP_CMD_BUILD_arguments_name[@]}; index++)); do
      argument="${TEMP_CMD_BUILD_arguments_name[index]}"
      if [[ ${argument} == *"..."* ]]; then
        argument="${argument//\.\.\./}"
        lastArgumentIsArray="true"
      fi
      if [[ ${argument} == *"?"* ]]; then
        argument="${argument//\?/}"
        nbOptionalArguments+=1
      fi
      string::kebabCaseToCamelCase "${argument}" && argumentNameCc="${LAST_RETURNED_VALUE}"

      eval "CMD_ARGS_NAME_${function}+=(\"${argumentNameCc}\")"
    done
    declare -g "CMD_ARGS_LAST_IS_ARRAY_${function}"="${lastArgumentIsArray:-false}"
    declare -g "CMD_ARGS_NB_OPTIONAL_${function}"="${nbOptionalArguments}"
  fi

  return 0
}

# This function declare additional variables that are needed in the commands file.
# It is executed after all the command definitions have been extracted.
#
# Declared variables:
# CMD_ALL_COMMAND_SELECTION_ITEMS_ARRAY = the input used to display the commands menu
# CMD_ALL_COMMAND_SELECTION_HIDDEN_ITEMS_ARRAY = all the commands that are not shown in the menu
# CMD_COMMANDS_NAME_this = array with each sub command name
# CMD_COMMANDS_DESCRIPTION_this = array with each sub commmand short description
# CMD_ALL_FUNCTIONS = list all the functions callable with a command
# CMD_ALL_COMMANDS = list all the commands
# shellcheck disable=SC2034
function declareOtherCommmandVariables() {
  # sort commands in alphabetical order
  array::sort CMD_ALL_COMMANDS_ARRAY

  CMD_ALL_COMMAND_SELECTION_ITEMS_ARRAY=()
  CMD_ALL_COMMAND_SELECTION_HIDDEN_ITEMS_ARRAY=()
  CMD_COMMANDS_NAME_this=()
  CMD_COMMANDS_DESCRIPTION_this=()

  # for each command
  local command line
  for command in "${CMD_ALL_COMMANDS_ARRAY[@]}"; do
    if [[ -z "${command}" ]]; then continue; fi

    # get the function name from a command
    local -n function="CMD_FUNCTION_NAME_${command//[^[:alnum:]]/_}"
    local -n shortDescription="CMD_SHORT_DESCRIPTION_${function}"
    local -n hideInMenu="CMD_HIDEINMENU_${function}"

    printf -v line "%-$((CMD_MAX_COMMAND_WIDTH + 4))s%s" "${command}" "${shortDescription}"

    # declare the command menu body
    if [[ ${hideInMenu:-false} == "true" ]]; then
      CMD_ALL_COMMAND_SELECTION_HIDDEN_ITEMS_ARRAY+=("${line}");
    else
      CMD_ALL_COMMAND_SELECTION_ITEMS_ARRAY+=("${line}");
    fi

    # declare the sub commands for the main menu
    CMD_COMMANDS_NAME_this+=("${command}")
    CMD_COMMANDS_DESCRIPTION_this+=("${shortDescription}")
  done

  # CMD_ALL_COMMANDS and CMD_ALL_FUNCTIONS
  local IFS=$'\n'
  CMD_ALL_COMMANDS="${CMD_ALL_MENU_COMMANDS_ARRAY[*]}"$'\n'"${CMD_ALL_COMMANDS_ARRAY[*]}"
  CMD_ALL_FUNCTIONS="${CMD_ALL_FUNCTIONS_ARRAY[*]}"
  unset IFS

  # declare additional variables for the sub commands menu
  CMD_DESCRIPTION__menu="Show a menu with sub commands for the current command."
  CMD_OPTIONS_NAME__menu="-h, --help"
  CMD_OPTIONS_DESCRIPTION__menu="Display the help for this command."
  CMD_OPTS__menu=("-h --help")
  CMD_OPTS_NAME__menu=("help")

  return 0
}

# This function verifies the global TEMP_CMD_BUILD_* variables to make sure that the command
# definition is valid.
# It write any error the global variable SELF_BUILD_ERRORS.
#
# Usage:
#   verifyCommandDefinition
function verifyCommandDefinition() {
  local function="${1}"
  local command="${2}"

  local message=""

  if [[ "${function}" != "this" ]]; then
    if [[ -z "${command}" ]]; then
      SELF_BUILD_ERRORS+="- is missing the command name."$'\n'
    else
      # the command can only contain letters, numbers, hyphens and spaces
      if [[ ! "${command}" =~ ^[[:alnum:]\ -]+$ ]]; then
        SELF_BUILD_ERRORS+="- has an invalid command name, it can only contain letters, numbers, hyphens and spaces."$'\n'
      fi
    fi
  fi
  if [[ -z "${function:-}" ]]; then
    SELF_BUILD_ERRORS+="- has an empty function name."$'\n'
  else
    # the function can only contain letters, numbers, hyphens and spaces
    if [[ ! "${function}" =~ ^[[:alnum:]\ -]+$ ]]; then
      SELF_BUILD_ERRORS+="- has an invalid function name, it can only contain letters, numbers, hyphens and spaces."$'\n'
    fi
  fi
  if [[ -z "${TEMP_CMD_BUILD_shortDescription:-}" ]]; then
    SELF_BUILD_ERRORS+="- does not have a short description."$'\n'
  fi
  if [[ -z "${TEMP_CMD_BUILD_description:-}" ]]; then
    SELF_BUILD_ERRORS+="- does not have a description."$'\n'
  fi
  if [[ -z "${TEMP_CMD_BUILD_fileToSource:-}" ]]; then
    SELF_BUILD_ERRORS+="- does not have a file to source to find the function."$'\n'
  fi

  # check for each option
  local -i index
  local option optionName
  for ((index = 0; index < ${#TEMP_CMD_BUILD_options_name[@]}; index++)); do
    option="${TEMP_CMD_BUILD_options_name[index]}"
    optionNames="${option}"

    # make sure that there is only one short option and that is has only 1 character
    if [[ ${optionNames} == *"<"* ]]; then
      optionNames="${optionNames%%<*}"
    fi
    optionNames="${optionNames//,/ }"
    string::trimAll "${optionNames}" && optionNames=" ${LAST_RETURNED_VALUE} "
    # remove the first short option
    optionNames="${optionNames/ -? /}"
    # if there still are short options, it means that there are more than one or that one has more than one character
    if [[ ${optionNames} =~ " -"[^-]+ ]]; then
      SELF_BUILD_ERRORS+="- has an invalid option ⌜${option}⌝, it can only have one short option (single -) and the short option must have a single character."$'\n'
    fi
  done

  # TODO: validate that each option is different, same for arguments
  # only the last argument can end with ...
  # only the last arguments can be optional
  # check the syntax for options
  # check the alphanumeric characters for options and arguments
  # for short option, only one character is allowed

  if [[ -n "${message}" ]]; then
    SELF_BUILD_ERRORS+="The command definition ⌜${command}⌝ for function ⌜${function}⌝:"$'\n'"${message}"
  fi
}

#===============================================================
# >>> Main
#===============================================================

# if this script is run directly, execute the function, otherwise valet will do it
if [[ ${_NOT_EXECUTED_FROM_VALET:-false} == "true" ]]; then
  selfBuild "$@"
fi
