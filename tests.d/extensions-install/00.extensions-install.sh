#!/usr/bin/env bash

command::sourceFunction extensionsInstall
command::sourceFunction selfDocument

include fs

function main() {
  # override git for the tests
  chmod +x "${PWD}/git"
  export PATH="${PWD}:${PATH}"

  fs::createTempDirectory pathOnly=true
  export VALET_CONFIG_EXTENSIONS_DIRECTORY="${REPLY}"

  test::title "✅ Testing extensions install command with no options"
  test::setTerminalInputs y
  test::exec extensionsInstall https://git.ok/repo-version-with-setup.git

  fs::readFile "${VALET_CONFIG_EXTENSIONS_DIRECTORY}/repo-version-with-setup/.git/.valet-setup-executed"
  if [[ ${REPLY} != "abc1234000000" ]]; then
    test::fail "The setup script of the extension has not been executed (REPLY: ${REPLY})."
  fi

  test::title "✅ Testing extensions install aborting because existing extension"
  test::setTerminalInputs n
  test::exec extensionsInstall https://git.ok/repo-version-with-setup.git
  test::exec extensionsInstall https://git.ok/repo-version-with-setup.git --unattended

  test::title "✅ Testing extensions install error on clone"
  test::exit extensionsInstall https://git.ok/repo-error.git --unattended --name xxxx

  test::title "✅ Testing extensions install error on checkout and unattended"
  test::exit extensionsInstall https://git.ok/repo-ok.git --unattended --name other --version error

  test::title "✅ Testing extensions install error on checkout and interactive"
  test::setTerminalInputs n
  test::exit extensionsInstall https://git.ok/repo-ok.git --name other2 --version error

  test::title "✅ Testing extensions install error on checkout, interactive and then fail setup script"
  test::setTerminalInputs y y n
  test::exit extensionsInstall https://git.ok/repo-fail-VERSION.git --name other2 --version error

  test::title "✅ Testing extensions install fail setup script then accept"
  test::setTerminalInputs y y
  test::exec extensionsInstall https://git.ok/repo-fail.git

  test::title "✅ Testing extensions install skipping setup"
  test::exit extensionsInstall https://git.ok/repo-setup-ok.git --skip-setup

  test::title "✅ Testing extensions install setup unattended"
  test::exit extensionsInstall https://git.ok/repo-setup-ok-unattended.git --unattended
}

function selfDocument() {
  log::info "Called selfDocument."
}

function command::reloadCommandsIndex() {
  log::info "Called command::reloadCommandsIndex."
}

main
