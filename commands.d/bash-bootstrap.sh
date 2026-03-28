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

  This command is intended to be used in your bash configuration file (e.g. ~/.bashrc) to set up your bash
  session with Valet features.
  Below is a minimalist example of your ~/.bashrc file:

  ```bash
  #!/usr/bin/env bash
  # this is a good place to set VALET_* environment variables to configure valet features.
  eval "$(valet bash bootstrap)"
  ```

  By bootstrapping your bash session with Valet, you get access to many features described in the chapters below.

  --------------------------

  ## 1. PATH management

  You can now manage your PATH declaratively.

  Valet will use the files under the `~/.config/.paths.d` directory (by default) to compute your PATH variable.

  Each file under `~/.config/.paths.d` can contain multiple paths, one per line, and they will be added to your
  PATH variable in the same order as they appear in the file.

  The following rules are applied when parsing the files:

  - A line starting with # is a comment.
  - A path may use ~ which will be replaced by the user home directory.
  - A path that does not match an existing directory will be skipped.
  - A line starting with ^ is a path to add before the original path.
  - Any other line is a path to add after the original path.

  The files in the ~/.config/.paths.d directory are processed in alphabetical order, allowing you to control the order of the paths in your PATH variable.

  The following rules are applied when listing the files to consider in the ~/.config/.paths.d directory:

  - If the path file is hidden (starts with a dot), it is skipped.
  - If the path file is a markdown file, it is skipped.
  - If the path file contains -linux and the current os is not linux, it is skipped.
  - If the path file contains -windows and the current os is not windows, it is skipped.
  - If the path file contains -darwin and the current os is not macos, it is skipped.

  > The original path is stored in ORIGINAL_PATH, allowing you to restore it if needed.

  Examples of path definition files are available here:
  <https://github.com/jcaillon/valet/tree/dotfiles-example>

  --------------------------

  ## 2. Bashrc management

  You can now split your bash configuration into multiple files under the `~/.config/.bash.d` directory (by default).

  This allows you to organize your bash configuration and easily enable/disable parts of it by adding/removing files in this directory.

  The files in the `~/.config/.bash.d` directory are sourced in alphabetical order.

  The following rules are applied when listing the files to source in the `~/.config/.bash.d` directory:

  - If the file is hidden (starts with a dot), it is skipped.
  - If the file does not have a .sh or .bash extension, it is skipped.
  - If the file contains -linux and the current os is not linux, it is skipped.
  - If the file contains -windows and the current os is not windows, it is skipped.
  - If the file contains -darwin and the current os is not macos, it is skipped.

  > Additionally, a script containing -bash-init in its name will be sourced before the PATH variable is computed,
  > allowing you to set environment variables that can be used in the path definition files.

  All valet functions can be used in these scripts.

  Examples of bash scripts are available here:
  <https://github.com/jcaillon/valet/tree/dotfiles-example>

  --------------------------

  ## 3. Bash hooks for prompt and command execution

  You can now define functions to be executed before the prompt is drawn and before a command is executed.

  This works exactly like the precmd and preexec hooks in zsh, with the difference that due to bash limitations,
  the preexec functions are executed in a subshell and thus cannot modify the environment.

  See: <https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions>.

  - `precmd_functions`: array of functions to be executed before the prompt is drawn
    Functions can expect the following variables to be set:
    - GLOBAL_LAST_COMMAND_STATUS: the status of the last command executed
    - GLOBAL_LAST_PIPE_STATUS: the status of the last pipeline executed
    - GLOBAL_LAST_ELAPSED_MICROSECONDS: the elapsed time for the command in microseconds
      (will be 0 if no command was executed since the last prompt)
    - GLOBAL_JOB_COUNT: the number of background jobs
    They can also call the function bashHooks::getCurrentCommand to get the last command executed.
  - `preexec_functions`: array of functions to be executed before the command is executed
    Functions are invoked with the command to execute as the first argument $1.
    /!\ they are executed in a subshell, so they cannot modify the environment!
        this can be fixed in bash 5.3 with the ${ exec} variable expansion (see implementation of the hooks).

  --------------------------

  ## 4. Use Valet functions in your shell

  You can now use valet functions directly in your shell, as if you were in a command script.

  E.g.: `log::info "Cool logs!"`.

  --------------------------

  ## 5. Integration with bash tools

  Valet also sets up integration with some popular bash tools:

  - Starship: a better, fully featured prompt <https://starship.rs/>.
  - Atuin: a better shell history manager <https://atuin.sh/>.

  --------------------------

  ## 6. Incoming features

  TODO: FEATURES TO IMPLEMENT:

  - add builtin "z" to jump to frequently used directories
  - auto source .env and .envrc files in the current directory
  - Provide a good and fast default prompt if atuin is not installed

options:
- name: --bash-scripts-directory <directory>
  description: |-
    Path to the directory containing bash scripts to source during bootstrap.
- name: --path-definition-directory <directory>
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

  pathDefinitionDirectory="${pathDefinitionDirectory:-"${XDG_CONFIG_HOME:-"${HOME}/.config"}/.paths.d"}"
  bashScriptsDirectory="${bashScriptsDirectory:-"${XDG_CONFIG_HOME:-"${HOME}/.config"}/.bash.d"}"

  system::getOs
  local _BASH_OS="${REPLY}"

  # source valet itself
  command::sourceFunction selfSource
  selfSource --prompt-mode

  local output=""

  # setup bash hooks
  output+="source \"${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/bash-prompt-hooks\""$'\n'
  output+="source \"${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/bash-prompt-tools\""$'\n'
  output+="bashHooks::init"$'\n\n'

  # source scripts in the specified directory which contain -bash-init
  bashBootstrap_sourceScriptsFromDirectory "${bashScriptsDirectory}" include="-bash-init"
  output+="${REPLY}"$'\n'

  # compute the PATH variable
  output+="bootstrap::exportPathFromFiles '${pathDefinitionDirectory}' '${_BASH_OS}'"$'\n'
  output+="eval \"\${REPLY}\""$'\n'

  # source scripts in the specified directory
  bashBootstrap_sourceScriptsFromDirectory "${bashScriptsDirectory}" exclude="-bash-init"
  output+="${REPLY}"$'\n'

  # setup bash tools integration
  output+="starship::init"$'\n'
  output+="atuin::init"$'\n'
  output+="keybindings::init"$'\n'
  output+=$'\n'

  echo "${output}"
}

# Returns a string to be evaluated in order to source all bash scripts from a given
# directory.
function bashBootstrap_sourceScriptsFromDirectory() {
  local \
    directory="${1}" \
    include="" \
    exclude="" \
    IFS=$' '
  shift 1
  eval "local a= ${*@Q}"

  if [[ ! -d ${directory} ]]; then
    log::debug "The bash scripts directory ⌜${directory}⌝ does not exist, skipping sourcing bash scripts."
    REPLY=""
    return 0
  fi

  log::debug "Listing bash scripts to source in directory: ${directory}"

  # shellcheck disable=SC2317
  function filterFiles() {
    # filter by OS
    if ! bashBootstrap_filterFileByOs "${1}"; then
      return 1
    fi
    # filter by extension
    if [[ ! ${1} =~ \.(sh|bash)$ ]]; then
      return 1
    fi
    if [[ -n ${include} && ! ${1} =~ ${include} ]]; then
      return 1
    fi
    if [[ -n ${exclude} && ${1} =~ ${exclude} ]]; then
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
