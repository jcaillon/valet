#!/usr/bin/env bash
# Title:         valet.d/commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ -z "${GLOBAL_CORE_INCLUDED:-}" ]]; then
  # shellcheck source=../core
  source "$(dirname -- "$(command -v valet)")/valet.d/core"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../lib-string
source string
# shellcheck source=../lib-kurl
source kurl

#===============================================================
# >>> self release valet
#===============================================================
: "---
command: self release
function: selfRelease
hideInMenu: true
author: github.com/jcaillon
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
- name: --upload-artifacts-only
  description: |-
    Do no create the release, just upload the artifacts to the latest release.
---"
function selfRelease() {
  core::parseArguments "$@" && eval "${RETURNED_VALUE}"
  core::checkParseResults "${help:-}" "${parsingErrors:-}"

  if [[ ${dryRun:-} == "true" ]]; then
    log::info "Dry run mode is enabled, no changes will be made."
  fi

  if [[ "${uploadArtifactsOnly:-}" != "true" ]]; then
    # create a new release
    createRelease "${githubReleaseToken:-}" "${bumpLevel:-}" "${dryRun:-}"
    createdReleaseJson="${RETURNED_VALUE}"
  else
    # get the latest release
    kurl::toVar true '200' -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/jcaillon/valet/releases/latest"
    createdReleaseJson="${RETURNED_VALUE}"
  fi

  if [[ -n "${createdReleaseJson}" ]]; then
    string::extractBetween "${createdReleaseJson}" '"upload_url":' '{?name,label}"'
    string::extractBetween "${RETURNED_VALUE}" '"' ''
    uploadUrl="${RETURNED_VALUE}"
    log::debug "The upload URL is: ${uploadUrl:-}"
  fi

  if [[ "${dryRun:-}" != "true" ]]; then
    uploadArtifact "${uploadUrl}"
  fi

  log::success "The new version has been released, check: ⌜https://github.com/jcaillon/valet/releases/latest⌝."

  return 0
}

