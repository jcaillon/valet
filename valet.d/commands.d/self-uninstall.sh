#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> command: self uninstall
#===============================================================

##<<VALET_COMMAND
# command: self uninstall
# function: selfUninstall
# hideInMenu: true
# author: github.com/jcaillon
# shortDescription: A command to uninstall Valet.
# description: |-
#   Generate a bash script that can be used to uninstall Valet.
#   Without any option, this script will print instructions instead.
#
#   Usage:
#
#   ```bash
#   eval "$(valet self uninstall --script)"
#   ```
# options:
# - name: -s, --script
#   description: |-
#     Generate a bash script that can be evaluated in bash to uninstall Valet.
##VALET_COMMAND
function selfUninstall() {
  local script
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  if [[ ${script:-} == "true" ]]; then
    if [[ ! -f "${GLOBAL_VALET_HOME}/valet" ]]; then
      core::fail "Valet does not seem installed, please call this command from an installed Valet."
    fi
    core::getConfigurationDirectory
    local configurationDirectory="${RETURNED_VALUE}"
    core::getLocalStateDirectory
    local localStateDirectory="${RETURNED_VALUE}"
    core::getUserDirectory
    local userDirectory="${RETURNED_VALUE}"

    # shellcheck disable=SC2016
    echo '#!/usr/bin/env bash
# remove main installation of Valet
rm -Rf "'"${GLOBAL_VALET_HOME}"'"
# remove the user configuration
rm -Rf "'"${configurationDirectory}"'"
# remove the user state
rm -Rf "'"${localStateDirectory}"'"
# remove the user directory
rm -Rf "'"${userDirectory}"'"
# remove a possible symlink
rm -f "'"$(which valet)"'" 2>/dev/null || :
echo "Valet has been uninstalled."
'
  else
    log::warning "To uninstall Valet, you can run the following commands:"$'\n' \
      "bash -c 'eval \"\$(valet self uninstall --script 2>/dev/null)\"'"
  fi
}
