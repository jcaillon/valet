#!/usr/bin/env bash
# Title:         valet.d/commands/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet)
if [ -z "${_MAIN_INCLUDED:-}" ]; then
  VALETD_DIR="${BASH_SOURCE[0]}"
  VALETD_DIR="${VALETD_DIR%/*}" # strip file name
  VALETD_DIR="${VALETD_DIR%/*}" # strip directory
  # shellcheck source=../main
  source "${VALETD_DIR}/main"
fi
# --- END OF COMMAND COMMON PART

#===============================================================
# >>> self release valet
#===============================================================
function about_selfRelease() {
  echo "
command: self release
fileToSource: ${BASH_SOURCE[0]}
shortDescription: Release a new version of valet.
description: |-
  Release a new version of valet.

  It will:
  - creates a git tag and pushes it to the remote repository,
  - bump the version of valet,
  - commit the new version.
options:
  - name: -t, --github-release-token <token>
    description: |-
      The token necessary to create the release on GitHub and upload artifacts.
  - name: -b, --bump-level <semver>
    description: |-
      The semver level to bump the version.

      Can be either: major or minor.
  - name: --dry-run
    description: |-
      Do not perform the release, just show what would be done.
"
}

function selfRelease() {
  parseArguments "$@" && eval "${LAST_RETURNED_VALUE}"
  checkParseResults "${help:-}" "${parsingErrors:-}"

  if [[ "${dryRun:-}" == "true" ]]; then
    inform "Dry run mode is enabled, no changes will be made."
  else
    # check that we got the necessary token
    if [[ -z "${githubReleaseToken:-}" ]]; then
      fail "The GitHub release token is required to create a new release."
    fi

    # check that the git workarea is clean
    debug "Checking if the workarea is clean"
    git update-index --really-refresh 1>/dev/null || true
    if ! git diff-index --quiet HEAD; then
      fail "The workarea is not clean, please commit your changes before releasing a new version."
    fi
  fi

  # read the version from the valet file
  local version
  IFS= read -rd '' version <"${VALET_HOME}/valet.d/version" || true
  version="${version%%$'\n'*}"
  inform "The current version of valet is: ${version}"

  # create a new git tag with the version
  if [[ "${dryRun:-}" != "true" ]]; then
    git tag -a "v${version}" -m "Release version ${version}"
    git push origin "v${version}"
    succeed "The new version has been tagged and pushed to the remote repository."
  fi

  # bump the version
  local -i level semVerNumber semVerIndex
  [[ "${bumpLevel:-}" == "major" ]] && level=1 || level=2
  local newVersion
  for semVerIndex in {1..2}; do
    cutF "${version}" "${semVerIndex}" "." && semVerNumber="${LAST_RETURNED_VALUE%-*}"
    [[ semVerIndex -eq level ]] && semVerNumber=$((semVerNumber + 1))
    [[ semVerIndex -eq 2 && level -eq 1 ]] && semVerNumber=0
    newVersion+="${semVerNumber}."
  done
  newVersion="${newVersion}0"
  [[ "${dryRun:-}" != "true" ]] && echo "${newVersion}" >"${VALET_HOME}/valet.d/version"
  inform "The new version of valet is: ${newVersion}"

  return 0
}
