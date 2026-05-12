#!/usr/bin/env bash

command::sourceFunction extensionsUpdate

include fs

function main() {

  fs::createTempDirectory pathOnly=true
  export VALET_CONFIG_EXTENSIONS_DIRECTORY="${REPLY}"

  test::title "✅ Testing extensions update no extensions"
  test::setTerminalInputs y
  test::exec extensionsUpdate

  local targetDirectory

  targetDirectory="${VALET_CONFIG_EXTENSIONS_DIRECTORY}/extension-already-up-to-date"
  mkdir -p "${targetDirectory}/.git"
  printf "%s" "ref: refs/heads/main" >"${targetDirectory}/.git/HEAD"

  targetDirectory="${VALET_CONFIG_EXTENSIONS_DIRECTORY}/extension-detached-head"
  mkdir -p "${targetDirectory}/.git"
  printf "%s" "xxxx" >"${targetDirectory}/.git/HEAD"

  targetDirectory="${VALET_CONFIG_EXTENSIONS_DIRECTORY}/extension-error-fetch"
  mkdir -p "${targetDirectory}/.git"
  printf "%s" "ref: refs/heads/main" >"${targetDirectory}/.git/HEAD"

  targetDirectory="${VALET_CONFIG_EXTENSIONS_DIRECTORY}/extension-not-updatable"
  mkdir -p "${targetDirectory}"

  targetDirectory="${VALET_CONFIG_EXTENSIONS_DIRECTORY}/extension-to-update-with-fail-setup"
  mkdir -p "${targetDirectory}/.git"
  printf "%s" "ref: refs/heads/main" >"${targetDirectory}/.git/HEAD"
  echo '1.0.0' >"${targetDirectory}/version"
  echo 'core::fail "Simulating a fail in the setup script."' >"${targetDirectory}/extension.setup.sh"

  targetDirectory="${VALET_CONFIG_EXTENSIONS_DIRECTORY}/extension-to-update-with-ok-setup"
  mkdir -p "${targetDirectory}/.git"
  printf "%s" "ref: refs/heads/main" >"${targetDirectory}/.git/HEAD"
  echo '2.0.0' >"${targetDirectory}/VERSION"
  echo 'log::warning "This is a setup script!"' >"${targetDirectory}/extension.setup.sh"

  targetDirectory="${VALET_CONFIG_EXTENSIONS_DIRECTORY}/extension-to-update-with-ok-setup-but-skipped-setup"
  mkdir -p "${targetDirectory}/.git"
  printf "%s" "ref: refs/heads/main" >"${targetDirectory}/.git/HEAD"
  echo 'log::warning "This is a setup script!"' >"${targetDirectory}/extension.setup.sh"

  targetDirectory="${VALET_CONFIG_EXTENSIONS_DIRECTORY}/extension-to-update-wo-setup"
  mkdir -p "${targetDirectory}/.git"
  printf "%s" "ref: refs/heads/main" >"${targetDirectory}/.git/HEAD"

  targetDirectory="${VALET_CONFIG_EXTENSIONS_DIRECTORY}/extension-to-update-wo-setup-skipped"
  mkdir -p "${targetDirectory}/.git"
  printf "%s" "ref: refs/heads/main" >"${targetDirectory}/.git/HEAD"

  test::title "✅ Testing extensions update"
  test::setTerminalInputs y y y y y n y n
  test::exec extensionsUpdate

  test::title "✅ Testing extensions unattended update"
  test::exec extensionsUpdate -n extension-to-update-with-ok-setup --unattended --skip-setup

  # fs::readFile "${VALET_CONFIG_EXTENSIONS_DIRECTORY}/repo-setup-ok-unattended/.git/.valet-setup-executed"
  # if [[ ${REPLY} != "abc1234" ]]; then
  #   test::fail "The setup script of the extension has not been executed (REPLY: ${REPLY})."
  # fi
}

function command() {
  if [[ ${1} == "-v" ]]; then
    return 0
  fi
  "${@}"
}

function git() {
  IFS=" "
  echo "mocking git $*" 1>&2

  if [[ ${1} == "-C" ]]; then
    targetDirectory="${2}"
    shift 2
  else
    targetDirectory="${PWD}"
  fi

  case "${1}" in
  rev-parse)
    if [[ ${2} == "HEAD" || ${targetDirectory} == *"already-up-to-date"* ]]; then
      echo "old1234000000"
      return 0
    fi
    echo "mocking git rev-parse HEAD with a fake commit hash" 1>&2
    echo "new1234000000"
    return 0
    ;;
  fetch)
    if [[ ${targetDirectory} == *"error-fetch"* ]]; then
      echo "could not fetch!" 1>&2
      return 1
    fi
    return 0
    ;;
  merge)
    if [[ ${targetDirectory} == *"extension-to-update-with-fail-setup"* ]]; then
      echo '1.1.0' >"${targetDirectory}/version"
    fi
    if [[ ${targetDirectory} == *"extension-to-update-with-ok-setup"* ]]; then
      echo '2.1.0' >"${targetDirectory}/VERSION"
    fi
    return 0
    ;;
  *)
    test::fail "mocking git with no specific behavior for the command: ${*}"
    ;;
  esac

}

main
