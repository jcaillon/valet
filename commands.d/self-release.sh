#!/usr/bin/env bash
set -Eeu -o pipefail
# Title:         commands.d/*
# Description:   this script is a valet command
# Author:        github.com/jcaillon

# import the main script (should always be skipped if the command is run from valet, this is mainly for shellcheck)
if [[ ! -v GLOBAL_CORE_INCLUDED ]]; then
  # shellcheck source=../libraries.d/core
  source "$(dirname -- "$(command -v valet)")/libraries.d/core"
fi
# --- END OF COMMAND COMMON PART

# shellcheck source=../libraries.d/lib-string
source string
# shellcheck source=../libraries.d/lib-curl
source curl
# shellcheck source=../libraries.d/lib-interactive
source interactive
# shellcheck source=../libraries.d/lib-system
source system
# shellcheck source=../libraries.d/lib-array
source array
# shellcheck source=../libraries.d/lib-version
source version
# shellcheck source=../libraries.d/lib-exe
source exe
# shellcheck source=../libraries.d/lib-fs
source fs
# shellcheck source=../libraries.d/lib-regex
source regex

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
  - write the current version in the self-install script,
  - commit the file,
  - update the documentation,
  - commit the changes,
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

    Can be either: major or minor. Defaults to minor.
- name: --dry-run
  description: |-
    Do not perform the release, just show what would be done.
