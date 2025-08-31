#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

#===============================================================
# >>> command: self config
#===============================================================

: <<"COMMAND_YAML"
command: self config
function: selfConfig
author: github.com/jcaillon
shortDescription: Open the configuration file of Valet with your default editor.
description: |-
  Open the configuration file of Valet with your default editor.

  This allows you to set advanced options for Valet.

  If the configuration file does not exist, it will be created.
  Each configuration variable will be commented out with a description of its purpose.
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
COMMAND_YAML
function selfConfig() {
  command::parseArguments "$@"; eval "${REPLY}"
  command::checkParsedResults

  core::getConfigurationDirectory
  local valetConfigFile="${VALET_CONFIG_FILE:-"${REPLY}/config"}"

  if [[ ! -f "${valetConfigFile}" || ${override:-} == "true" ]]; then
    log::info "Writing the valet config file ⌜${valetConfigFile}⌝."
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

  printf '%s\n' "${REPLY}" >"${valetConfigFile}"
}

# Return the content of the valet config file.
# Optionally export the current values of the variables.
#
# - $1: exportCurrentValues: if true, export the current values of the variables.
#
# Returns:
#
# - ${REPLY}: the content of the valet config file.
function selfConfig::getFileContent() {
  local exportCurrentValues="${1}"

  # shellcheck disable=SC2016
  REPLY='#''!/usr/bin/env bash
# The config script for Valet.
# shellcheck disable=SC2034
'

  # loop through lines of libraries.d/config.md
  local line variableName skipNextLine=false
  while IFS=$'\n' read -rd $'\n' line || [[ -n ${line:-} ]]; do
    if [[ ${skipNextLine} == "true" || ${line} == "<!--"* ]]; then
      skipNextLine="false"
      continue
    fi
    if [[ ${line} == "- \`VALET_CONFIG_"* ]]; then
      variableName="${line#"- \`"}"
      variableName="${variableName%%"\`"*}"
    elif [[ ${line} == "#### VALET_CONFIG_"* ]]; then
      variableName="${line#"#### "}"
      skipNextLine=true
    else
      variableName=""
    fi
    if [[ -n ${variableName} ]]; then
      if [[ ${exportCurrentValues} == "true" && -v ${variableName} ]]; then
        log::trace "Exported the value for ⌜${variableName}⌝."
        printf -v "variableValue" "%q" "${!variableName}"
        if [[ ${variableValue} != "'''" ]]; then
          REPLY+="${variableName}=${variableValue}"$'\n'
        else
          REPLY+="# ${variableName}=\"\""$'\n'
        fi
      else
        REPLY+="# ${variableName}=\"\""$'\n'
      fi
    else
      if [[ ${line} == "## "* ]]; then
        REPLY+="##############################"$'\n'"# ${line##*"# "}"$'\n'"##############################"$'\n'
      elif [[ ${line} == "### "* ]]; then
        REPLY+="####################"$'\n'"# ${line##*"# "}"$'\n'"####################"$'\n'
      elif [[ ${line} == "#### "* || ${line} == "### "* ]]; then
        REPLY+="# ${line##*"# "}"$'\n'"#-------------------"$'\n'
      else
        REPLY+="# ${line}"$'\n'
      fi
    fi
  done <"${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/config.md"

}
