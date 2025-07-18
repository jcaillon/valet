#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ ! -v GLOBAL_CORE_INCLUDED ]]; then
  # shellcheck source=../libraries.d/core
  source "$(valet --source)"
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
  command::parseArguments "$@" && eval "${REPLY}"
  command::checkParsedResults

  if [[ ${script:-} == "true" ]]; then
    if [[ ! -f "${GLOBAL_INSTALLATION_DIRECTORY}/valet" ]]; then
      core::fail "Valet does not seem installed, please call this command from an installed Valet."
    fi
    core::getConfigurationDirectory
    local configurationDirectory="${REPLY}"
    core::getUserDataDirectory
    local userDataDirectory="${REPLY}"
    core::getExtensionsDirectory
    local extensionsDirectory="${REPLY}"
    core::getUserCacheDirectory
    local userCacheDirectory="${REPLY}"

    # shellcheck disable=SC2016
    echo '#!/usr/bin/env bash
# remove main installation of Valet
rm -Rf "'"${GLOBAL_INSTALLATION_DIRECTORY}"'"
# remove the user configuration
rm -Rf "'"${configurationDirectory}"'"
# remove the user data
rm -Rf "'"${userDataDirectory}"'"
# remove the user cache
rm -Rf "'"${userCacheDirectory}"'"
# remove the user directory
rm -Rf "'"${extensionsDirectory}"'"
# remove a possible symlink
rm -f "'"$(which valet)"'" 2>/dev/null || :
echo "Valet has been uninstalled."
'
  else
    log::warning "To uninstall Valet, you can run the following commands:"$'\n' \
      "bash -c 'eval \"\$(valet self uninstall --script 2>/dev/null)\"'"
  fi
}