---"
function selfRelease() {
  command::parseArguments "$@" && eval "${RETURNED_VALUE}"
  command::checkParsedResults

  if [[ ${dryRun:-} == "true" ]]; then
    log::info "Dry run mode is enabled, no changes will be made."
  fi

  # get the current latest tag
  local lastLocalTag
  exe::invoke git tag --sort=version:refname --no-color
  lastLocalTag="${RETURNED_VALUE}"
  lastLocalTag="${lastLocalTag%%$'\n'}"
  lastLocalTag="${lastLocalTag##*$'\n'}"
  log::info "The last tag is: ${lastLocalTag}."

  # get the latest release
  local latestReleaseVersion
  curl::request true '200' -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/jcaillon/valet/releases/latest"
  lastReleaseJson="${RETURNED_VALUE}"
  if [[ ${lastReleaseJson} =~ "tag_name\":"([ ]?)"\"v"([^\"]+)"\"" ]]; then
    latestReleaseVersion="v${BASH_REMATCH[2]}"
    log::info "The latest release on GitHub is: ${latestReleaseVersion}."
  else
    log::debug "${RETURNED_VALUE}"
    log::warning "Could not get the latest version from GitHub (did not find tag_name)."
    latestReleaseVersion="${lastLocalTag}"
  fi

  # check if the release has already been created and we just need to upload the artifact
  local uploadUrl
  local uploadArtifactsOnly=false
  if [[ -n ${lastReleaseJson} && ${latestReleaseVersion} == "${lastLocalTag}" ]]; then
    selfRelease::extractUploadUrl "${lastReleaseJson}"
    uploadUrl="${RETURNED_VALUE}"
    if [[ ${lastReleaseJson} != *"browser_download_url"* ]]; then
      uploadArtifactsOnly=true
      log::info "The release has already been created, we will only upload the artifacts."
    fi
  fi

  if [[ "${uploadArtifactsOnly:-}" != "true" ]]; then
    # create a new release
    selfRelease::createRelease "${githubReleaseToken:-}" "${bumpLevel:-}" "${dryRun:-}" "${lastLocalTag}" "${latestReleaseVersion}"
    lastReleaseJson="${RETURNED_VALUE}"

    if [[ -n ${lastReleaseJson} ]]; then
      selfRelease::extractUploadUrl "${lastReleaseJson}"
      uploadUrl="${RETURNED_VALUE}"
    fi
  fi

  if [[ "${dryRun:-}" != "true" ]]; then
    selfRelease::uploadArtifact "${uploadUrl}"
  fi

  selfRelease::bumpVersion "${bumpLevel:-}" "${dryRun:-}"

  log::success "The new version has been released, check: https://github.com/jcaillon/valet/releases/latest."

  return 0
}

function selfRelease::createRelease() {
  local githubReleaseToken bumpLevel dryRun
  githubReleaseToken="${1:-}"
  bumpLevel="${2:-minor}"
  dryRun="${3:-false}"
  lastLocalTag="${4}"
  latestReleaseVersion="${5}"

  exe::invoke git rev-parse HEAD
  local currentHead="${RETURNED_VALUE%%$'\n'*}"

  # check if the latest release is the same as the last tag
  local uploadExistingTag=false
  if [[ ${latestReleaseVersion} != "${lastLocalTag}" ]]; then
    log::info "The latest release on GitHub is ${latestReleaseVersion} but the local latest tag is ${lastLocalTag}."
    if ! interactive::promptYesNo "Do you want to upload this tag (${lastLocalTag}) as a new version?" false; then
      core::fail "The release has been canceled."
    else
      uploadExistingTag=true
    fi
  fi

  if [[ "${dryRun:-}" != "true" ]]; then
    # check that we got the necessary token
    if [[ -z ${githubReleaseToken:-} ]]; then
      core::fail "The GitHub release token is required to create a new release."
    fi

    # check that the git workarea is clean
    log::debug "Checking if the workarea is clean"
    exe::invokef2 false git update-index --really-refresh 1>/dev/null || :
    local -i exitCode=0
    exe::invokef2 false git diff-index --quiet HEAD || exitCode=$?
    if [[ exitCode -ne 0 ]]; then
      core::fail "The workarea is not clean, please commit your changes before releasing a new version."
    fi
  fi

  # read the version from the valet file
  core::getVersion
  local version="${RETURNED_VALUE}"
  version="${version%%$'\n'*}"
  log::info "The current version of valet is: ${version}."

  # prepare the tag message
  local tagMessage line
  tagMessage="# Release of version ${version}"$'\n'$'\n'
  tagMessage+="Changelog: "$'\n'$'\n'
  exe::invoke git log --pretty=format:"%s" "${lastLocalTag}..HEAD"
  local IFS=$'\n'
  for line in ${RETURNED_VALUE}; do
    if [[ ${line} == ":bookmark:"* ]]; then
      continue
    fi
    tagMessage+="- ${line}"$'\n'
  done
  IFS=$' '
  log::info "The tag message is:"
  log::printFileString "${tagMessage}"

  if [[ "${uploadExistingTag:-}" != "true" ]]; then

    # update the documentation
    selfRelease::updateDocumentation

    # write the current version in the self-install script
    # then commit the file
    if [[ "${dryRun:-}" != "true" ]]; then
      exe::invoke sed -E -i "s/VALET_RELEASED_VERSION=\"[0-9]+\.[^\"]+\"/VALET_RELEASED_VERSION=\"${version}\"/" "${GLOBAL_INSTALLATION_DIRECTORY}/commands.d/self-install.sh"

      exe::invoke git add "${GLOBAL_INSTALLATION_DIRECTORY}/commands.d/self-install.sh"
      exe::invoke git commit -m ":rocket: releasing version ${version}"
      log::success "The new version has been committed."
    fi

    if ! interactive::promptYesNo "Do you want to continue with the release of version ${version}?" false; then
      # reset to the original head
      if [[ "${dryRun:-}" != "true" ]]; then
        exe::invoke git reset --hard "${currentHead}"
      fi
      core::fail "The release has been canceled."
    fi

    # create a new git tag with the version
    if [[ "${dryRun:-}" != "true" ]]; then
      exe::invoke git tag -a "v${version}" -m "${tagMessage}"
      log::success "The new version has been tagged."
    fi

  fi

  # push main and the new tag
  if [[ "${dryRun:-}" != "true" ]]; then
    exe::invoke git push origin main
    exe::invoke git push origin "v${version}"
    log::success "The ⌜main⌝ branch and the new version ⌜v${version}⌝ has been pushed."
  fi

  # force push the latest branch
  if [[ "${dryRun:-}" != "true" ]]; then
    exe::invoke git push origin -f main:latest
    log::success "The ⌜latest⌝ branch has been updated."
  fi

  # prepare the release payload
  local prerelease=false
  if [[ ${version} == *"-"* ]]; then prerelease=true; fi
  local releasePayload
  releasePayload="{
    \"name\": \"v${version}\",
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
    curl::request true '201,422' -X POST \
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

function selfRelease::uploadArtifact() {
  local uploadUrl="${1}"

  # prepare a temp folder to store the release
  local tempDir="${GLOBAL_INSTALLATION_DIRECTORY}/.tmp"
  rm -Rf "${tempDir}"
  mkdir -p "${tempDir}"
  pushd "${tempDir}" 1>/dev/null

  local -a files
  files=(examples.d commands.d libraries.d extras valet version)

  # copy each file from valet dir to current dir
  local file
  for file in "${files[@]}"; do
    exe::invoke cp -R "${GLOBAL_INSTALLATION_DIRECTORY}/${file}" .
  done

  # prepare artifact
  local artifactPath="valet.tar.gz"
  exe::invoke tar -czvf "${artifactPath}" "${files[@]}"
  log::debug "The artifact has been created at ⌜${artifactPath}⌝ with:"$'\n'"${RETURNED_VALUE}"

  # upload the artifact
  if [[ ${dryRun:-} != "true" && -n ${uploadUrl} ]]; then
    log::info "Uploading the artifact ⌜${artifactPath}⌝ to ⌜${uploadUrl}⌝."
    curl::request true '' -X POST \
      -H "Authorization: token ${githubReleaseToken:-}" \
      -H "Content-Type: application/tar+gzip" \
      --data-binary "@${artifactPath}" \
      "${uploadUrl}?name=${artifactPath}"
  fi

  rm -f "${artifactPath}"
  popd 1>/dev/null
  rm -Rf "${tempDir}"
}

function selfRelease::extractUploadUrl() {
  # shellcheck disable=SC2034
  local releaseJson="${1}"
  string::extractBetween releaseJson '"upload_url":' '{?name,label}"'
  uploadUrl="${RETURNED_VALUE}"
  string::extractBetween uploadUrl '"' ''
  uploadUrl="${RETURNED_VALUE}"
  log::debug "The upload URL is: ${uploadUrl:-}"
  RETURNED_VALUE="${uploadUrl}"
}

function selfRelease::bumpVersion() {
  local bumpLevel="${1:-minor}"
  local dryRun="${2:-false}"

  # read the version from the valet file
  core::getVersion
  local version="${RETURNED_VALUE}"
  version="${version%%$'\n'*}"
  log::info "The current version of valet is: ${version}."

  # bump the version
  version::bump "${version}" "${bumpLevel}" && newVersion="${RETURNED_VALUE}"
  if [[ "${dryRun:-}" != "true" ]]; then fs::writeToFile "${GLOBAL_INSTALLATION_DIRECTORY}/version" "${newVersion}"; fi
  log::info "The bumped version of valet is: ${newVersion}."

  # commit the new version and push it
  if [[ "${dryRun:-}" != "true" ]]; then
    exe::invoke git add "${GLOBAL_INSTALLATION_DIRECTORY}/version"
    exe::invoke git commit -m ":bookmark: bump version to ${newVersion}"
    exe::invoke git push origin main
    log::success "The bumped version has been committed."
  fi
}

function selfRelease::updateDocumentation() {
  command::sourceFunction selfDocument

  selfDocument::getFooter
  local pageFooter="${RETURNED_VALUE}"

  if [[ "${dryRun:-}" != "true" ]]; then
    selfDocument --core-only --output "${GLOBAL_INSTALLATION_DIRECTORY}/extras"
    selfRelease::writeAllFunctionsDocumentation "${pageFooter}"
  fi

  # export the valet config valet to the documentation
  if [[ "${dryRun:-}" != "true" ]]; then
    exe::invoke cp -f "${GLOBAL_INSTALLATION_DIRECTORY}/libraries.d/config.md" "${GLOBAL_INSTALLATION_DIRECTORY}/docs/static/config.md"
  fi

  # copy the vscode recommended extensions
  if [[ "${dryRun:-}" != "true" ]]; then
    exe::invoke cp "${GLOBAL_INSTALLATION_DIRECTORY}/.vscode/extensions.json" "${GLOBAL_INSTALLATION_DIRECTORY}/extras/extensions.json"
  fi

  # commit the changes to the documentation
  if [[ "${dryRun:-}" != "true" ]]; then
    exe::invoke git add "${GLOBAL_INSTALLATION_DIRECTORY}/docs/static/config.md"
    fs::listFiles "${GLOBAL_INSTALLATION_DIRECTORY}/docs/content/docs/300.libraries"
    array::sort RETURNED_ARRAY
    # remove _index.md (otherwise not consistent tests on the CI...)
    local -a files
    local file
    for file in "${RETURNED_ARRAY[@]}"; do
      if [[ ${file} == *"_index.md" ]]; then
        continue
      fi
      files+=("${file}")
    done
    exe::invoke git add "${files[@]}"
    fs::listFiles "${GLOBAL_INSTALLATION_DIRECTORY}/extras" true
    array::sort RETURNED_ARRAY
    exe::invoke git add "${RETURNED_ARRAY[@]}"
    exe::invoke git commit -m ":memo: updating the documentation"
    log::success "The documentation update has been committed."
  fi
}

# This function writes all the functions documentation to the documentation files
# under the `docs/content/docs/300.libraries` directory.
function selfRelease::writeAllFunctionsDocumentation() {
  local pageFooter="${1:-}"

  log::info "Writing the ${#SORTED_FUNCTION_NAMES[@]} functions documentation to the core libraries docs."

  # delete the existing files
  fs::listFiles "${GLOBAL_INSTALLATION_DIRECTORY}/docs/content/docs/300.libraries"
  local file
  for file in "${RETURNED_ARRAY[@]}"; do
    if [[ ${file} == *"_index.md" ]]; then
      continue
    fi
    exe::invoke rm -f "${file}"
  done

  # write the new files
  local key
  for key in "${SORTED_FUNCTION_NAMES[@]}"; do
    local functionName="${key}"
    regex::getFirstGroup functionName '([[:alnum:]]+)::'
    local packageName="${RETURNED_VALUE}"
    if [[ -z ${packageName} ]]; then
      # case for "source" function
      packageName="core"
    fi

    local path="${GLOBAL_INSTALLATION_DIRECTORY}/docs/content/docs/300.libraries/${packageName}.md"

    # init the file if necessary
    if [[ ! -f "${path}" ]]; then
      fs::writeToFile "${path}" "---
title: 📂 ${packageName}
cascade:
  type: docs
url: /docs/libraries/${packageName}
---

"
    fi

    # append the function documentation
    fs::writeToFile "${GLOBAL_INSTALLATION_DIRECTORY}/docs/content/docs/300.libraries/${packageName}.md" "RETURNED_ASSOCIATIVE_ARRAY[${key}]"$'\n'$'\n' true
  done

  # add footer
  fs::listFiles "${GLOBAL_INSTALLATION_DIRECTORY}/docs/content/docs/300.libraries"
  local file
  for file in "${RETURNED_ARRAY[@]}"; do
    if [[ ${file} == *"_index.md" ]]; then
      continue
    fi
    fs::writeToFile "${file}" $'\n'$'\n'"> ${pageFooter}"$'\n' true
  done
}
