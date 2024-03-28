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

# shellcheck source=utils
source "${VALET_HOME}/valet.d/commands.d/utils"

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

  # get the current latest tag
  local lastTag
  lastTag="$(git tag --sort=committerdate --no-color)"
  lastTag="${lastTag%%$'\n'*}"

  # prepare the tag message
  local tagMessage line
  tagMessage="# Release of version ${version}"$'\n'$'\n'
  tagMessage+="Changelog: "$'\n'$'\n'
  while read -r line; do
    tagMessage+="- ${line}"$'\n'
  done < <(git log --pretty=format:"%s" "${lastTag}..HEAD")
  inform "The tag message is: ${tagMessage}"

  # create a new git tag with the version
  if [[ "${dryRun:-}" != "true" ]]; then
    git tag -a "v${version}" -m "Release version ${version}"
    git push origin "v${version}"
    succeed "The new version has been tagged and pushed to the remote repository."
  fi

  # bump the version
  bumpSemanticVersion "${version}" "${bumpLevel:-minor}" && newVersion="${LAST_RETURNED_VALUE}"
  [[ "${dryRun:-}" != "true" ]] && echo "${newVersion}" >"${VALET_HOME}/valet.d/version"
  inform "The new version of valet is: ${newVersion}"

  # commit the new version
  if [[ "${dryRun:-}" != "true" ]]; then
    git add "${VALET_HOME}/valet.d/version"
    git commit -m "🔖 bump version to ${newVersion}"
    git push origin main
    succeed "The new version has been committed."
  fi

  # prepare the release payload
  local releasePayload
  releasePayLoad="{
    \"tag_name\": \"v${version}\",
    \"body\": \"${tagMessage}\",
    \"draft\": false,
    \"prerelease\": false
  }"

  # push the release to GitHub
  if [[ "${dryRun:-}" != "true" ]]; then
    curl -X POST --location --fail --location \
      -H "Authorization: token ${githubReleaseToken}" \
      -H "Accept: application/vnd.github.v3+json" \
      -d "${releasePayload}" \
      "https://api.github.com/repos/jcaillon/valet/releases"
    succeed "The new version has been released on GitHub."
  fi



  return 0
}
