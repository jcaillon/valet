#!/usr/bin/env bash
# author: github.com/jcaillon
# description: this script is a valet command

# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-exe
source exe
# shellcheck source=../libraries.d/lib-progress
source progress
# shellcheck source=../libraries.d/lib-interactive
source interactive
# shellcheck source=./extensions-utils
source ./extensions-utils

#===============================================================
# >>> command: extensions init
#===============================================================

: <<"COMMAND_YAML"
command: extensions update
function: extensionsUpdate
author: github.com/jcaillon
shortDescription: Update Valet extensions.

description: |-
  Update Valet extensions.

options:
- name: -n, --name <extension-name>
  description: |-
    The name of the extension to update.
    If not provided, defaults to updating all extensions.
- name: --skip-setup
  description: |-
    Skip the execution of the `extension.setup.sh` scripts even when they exist.
  default: false
- name: --unattended
  description: |-
    Set to true to install without interactive confirmation.
  default: false

examples:
- name: extensions update
  description: |-
    Update all Valet extensions.
COMMAND_YAML
function extensionsUpdate() {
  command::parseArguments "$@"
  eval "${REPLY}"
  command::checkParsedResults

  if ! command -v git &>/dev/null; then
    core::fail "The command ⌜git⌝ is not installed or not found in your PATH, extensions cannot be automatically updated. Consider installing git or check your PATH variable."
  fi

  core::getExtensionsDirectory
  local extensionsDirectory="${REPLY}"

  local -a REPLY_ARRAY=()
  if [[ -n ${name} ]]; then
    if [[ ! -d ${extensionsDirectory}/${name} ]]; then
      core::fail "The extension ⌜${name}⌝ does not exist in ⌜${extensionsDirectory}⌝."
    fi
    REPLY_ARRAY=("${extensionsDirectory}/${name}")
  else
    fs::listDirectories "${extensionsDirectory}"
    if ((${#REPLY_ARRAY[@]} == 0)); then
      log::info "You do not have any extensions created or installed yet."
      return 0
    fi
  fi

  local -a names=() oldVersions=() newVersions=() setupStatuses=()
  local -i updatedCount=0

  local name
  for extensionDirectory in "${REPLY_ARRAY[@]}"; do
    name="${extensionDirectory##*/}"
    names+=("${name}")

    if [[ ! -f "${extensionDirectory}/.git/HEAD" ]]; then
      oldVersions+=("-")
      newVersions+=("-")
      setupStatuses+=("${STYLE_COLOR_FADED}Can't update, not a git repo${STYLE_RESET}")
      continue
    fi

    # get old version
    extensions::getVersion "${extensionDirectory}"
    oldVersions+=("${REPLY:-"-"}")

    # update
    if extensionsUpdate_updateGitRepository "${extensionDirectory}" "${unattended:-}"; then
      if [[ ${REPLY} != "true" ]]; then
        newVersions+=("${oldVersions[-1]}")
        setupStatuses+=("${STYLE_COLOR_SUCCESS}Already up-to-date${STYLE_RESET}")
        continue
      fi
      updatedCount+=1
      extensions::getVersion "${extensionDirectory}"
      newVersions+=("${REPLY}")
      if [[ -f ${extensionDirectory}/extension.setup.sh ]]; then

        # execute the setup script of the extension, if any
        if [[ ${skipSetup:-} != "true" ]]; then
          extensions::executeSetupScript "${extensionDirectory}" "${unattended}"
          if ((REPLY_CODE != 0)); then
            log::info "You can manually retry the setup by running the script ⌜${extensionDirectory}/extension.setup.sh⌝."
            setupStatuses+=("${STYLE_COLOR_ERROR}Updated with setup errors${STYLE_RESET}")
            continue
          fi
        else
          log::info "Skipping the execution of the ⌜extension.setup.sh⌝ script."
        fi

        if extensions::isSetupExecuted "${extensionDirectory}"; then
          setupStatuses+=("${STYLE_COLOR_SUCCESS}Updated and setup${STYLE_RESET}")
        else
          setupStatuses+=("${STYLE_COLOR_WARNING}Updated but not setup${STYLE_RESET}")
        fi
      else
        setupStatuses+=("${STYLE_COLOR_SUCCESS}Updated${STYLE_RESET}")
      fi
    else
      if ((PIPESTATUS[0] == 2)); then
        newVersions+=("${oldVersions[-1]}")
        setupStatuses+=("${STYLE_COLOR_WARNING}Update skipped${STYLE_RESET}")
        continue
      fi
      newVersions+=("-")
      setupStatuses+=("${STYLE_COLOR_ERROR}Update errors${STYLE_RESET}")
      continue
    fi
  done

  if ((${#names[@]} == 0)); then
    log::info "No extensions to update."
    return 0
  fi

  # display the table
  local \
    titleName="Extension name" \
    titleOldVersion="Previous version" \
    titleNewVersion="New version" \
    titleSetupStatus="Setup status"

  local name oldVersion newVersion setupStatus
  local -i index maxLengthName=${#titleName} maxLengthOldVersion=${#titleOldVersion} maxLengthNewVersion=${#titleNewVersion} maxLengthSetupStatus=${#titleSetupStatus}
  for index in "${!names[@]}"; do
    name="${names[index]}"
    oldVersion="${oldVersions[index]}"
    newVersion="${newVersions[index]}"
    setupStatus="${setupStatuses[index]}"
    if ((${#name} > maxLengthName)); then
      maxLengthName=${#name}
    fi
    if ((${#oldVersion} > maxLengthOldVersion)); then
      maxLengthOldVersion=${#oldVersion}
    fi
    if ((${#newVersion} > maxLengthNewVersion)); then
      maxLengthNewVersion=${#newVersion}
    fi
    if ((${#setupStatus} > maxLengthSetupStatus)); then
      maxLengthSetupStatus=${#setupStatus}
    fi
  done

  local output line

  # header and separator
  printf -v line "${STYLE_COLOR_ACCENT}%-${maxLengthName}s${STYLE_RESET} ${SYMBOL_VR_LINE} ${STYLE_COLOR_PRIMARY}%-${maxLengthOldVersion}s${STYLE_RESET} ${SYMBOL_VR_LINE} ${STYLE_COLOR_PRIMARY}%-${maxLengthNewVersion}s${STYLE_RESET} ${SYMBOL_VR_LINE} ${STYLE_COLOR_PRIMARY}%-${maxLengthSetupStatus}s${STYLE_RESET}\n" "${titleName}" "${titleOldVersion}" "${titleNewVersion}" "${titleSetupStatus}"
  output+="${line}"
  printf -v line "%-${maxLengthName}s ${SYMBOL_CROSS} %-${maxLengthOldVersion}s ${SYMBOL_CROSS} %-${maxLengthNewVersion}s ${SYMBOL_CROSS} %-${maxLengthSetupStatus}s\n" " " " " " " " "
  output+="${line// /"${SYMBOL_HR_LINE}"}"

  # lines
  for index in "${!names[@]}"; do
    printf -v line "%-${maxLengthName}s ${SYMBOL_VR_LINE} ${STYLE_COLOR_FADED}%-${maxLengthOldVersion}s${STYLE_RESET} ${SYMBOL_VR_LINE} %-${maxLengthNewVersion}s ${SYMBOL_VR_LINE} %s\n" "${names[index]}" "${oldVersions[index]}" "${newVersions[index]}" "${setupStatuses[index]}"
    output+="${line}"
  done

  log::success "Updated ${updatedCount} extensions:"
  log::printString $'\n'"${output}"
}

# Update a git repository.
#
# Returns:
# - $?:0 if the repository was checked without errors, 1 otherwise.
# - ${REPLY}: true if the repository was updated, false otherwise.
function extensionsUpdate_updateGitRepository() {
  local \
    repoPath="${1}" \
    unattended="${2}"

  local extensionName="${repoPath##*/}"

  log::debug "Updating the git repository ⌜${repoPath}⌝."

  fs::readFile "${repoPath}/.git/HEAD"
  if [[ ${REPLY} =~ ^"ref: refs/heads/"(.+) ]]; then
    local branch="${BASH_REMATCH[1]:-}"
    branch="${branch%%$'\n'*}"

    extensions::getHead "${repoPath}"
    local currentHead="${REPLY}"
    log::debug "Current HEAD is ${currentHead}."

    log::debug "Fetching and merging branch ⌜${branch}⌝ from ⌜origin⌝ remote."

    progress::start template="<spinner> <message>" message="Fetching reference ${branch} for extension ${extensionName}..."
    exe::invoke command git -C "${repoPath}" fetch -q --- warnOnFailure=true failMessage="Failed to fetch for the repo ⌜${repoPath}⌝."
    progress::stop
    if ((REPLY_CODE != 0)); then
      return 1
    fi

    exe::invoke command git -C "${extensionDirectory}" rev-parse "origin/${branch}" --- warnOnFailure=true failMessage="Failed to get the sha1 of the commit for ⌜origin/${branch}⌝ for the repo ⌜${repoPath}⌝."
    if ((REPLY_CODE != 0)); then
      return 1
    fi
    string::trimAll REPLY
    local newHead="${REPLY}"

    if [[ ${newHead} == "${currentHead}" ]]; then
      log::info "The extension ${extensionName} is already up-to-date."
      REPLY=false
      return 0
    fi

    if [[ ${unattended:-} != "true" ]] && ! interactive::confirm "A new version is available for the extension ${extensionName}: ${currentHead:0:7}..${newHead:0:7}."$'\n'"Do you want to update the ⌜${extensionName}⌝ extension?"; then
      log::info "The extension ⌜${extensionName}⌝ will not be updated."
      return 2
    fi

    exe::invoke command git -C "${repoPath}" merge -q --ff-only "origin/${branch}" --- warnOnFailure=true failMessage="Failed to fast-forward merge ⌜origin/${branch}⌝ for the repo ⌜${repoPath}⌝, clean your workarea first (e.g. git stash, or git commit)."
    if ((REPLY_CODE != 0)); then
      return 1
    fi

    log::success "The extension ${extensionName} has been updated ${currentHead:0:7}..${newHead:0:7}."
  else
    log::warning "The extension ${extensionName} with repository ${repoPath} has a detached HEAD, could not update it (please check out a branch first)."
    return 1
  fi

  REPLY=true
  return 0
}
