#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

#===============================================================
# >>> command: bash links
#===============================================================

# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-system
source system
# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-interactive
source interactive

: <<"COMMAND_YAML"
command: bash links
function: bashLinks
hideInMenu: true
author: github.com/jcaillon
shortDescription: Create symbolic links as defined in the links definition directory.
description: |-
  Create symbolic links as defined in the links definition directory.

options:
- name: --force
  description: |-
    Replace existing targets without confirmation when creating the links.
- name: --links-definition-directory <directory>
  description: |-
    Path to the directory containing link definition files to create symbolic links.
- name: --dotfiles <directory>
  description: |-
    Path to the your dotfiles directory. All links referring to the "./" directory will be
    resolved relative to this directory.
    Will default to the current working directory.

examples:
- name: bash links
  description: |-
    Create symbolic links as defined in the links definition directory.
COMMAND_YAML
function bashLinks() {
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  dotfiles="${dotfiles:-"${PWD}"}"
  linksDefinitionDirectory="${linksDefinitionDirectory:-"${XDG_CONFIG_HOME:-"${HOME}/.config"}/.links.d"}"
  if [[ ! -d ${linksDefinitionDirectory} ]]; then
    core::fail "The links definition directory ⌜${linksDefinitionDirectory}⌝ does not exist, nothing to do."
    return 0
  fi

  system::getOs
  local os="${REPLY}"
  # shellcheck disable=SC2317
  function bashLinks_filterFileByOs() {
    if [[ ${1} =~ "-"(linux|windows|darwin) ]]; then
      if [[ ${os} != "${BASH_REMATCH[1]}" ]]; then
        return 1
      fi
    fi
  }

  log::debug "Listing path files in directory: ${linksDefinitionDirectory}"
  fs::listFiles "${linksDefinitionDirectory}" filter=bashLinks_filterFileByOs
  unset -f bashLinks_filterFileByOs
  local -a linkFiles=("${REPLY_ARRAY[@]}")

  # go through each line of each file
  local -a links sources modes
  local linkFile line link source
  for linkFile in "${linkFiles[@]}"; do
    log::debug "Checking link file ${linkFile}."

    readarray -t -d $'\n' lines <"${linkFile}"

    for line in "${lines[@]}"; do
      # skip comments and empty lines
      if [[ -z ${line} || ${line} == "#"* ]]; then
        continue
      fi

      line="${line//'~'/"${HOME}"}"

      if [[ ${line} =~ ^([^:]+)":"([h]?)"->"(.+)$ ]]; then
        link="${BASH_REMATCH[1]}"
        mode="${BASH_REMATCH[2]}"
        source="${BASH_REMATCH[3]}"
      else
        log::warning "The line ⌜${line}⌝ is not a valid link definition, skipping (defined in ${linkFile})."
      fi

      string::trimEdges link
      string::trimEdges source

      local wildcardMode=false
      if [[ ${source} == *"/*" || ${link} == *"/*" ]]; then
        wildcardMode=true
      fi

      source="${source/#"./"/"${dotfiles%/}/"}"
      link="${link/#"./"/"${dotfiles%/}/"}"
      source="${source%"/*"}"
      link="${link%"/*"}"
      source="${source%/}"
      link="${link%/}"

      if [[ ! -e ${source%/} ]]; then
        log::warning "The source ⌜${source}⌝ does not exist, skipping (defined in ${linkFile})."
        continue
      fi

      if [[ ${wildcardMode} == "true" ]]; then
        log::debug "Creating link for each file/directory in the directory ${source}."

        fs::listFiles "${source}" includeHidden=true
        local sourcePath fileName
        for sourcePath in "${REPLY_ARRAY[@]}"; do
          fileName="${sourcePath##*/}"
          links+=("${link}/${fileName}")
          sources+=("${sourcePath}")
          modes+=("${mode}")
        done

        continue
      fi

      links+=("${link}")
      sources+=("${source}")
      modes+=("${mode}")
    done
  done

  local -a existingLinks=() existingFiles=()
  for link in "${links[@]}"; do
    if [[ -L ${link} ]]; then
      existingLinks+=("${link}")
    elif [[ -e ${link} ]]; then
      existingFiles+=("${link}")
    fi
  done

  if ((${#existingFiles[@]} > 0)); then
    log::warning "The following ${#existingFiles[@]} existing files must be removed to be replaced by links:"
    local link
    for link in "${existingFiles[@]}"; do
      log::printString " - ${link}"
    done

    if [[ ${force:-false} != "true" ]] && ! interactive::confirm "Do you want to proceed and remove the files listed above?" default=false; then
      core::fail "Aborting link creation due to existing files."
    fi
  fi

  log::info "${#existingLinks[@]} existing links will be replaced."

  log::info "Links created:"
  local -i index
  local hardlinkText
  for index in "${!links[@]}"; do
    if [[ ${modes[index]} == *"h"* ]]; then
      fs::createLink "${sources[index]}" "${links[index]}" hardlink=true force=true
      hardlinkText=" (hardlink)"
    else
      fs::createLink "${sources[index]}" "${links[index]}" force=true
      hardlinkText=""
    fi
    log::printString "╭─ ${links[index]}${hardlinkText}" newLinePadString="│  "
    log::printString "╰──▶ ${sources[index]}" newLinePadString="     "
  done

  log::success "${#links[@]} links created successfully."
}