function createRelease() {
  local githubReleaseToken bumpLevel dryRun
  githubReleaseToken="${1:-}"
  bumpLevel="${2:-minor}"
  dryRun="${3:-false}"

  if [[ "${dryRun:-}" != "true" ]]; then
    # check that we got the necessary token
    if [[ -z "${githubReleaseToken:-}" ]]; then
      core::fail "The GitHub release token is required to create a new release."
    fi

    # check that the git workarea is clean
    log::debug "Checking if the workarea is clean"
    io::invoke3 false 0 git update-index --really-refresh 1>/dev/null || :
    local -i exitCode=0
    io::invoke3 false 0 git diff-index --quiet HEAD || exitCode=$?
    if [[ exitCode -ne 0 ]]; then
      core::fail "The workarea is not clean, please commit your changes before releasing a new version."
    fi
  fi

  # read the version from the valet file
  io::readFile "${GLOBAL_VALET_HOME}/valet.d/version"
  local version="${RETURNED_VALUE}"
  version="${version%%$'\n'*}"
  log::info "The current version of valet is: ${version}."

  # write the current version in the self-install script
  # then commit the file
  if [[ "${dryRun:-}" != "true" ]]; then
    io::invoke sed -E -i "s/VALET_VERSION=\"[0-9]+\.[^\"]+\"/VALET_VERSION=\"${version}\"/" "${GLOBAL_VALET_HOME}/valet.d/commands.d/self-install.sh"

    io::invoke git add "${GLOBAL_VALET_HOME}/valet.d/commands.d/self-install.sh"
    io::invoke git commit -m ":rocket: releasing version ${version}"
    io::invoke git push origin main
    log::success "The new version has been committed."
  fi

  # get the current latest tag
  local lastTag
  io::invoke git tag --sort=committerdate --no-color
  lastTag="${RETURNED_VALUE}"
  lastTag="${lastTag%%$'\n'}"
  lastTag="${lastTag##*$'\n'}"
  log::info "The last tag is: ${lastTag}."

  # prepare the tag message
  local tagMessage line
  tagMessage="# Release of version ${version}"$'\n'$'\n'
  tagMessage+="Changelog: "$'\n'$'\n'
  io::invoke git log --pretty=format:"%s" "${lastTag}..HEAD"
  local IFS=$'\n'
  for line in ${RETURNED_VALUE}; do
    if [[ ${line} == ":bookmark:"* ]]; then
      continue
    fi
    tagMessage+="- ${line}"$'\n'
  done
  IFS=$' '
  log::info "The tag message is:"$'\n'"${tagMessage}"

  # create a new git tag with the version and push it
  if [[ "${dryRun:-}" != "true" ]]; then
    io::invoke git tag -a "v${version}" -m "Release version ${version}"
    io::invoke git push origin "v${version}"
    log::success "The new version has been tagged and pushed to the remote repository."
  fi

  # bump the version
  string::bumpSemanticVersion "${version}" "${bumpLevel:-minor}" && newVersion="${RETURNED_VALUE}"
  if [[ "${dryRun:-}" != "true" ]]; then printf '%s' "${newVersion}" >"${GLOBAL_VALET_HOME}/valet.d/version"; fi
  log::info "The new version of valet is: ${newVersion}."

  # commit the new version and push it
  if [[ "${dryRun:-}" != "true" ]]; then
    io::invoke git add "${GLOBAL_VALET_HOME}/valet.d/version"
    io::invoke git commit -m ":bookmark: bump version to ${newVersion}"
    io::invoke git push origin main
    log::success "The new version has been committed."
  fi

  # prepare the release payload
  local prerelease=false
  if [[ ${version} == *"-"* ]]; then prerelease=true; fi
  local releasePayload
  releasePayload="{
    \"tag_name\": \"v${version}\",
    \"body\": \"${tagMessage//$'\n'/\\n}\",
    \"draft\": false,
    \"prerelease\": ${prerelease}
  }"
  log::debug "The release payload is: ⌜${releasePayload}⌝"

  # create the release on GitHub
  local uploadUrl
  local createdReleaseJson
  if [[ "${dryRun:-}" != "true" ]]; then
    kurl::toVar true '201,422' -X POST \
      -H "Authorization: token ${githubReleaseToken:-}" \
      -H "Accept: application/vnd.github.v3+json" \
      -H "Content-type: application/json; charset=utf-8" \
      -d "${releasePayload}" \
      "https://api.github.com/repos/jcaillon/valet/releases"

    createdReleaseJson="${RETURNED_VALUE}"

    log::success "The new version has been released on GitHub."
  fi

  RETURNED_VALUE="${createdReleaseJson:-}"
}

function uploadArtifact() {
  local uploadUrl="${1}"

  # prepare a temp folder to store the release
  local tempDir="${GLOBAL_VALET_HOME}/.tmp"
  rm -Rf "${tempDir}"
  mkdir -p "${tempDir}"
  pushd "${tempDir}" 1>/dev/null

  local -a files
  files=(examples.d valet.d valet)

  # copy each file from valet dir to current dir
  local file
  for file in "${files[@]}"; do
    io::invoke cp -R "${GLOBAL_VALET_HOME}/${file}" .
  done

  # prepare artifact
  local artifactPath="valet.tar.gz"
  io::invoke tar -czvf "${artifactPath}" "${files[@]}"
  log::debug "The artifact has been created at ⌜${artifactPath}⌝ with:"$'\n'"${RETURNED_VALUE}"

  # upload the artifact
  if [[ "${dryRun:-}" != "true" && -n "${uploadUrl}" ]]; then
    log::info "Uploading the artifact ⌜${artifactPath}⌝ to ⌜${uploadUrl}⌝."
    kurl::toVar true '' -X POST \
      -H "Authorization: token ${githubReleaseToken:-}" \
      -H "Content-Type: application/tar+gzip" \
      --data-binary "@${artifactPath}" \
      "${uploadUrl}?name=${artifactPath}"
  fi

  rm -f "${artifactPath}"
  popd 1>/dev/null
  rm -Rf "${tempDir}"
}
