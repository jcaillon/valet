#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

#===============================================================
# >>> command: bash bootstrap
#===============================================================

# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-system
source system
# shellcheck source=../libraries.d/lib-string
source string

: <<"COMMAND_YAML"
command: bash bootstrap
function: bashBootstrap
hideInMenu: true
author: github.com/jcaillon
shortDescription: Returns a string that can be evaluated to bootstrap your bash session.
description: |-
  Bootstrap your bash session.

  ```bash
  eval "$(valet bash bootstrap)"
  ```

  This script allows to add paths to the PATH environment variable
  by reading the content of the files under the ~/.paths.d directory.
  We export the original path to ORIGINAL_PATH, allowing to restore it
  which means you can source this file indefinitely without any issue.

  The rules are the following:
  - If the path file is hidden (starts with a dot), it is skipped.
  - If the path file is a markdown file, it is skipped.
  - If the path file contains -linux and the platform is Windows, it is skipped.
  - If the path file contains -windows and the platform is Linux, it is skipped.

  Each path file can contain multiple paths, one per line. Within a path file,
  the following rules apply:
  - A line starting with # is a comment.
  - A path may use ~ which will be replaced by the user home directory.
  - A path that does not match an existing directory will be skipped.
  - A line starting with ^ is a path to add before the original path.
  - Any other line is a path to add after the original path.

  The goal of this script is to set up the hooks needed to make these two variables work:

  - precmd_functions: array of functions to be executed before the prompt is drawn
    Functions can expect the following variables to be set:
    - GLOBAL_LAST_COMMAND_STATUS: the status of the last command executed
    - GLOBAL_LAST_PIPE_STATUS: the status of the last pipeline executed
    - GLOBAL_LAST_ELAPSED_MICROSECONDS: the elapsed time for the command in microseconds
      (will be 0 if no command was executed since the last prompt)
    - GLOBAL_JOB_COUNT: the number of background jobs
    They can also call the function bashHooks::getCurrentCommand to get the last command executed.
  - preexec_functions: array of functions to be executed before the command is executed
    Functions are invoked with the command to execute as the first argument $1.
    /!\ they are executed in a subshell, so they cannot modify the environment!
        this can be fixed in bash 5.3 with the ${ exec} variable expansion (see implementation of the hooks).

options:
- name: --bash-scripts-directory <path>
  description: |-
    Path to the directory containing bash scripts to source during bootstrap.
- name: --path-definition-directory <path>
  description: |-
    Path to the directory containing path definition files to compute the PATH variable.


examples:
- name: !eval "$(valet bash bootstrap)"
  description: |-
    Source valet functions in your bash script or bash prompt.
    You can then can then use valet function as if you were in a command script.
COMMAND_YAML
function bashBootstrap() {
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  local output=""

  # source valet itself
  command::sourceFunction selfSource
  selfSource --prompt-mode

  # setup bash hooks
  output+="source \"${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/bash-hooks\""$'\n'
  output+="bashHooks::initialize"$'\n'

  system::getOs
  local _BASH_OS="${REPLY}"

  # source scripts in the specified directory
  bashScriptsDirectory="${bashScriptsDirectory:-"${XDG_CONFIG_HOME:-"${HOME}/.config"}/.bash.d2"}"
  bashBootstrap_sourceScriptsFromDirectory "${bashScriptsDirectory}"
  output+="${REPLY}"

  # compute the PATH variable
  pathDefinitionDirectory="${pathDefinitionDirectory:-"${XDG_CONFIG_HOME:-"${HOME}/.config"}/.paths.d"}"
  bashBootstrap_exportPathFromFiles "${pathDefinitionDirectory}"
  output+="${REPLY}"

  # setup bash tools integration
  output+="source \"${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/bash-tools-integration\""$'\n'
  output+="starship::init"$'\n'
  output+="atuin::init"$'\n'
  output+="keybindings::init"$'\n'

  echo "${output}"
}

function bashBootstrap_exportPathFromFiles() {
  local directory="${1}"

  log::debug "Listing path files in directory: ${directory}"
  fs::listFiles "${directory}" filter=bashBootstrap_filterFileByOs
  unset -f filterFiles

  local hashListString=""

  # go through each path file to get the exhaustive list of paths to add
  local -a pathsToAddBefore pathsToAddAfter lines
  local pathFile line
  for pathFile in "${REPLY_ARRAY[@]}"; do
    log::debug "Checking path file ${pathFile}."

    readarray -t -d $'\n' lines <"${pathFile}"

    for line in "${lines[@]}"; do
      # skip comments and empty lines
      if [[ -z ${line} || ${line} == "#"* ]]; then
        continue
      fi

      line="${line//'~'/"${HOME}"}"
      string::trimEdges line

      if [[ ${line} == *"="* ]]; then
        log::debug "Adding hash defined path: ${line}."
        hashListString+="hash -p \"${line##*=}\" ${line%%=*}"$'\n'
      elif [[ ${line} == "^"* ]]; then
        pathsToAddBefore+=("${line:1}")
        log::debug "Adding path before: ${line:1}."
      else
        pathsToAddAfter+=("${line}")
        log::debug "Adding path after: ${line}."
      fi
    done
  done

  # read all the original paths
  string::split PATH ":"

  # compute the final path
  local finalPathString=":"
  for path in "${pathsToAddBefore[@]}" "${REPLY_ARRAY[@]}" "${pathsToAddAfter[@]}"; do
    if [[ ! -d ${path} ]]; then continue; fi
    if [[ ${finalPathString} == *":${path}:"* ]]; then continue; fi
    finalPathString+="${path}:"
  done

  # remove trailing and leading :
  finalPathString="${finalPathString#:}"
  finalPathString="${finalPathString%:}"
  log::debug "Final path: ${finalPathString}."

  REPLY="export ORIGINAL_PATH=\"\${PATH}\""$'\n'"export PATH=\"${finalPathString}\""$'\n'

  if [[ -n ${hashListString} ]]; then
    REPLY+="${hashListString}"$'\n'"export BASH_CMDS"$'\n'
  fi
}

# Returns a string to be evaluated in order to source all bash scripts from a given
# directory.
function bashBootstrap_sourceScriptsFromDirectory() {
  local directory="${1}"

  log::debug "Listing bash scripts to source in directory: ${directory}"

  # shellcheck disable=SC2317
  function filterFiles() {
    # filter by OS
    if ! bashBootstrap_filterFileByOs "${1}"; then
      return 1
    fi

    # filter by extension
    if [[ ${1} != *@(sh|bash) ]]; then
      return 1
    fi

    return 0
  }

  fs::listFiles "${directory}" filter=filterFiles
  unset -f filterFiles

  REPLY=""
  local path
  for path in "${REPLY_ARRAY[@]}"; do
    REPLY+="source \"${path}\""$'\n'
  done
}

function bashBootstrap_filterFileByOs() {
  if [[ ${1} =~ "-"(linux|windows|darwin) ]]; then
    if [[ ${_BASH_OS} != "${BASH_REMATCH[1]}" ]]; then
      return 1
    fi
  fi
}
