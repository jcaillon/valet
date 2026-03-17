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
    Replace existing targets without confirmation when creating the links (dangerous).
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
  local -a links=() sources=() hardlinks=()
  local linkFile line link source hardlink
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
        if [[ ${BASH_REMATCH[2]} == *"h"* ]]; then
          hardlink=true
        else
          hardlink=false
        fi
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

        fs::getAbsolutePath "${source}"
        fs::listFiles "${REPLY}" includeHidden=true
        local sourcePath fileName
        for sourcePath in "${REPLY_ARRAY[@]}"; do
          fileName="${sourcePath##*/}"
          links+=("${link}/${fileName}")
          sources+=("${sourcePath}")
          hardlinks+=("${hardlink}")
        done
      else
        links+=("${link}")
        sources+=("${source}")
        hardlinks+=("${hardlink}")
      fi
    done
  done

  local -a existingDirectories=() existingFiles=() indexesToUpdate=()
  local -i index
  local hardlink
  for index in "${!links[@]}"; do
    if fs::isValidLink "${sources[index]}" "${links[index]}" hardlink="${hardlinks[index]}"; then
      log::debug "The link ⌜${links[index]}⌝ already exists and is correctly linked to the source ⌜${sources[index]}⌝, skipping."
      continue
    fi
    if [[ -d ${links[index]} && ! -L ${links[index]} ]]; then
      existingDirectories+=("${links[index]}")
    elif [[ -e ${links[index]} ]]; then
      existingFiles+=("${links[index]}")
    fi
    indexesToUpdate+=("${index}")
  done

  if ((${#existingFiles[@]} > 0)); then
    log::warning "The following ${#existingFiles[@]} existing files must be removed to be replaced by links:"
    local file
    for file in "${existingFiles[@]}"; do
      log::printString " - ${file}"
    done
  fi
  if ((${#existingDirectories[@]} > 0)); then
    log::warning "The following ${#existingDirectories[@]} existing directories must be removed to be replaced by links:"
    local dir
    for dir in "${existingDirectories[@]}"; do
      log::printString " - ${dir}"
    done
  fi
  if ((${#existingFiles[@]} > 0 || ${#existingDirectories[@]} > 0)); then
    if [[ ${force:-false} != "true" ]] && ! interactive::confirm "Do you want to proceed and remove the paths listed above?" default=false; then
      core::fail "Aborting link creation due to existing files."
    fi
  fi

  if ((${#indexesToUpdate[@]} > 0)); then

    log::info "Creating links:"
    local hardlinkText
    for index in "${indexesToUpdate[@]}"; do
      fs::createLink "${sources[index]}" "${links[index]}" hardlink="${hardlinks[index]}" force=true
      if [[ ${hardlinks[index]} == "true" ]]; then
        hardlinkText=" (hardlink)"
      else
        hardlinkText=""
      fi
      log::printString "╭─ ${links[index]}${hardlinkText}" newLinePadString="│  "
      log::printString "╰──▶ ${sources[index]}" newLinePadString="     "
    done

    log::success "${#indexesToUpdate[@]} links created successfully."
  else
    log::success "All links are already correctly set up, nothing to do."
  fi

}
