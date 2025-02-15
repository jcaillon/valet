#!/usr/bin/env bash
set -Eeu -o pipefail
# author: github.com/jcaillon
# Title:         libraries.d/build
# Description:   This script is called during development to build the commands script.
#                It reads all the files in which we could find command definitions and generates commands script.
#                You can call this script directly in case calling ⌜valet self build⌝ is broken:
#                $ ./commands.d/self-build.sh

#===============================================================
# >>> command: self build
#===============================================================

##<<VALET_COMMAND
# command: self build
# function: selfBuild
# author: github.com/jcaillon
# shortDescription: Index all the commands and libraries present in the valet user directory and installation directory.
# description: |-
#   Index all the command and libraries present in the valet user directory and installation directory.
#
#   This command can be used to re-build the menu / help / options / arguments in case you have modified, added or removed a Valet command definition.
#
#   Please check https://jcaillon.github.io/valet/docs/new-commands/ or check the examples in ⌜showcase.d⌝ directory to learn how to create and modified your commands.
#
#   This scripts:
#
#   - Makes a list of all the eligible files in which we could find command definitions.
#   - For each file in this list, extract the command definitions.
#   - Build your commands file (in your valet user directory) from these definitions.
#   - Makes a list of all `libraries.d` directories found in the user directory.
#
#   You can call this script directly in case calling ⌜valet self build⌝ is broken:
#
#   → commands.d/self-build.sh
# options:
# - name: -d, --user-directory <path>
#   description: |-
#     Specify the directory in which to look for your command scripts.
#     Defaults to the valet user directory.
# - name: -C, --core-only
#   description: |-
#     Build only the core commands (under commands.d).
# - name: -o, --output <path>
#   description: |-
#     Specify the file path in which to write the command definition variables.
#
#     This defaults to the ⌜commands⌝ file in your Valet user directory.
# - name: -O, --no-output
#   description: |-
#     Do not write the command definition variables to a file.
#
#     This will just create the variables.
# - name: -s, --silent
#   description: |-
#     Build silently without any info logs.
# examples:
# - name: self build
#   description: |-
#     Build the valet user commands.
# - name: self build -d ~/my-valet-directory --silent
#   description: |-
#     Build the valet user commands from the directory ⌜~/my-valet-directory⌝ and with minimal log output.
##VALET_COMMAND
function selfBuild() {
  local userDirectory output coreOnly noOutput silent

  # if this script is run directly
  if [[ ${_NOT_EXECUTED_FROM_VALET:-false} == "true" || ! -v GLOBAL_CMD_INCLUDED ]]; then
    # parse arguments manually (basic parsing only)
    while [[ $# -gt 0 ]]; do
      case "${1}" in
      -d | --user-directory)
        shift
        userDirectory="${1}"
        ;;
      -o | --output)
        shift
        output="${1}"
        ;;
      -C | --core-only)
        coreOnly=true
        ;;
      -O | --no-output)
        noOutput=true
        ;;
      -s | --silent)
        silent=true
        ;;
      -*)
        if [[ -v CMD_OPTS_selfBuild ]]; then
          # shellcheck disable=SC2048
          # shellcheck disable=SC2086
          main::fuzzyFindOption "${1}" "${CMD_OPTS_selfBuild[@]}"
        else
          RETURNED_VALUE="Unknown option ⌜${1}⌝"
        fi
        core::fail "${RETURNED_VALUE}"
        ;;
      *) core::fail "This command takes no arguments." ;;
      esac
      shift
    done
  else
    command::parseArguments "$@" && eval "${RETURNED_VALUE}"
    command::checkParsedResults
  fi

  log::debug "Building the valet user commands."

  local originalLogLevel
  if [[ ${silent:-} == "true" ]]; then
    log::getLevel
    if [[ ${RETURNED_VALUE} == "debug" || ${RETURNED_VALUE} == "trace" ]]; then
      log::info "The silent option has been ignored because of the current log level."
      silent=false
    else
      log::debug "Building the valet user commands silently."
      log::getLevel && originalLogLevel="${RETURNED_VALUE}"
      log::setLevel warning true
    fi
  fi

  core::getUserDirectory
  userDirectory="${userDirectory:-${RETURNED_VALUE}}"
  output="${output:-${userDirectory}/commands}"

  fs::toAbsolutePath "${GLOBAL_INSTALLATION_DIRECTORY}"
  GLOBAL_INSTALLATION_DIRECTORY="${RETURNED_VALUE}"

  # list all the files in which we need to find command definitions
  local -a libraryDirectories=()
  local -a commandDefinitionFiles=(
    "${GLOBAL_INSTALLATION_DIRECTORY}/valet"
    "${GLOBAL_INSTALLATION_DIRECTORY}/commands.d"/*.sh
  )
  if [[ -d "${GLOBAL_INSTALLATION_DIRECTORY}/tests.d/.commands.d" ]]; then
    commandDefinitionFiles+=("${GLOBAL_INSTALLATION_DIRECTORY}/tests.d/.commands.d"/*.sh)
    log::info "Added the test commands to the build."
  fi
  if [[ ${coreOnly:-} != "true" ]]; then
    if [[ -d "${userDirectory}" ]]; then
      log::info "Building the valet user commands from extensions in the user directory ⌜${userDirectory}⌝."
      local extensionsDirectory
      for extensionsDirectory in "${userDirectory}"/*; do
        if [[ ! -d ${extensionsDirectory} && ${extensionsDirectory} != "."* ]]; then
          continue
        fi
        commandDefinitionFiles+=("${extensionsDirectory}/commands.d"/*.sh)
      done
    else
      log::warning "Skipping the build of scripts in user directory ⌜${userDirectory}⌝ because it does not exist."
    fi
  else
    log::info "Skipping the build of scripts in user directory (building core commands only)."
  fi

  if log::isDebugEnabled; then
    local IFS=$'\n'
    log::debug "Will extract command definitions from the following files:"$'\n'"${commandDefinitionFiles[*]}"
    unset IFS
  fi

  # make sure to unset all previous CMD_* variables
  # shellcheck disable=SC2086
  unset -v ${!CMD_*} \
    SELF_BUILD_ERRORS

  # add the list of library directories
  CMD_LIBRARY_DIRECTORIES=("${libraryDirectories[@]}")

  # extract the command definitions to variables
  extractCommandDefinitionsToVariables "${commandDefinitionFiles[@]}"

  summarize

  unset CMD_ALL_COMMAND_SELECTION_HIDDEN_ITEMS_ARRAY

  if [[ -n ${SELF_BUILD_ERRORS:-} ]]; then
    core::fail "The valet user commands have not been successfully built. Please check the following errors:"$'\n'"${SELF_BUILD_ERRORS}"
  fi

  if [[ ${noOutput:-} != "true" ]]; then
    selfBuild_writeCommandDefinitionVariablesToFile "${output}"
    log::info "The command definition variables have been written to ⌜${output}⌝."
  fi

  if [[ ${VALET_CONFIG_BUMP_VERSION_ON_BUILD:-false} == "true" ]]; then
    bumpValetBuildVersion
  fi

  log::success "The valet user commands have been successfully built."

  if [[ ${silent:-} == "true" ]]; then
    log::setLevel "${originalLogLevel}" true
  fi
}

#===============================================================
# >>> Internal functions
#===============================================================

# This function summarizes the command definitions that have been extracted for the user.
function summarize() {
  local -i numberOfVars=0
  local _var
  for _var in ${!CMD_*}; do
    numberOfVars+=1
  done

  local message="== Summary of the commands =="$'\n\n'
  message+="- Number of variables declared: ⌜${numberOfVars}⌝."$'\n'
  message+="- Number of functions: ⌜${#CMD_ALL_FUNCTIONS_ARRAY[@]}⌝."$'\n'
  message+="- Number of commands: ⌜${#CMD_ALL_COMMANDS_ARRAY[@]}⌝."$'\n'
  message+="- Number of user library directories found: ⌜${#CMD_LIBRARY_DIRECTORIES[@]}⌝."$'\n'
  message+="- Maximum sub command level: ⌜${CMD_MAX_SUB_COMMAND_LEVEL:-0}⌝."$'\n'

  local IFS=$'\n'

  if ((${#CMD_LIBRARY_DIRECTORIES[@]} > 0)); then
    message+=$'\n'"== List of user library directories =="$'\n\n'
    message+="${CMD_LIBRARY_DIRECTORIES[*]}"$'\n'
  fi

  message+=$'\n'"== List of all the hidden commands =="$'\n\n'
  message+="${CMD_ALL_COMMAND_SELECTION_HIDDEN_ITEMS_ARRAY[*]}"$'\n'

  message+=$'\n'"== List of all the commands =="$'\n\n'
  message+="${CMD_ALL_COMMAND_SELECTION_ITEMS_ARRAY[*]}"$'\n'

  log::info "${message}"
}

# Bump the valet build version by one patch.
function bumpValetBuildVersion() {
  core::getVersion
  local currentVersion="${RETURNED_VALUE:-0.0.0}"
  currentVersion="${currentVersion%%$'\n'*}"

  version::bump "${currentVersion}" "patch" "false"

  printf '%s' "${RETURNED_VALUE}" >"${GLOBAL_INSTALLATION_DIRECTORY}/version"

  log::info "The valet build version has been bumped to ⌜${RETURNED_VALUE}⌝."
}

# This function extracts the command definitions from the files and stores them in
# CMD_BUILD_* global variables.
#
# $@: The files to extract from.
function extractCommandDefinitionsToVariables() {
  local -i duplicatedCommands=0
  while [[ $# -gt 0 ]]; do
    local file="${1}"
    shift
    if [[ ${file} == *"*.sh" ]]; then
      continue
    fi
    log::info "Extracting commands from ⌜${file}⌝."
    selfBuild_extractCommandYamls "${file}"
    local content
    for content in "${RETURNED_ARRAY[@]}"; do

      if log::isTraceEnabled; then
        log::trace "Extracting command definition for:"
        log::printFileString "${content%%$'\n'*}"
      fi

      selfBuild_extractCommandDefinitionToVariables "${content}"

      local function command
      function="${TEMP_CMD_BUILD_function:-}"
      string::trimAll function
      function="${RETURNED_VALUE}"
      command="${TEMP_CMD_BUILD_command:-}"
      string::trimAll command
      command="${RETURNED_VALUE}"

      # trim the leading "valet" from the command
      command="${command#valet }"
      command="${command#valet}"

      if array::checkIfPresent CMD_ALL_COMMANDS_ARRAY command; then
        log::warning "                         ├── Skipping ⌜${command}⌝ (already defined)."
        duplicatedCommands+=1
        continue
      else
        log::info "                         ├── ⌜${command}⌝."
      fi


      fs::toAbsolutePath "${file}" && TEMP_CMD_BUILD_fileToSource="${RETURNED_VALUE}"
      TEMP_CMD_BUILD_fileToSource="${TEMP_CMD_BUILD_fileToSource#"${GLOBAL_INSTALLATION_DIRECTORY}"/}"

      # make sure that all these arrays exists and have the same size
      array::makeArraysSameSize TEMP_CMD_BUILD_options_name TEMP_CMD_BUILD_options_description TEMP_CMD_BUILD_options_noEnvironmentVariable TEMP_CMD_BUILD_options_default
      array::makeArraysSameSize TEMP_CMD_BUILD_arguments_name TEMP_CMD_BUILD_arguments_description
      array::makeArraysSameSize TEMP_CMD_BUILD_examples_name TEMP_CMD_BUILD_examples_description

      if log::isTraceEnabled; then
        # shellcheck disable=SC2086
        exe::captureOutput declare -p ${!TEMP_CMD_BUILD_*}
        log::trace "Declared variables for this command:"
        log::printFileString "${RETURNED_VALUE}"
      fi

      # verify that the command definition is valid
      selfBuild_verifyCommandDefinition "${function}" "${command}"

      # declare common variables
      declareFinalCommandDefinitionCommonVariables "${function}" "${command}"

      # declare help variables
      declareFinalCommandDefinitionHelpVariables "${function}"

      # declare options and arguments for the parser
      declareFinalCommandDefinitionParserVariables "${function}"
    done
  done

  # declare complementary variables
  declareOtherCommandVariables

  if ((duplicatedCommands > 0)); then
    core::fail "There are ${duplicatedCommands} duplicated commands, please remove them. Do you have a duplicated folder in your valet user directory?"
  fi
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
  if [[ -n ${command} ]]; then
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
  if [[ -n ${parentCommand} ]]; then
    if ! array::appendIfNotPresent CMD_ALL_MENU_COMMANDS_ARRAY parentCommand; then
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
  if [[ -n ${TEMP_CMD_BUILD_sudo:-} ]]; then declare -g "CMD_SUDO_${function}"="${TEMP_CMD_BUILD_sudo}"; fi

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
      selfBuild_extractFirstLongNameFromOptionString "${TEMP_CMD_BUILD_options_name[index]}"
      string::convertKebabCaseToSnakeCase RETURNED_VALUE
      TEMP_CMD_BUILD_options_description[index]+=$'\n'"This option can be set by exporting the variable VALET_${RETURNED_VALUE}='${optionValue}'."
    fi
  done

  # for each example, prepend valet to the example name
  local example
  local -a examples=()
  for example in "${TEMP_CMD_BUILD_examples_name[@]}"; do
    if [[ ${example} == "!"* ]]; then
      examples+=("${example:1}")
    else
      examples+=("valet ${example}")
    fi
  done

  # declare examples, arguments and options for the help
  if [[ "${#examples[@]}" -gt 0 ]]; then eval "CMD_EXAMPLES_NAME_${function}=(\"\${examples[@]}\")"; fi
  if [[ "${#TEMP_CMD_BUILD_examples_description[@]}" -gt 0 ]]; then eval "CMD_EXAMPLES_DESCRIPTION_${function}=(\"\${TEMP_CMD_BUILD_examples_description[@]}\")"; fi
  eval "CMD_OPTIONS_NAME_${function}=(\"\${TEMP_CMD_BUILD_options_name[@]}\")"
  eval "CMD_OPTIONS_DESCRIPTION_${function}=(\"\${TEMP_CMD_BUILD_options_description[@]}\")"
  if [[ "${#TEMP_CMD_BUILD_arguments_name[@]}" -gt 0 ]]; then eval "CMD_ARGUMENTS_NAME_${function}=(\"\${TEMP_CMD_BUILD_arguments_name[@]}\")"; fi
  if [[ "${#TEMP_CMD_BUILD_arguments_description[@]}" -gt 0 ]]; then eval "CMD_ARGUMENTS_DESCRIPTION_${function}=(\"\${TEMP_CMD_BUILD_arguments_description[@]}\")"; fi

  return 0
}

# Declare the following variables:
#
# CMD_OPTS_xxx = array with each option separated by a space
# CMD_OPTS_HAS_VALUE_xxx = array which indicates for each option if it has a value or not
# CMD_OPTS_NAME_xxx = array with each option names in camel case
# CMD_OPTS_NAME_SC_xxx = array with each option names in snake case
# CMD_OPTS_DEFAULT_xxx = contains the default value for this option
#
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
    string::trimAll option
    option="${RETURNED_VALUE}"
    selfBuild_extractFirstLongNameFromOptionString "${option}"
    optionName="${RETURNED_VALUE}"
    string::convertKebabCaseToCamelCase optionName
    optionNameCc="${RETURNED_VALUE}"
    if [[ "${optionNoEnvVar}" != "true" ]]; then
      string::convertKebabCaseToSnakeCase optionName
      optionNameSc="VALET_${RETURNED_VALUE}"
    else
      optionNameSc=""
    fi

    eval "CMD_OPTS_${function}+=(\"${option}\")"
    eval "CMD_OPTS_HAS_VALUE_${function}+=(\"${optionHasValue}\")"
    eval "CMD_OPTS_NAME_${function}+=(\"${optionNameCc}\")"
    eval "CMD_OPTS_NAME_SC_${function}+=(\"${optionNameSc}\")"
    eval "CMD_OPTS_DEFAULT_${function}+=(\"${TEMP_CMD_BUILD_options_default[index]:-}\")"
  done

  # for each arguments
  if [[ "${#TEMP_CMD_BUILD_arguments_name[@]}" -gt 0 ]]; then
    local argument lastArgumentIsArray
    local -i nbOptionalArguments=0
    for ((index = 0; index < ${#TEMP_CMD_BUILD_arguments_name[@]}; index++)); do
      string::convertKebabCaseToCamelCase TEMP_CMD_BUILD_arguments_name[index]
      argument="${RETURNED_VALUE}"
      if [[ ${argument} == *"..."* ]]; then
        argument="${argument//\.\.\./}"
        lastArgumentIsArray="true"
      fi
      if [[ ${argument} == *"?"* ]]; then
        argument="${argument//\?/}"
        nbOptionalArguments+=1
      fi
      eval "CMD_ARGS_NAME_${function}+=(\"${argument}\")"
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
function declareOtherCommandVariables() {
  # sort commands in alphabetical order
  array::sort CMD_ALL_COMMANDS_ARRAY

  CMD_ALL_COMMAND_SELECTION_ITEMS_ARRAY=()
  CMD_ALL_COMMAND_SELECTION_HIDDEN_ITEMS_ARRAY=()
  CMD_COMMANDS_NAME_this=()
  CMD_COMMANDS_DESCRIPTION_this=()

  # for each command
  local command line
  for command in "${CMD_ALL_COMMANDS_ARRAY[@]}"; do
    if [[ -z ${command} ]]; then continue; fi

    # get the function name from a command
    local -n function="CMD_FUNCTION_NAME_${command//[^[:alnum:]]/_}"
    local -n shortDescription="CMD_SHORT_DESCRIPTION_${function}"
    local -n hideInMenu="CMD_HIDEINMENU_${function}"

    printf -v line "%-$((CMD_MAX_COMMAND_WIDTH + 4))s%s" "${command}" "${shortDescription}"

    # declare the command menu body
    if [[ ${hideInMenu:-false} == "true" ]]; then
      CMD_ALL_COMMAND_SELECTION_HIDDEN_ITEMS_ARRAY+=("${line}")
    else
      CMD_ALL_COMMAND_SELECTION_ITEMS_ARRAY+=("${line}")
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


#===============================================================
# >>> Main
#===============================================================

if [[ ! -v GLOBAL_CORE_INCLUDED ]]; then
  _NOT_EXECUTED_FROM_VALET=true

  # do not read the commands in that case
  GLOBAL_CMD_INCLUDED=1

  _COMMANDS_DIR="${BASH_SOURCE[0]:-"${0}"}"
  if [[ "${_COMMANDS_DIR}" != /* ]]; then
    if pushd "${_COMMANDS_DIR%/*}" &>/dev/null; then
      _COMMANDS_DIR="${PWD}"
      popd &>/dev/null || :
    else _COMMANDS_DIR="${PWD}"; fi
  else _COMMANDS_DIR="${_COMMANDS_DIR%/*}"; fi

  # shellcheck source=../libraries.d/core
  source "${_COMMANDS_DIR%/*}/libraries.d/core"
else
  unset _NOT_EXECUTED_FROM_VALET
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=self-build-utils
source self-build-utils
# shellcheck source=../libraries.d/lib-array
source array
# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-exe
source exe
# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-version
source version

# if this script is run directly, execute the function, otherwise valet will do it
if [[ ${_NOT_EXECUTED_FROM_VALET:-false} == "true" ]]; then
  selfBuild "$@"
fi
