#!/usr/bin/env bash

command::sourceFunction extensionsInit
command::sourceFunction selfDocument

include fs bash windows assert

function main() {
  fs::createTempDirectory pathOnly=true
  export VALET_CONFIG_EXTENSIONS_DIRECTORY="${REPLY}"
  fs::createTempDirectory
  local extensionDirectory="${REPLY}/my-extension"
  # override git for the tests
  local testDirectory="${PWD}"
  chmod +x "${testDirectory}/git/git" "${testDirectory}/code/code"

  test::title "✅ Testing extensions init without code in PATH, on windows and outside the ext directory"
  export PATH="/usr/bin:${testDirectory}/git"
  OSTYPE="msys"
  resetExtensionDirectory
  bash::pushd "${extensionDirectory}"
  test::setTerminalInputs y
  test::exec extensionsInit

  test::listPaths "${extensionDirectory}" recursive=true includeHidden=true
  assert::isLink "${VALET_CONFIG_EXTENSIONS_DIRECTORY}/my-extension"

  test::title "✅ Testing extensions init with code in PATH, on linux, outside the ext directory but registered"
  export PATH="${testDirectory}/code:/usr/bin:${testDirectory}/git"
  OSTYPE="linux-gnu"
  resetExtensionDirectory
  test::exec extensionsInit

  test::listPaths "${extensionDirectory}" recursive=true includeHidden=true
  test::cat "${extensionDirectory}/.gitignore"

  test::title "✅ Testing extensions init with existing extension and not overwriting"
  export PATH="/usr/bin:${testDirectory}/git"
  OSTYPE="linux-gnu"
  resetExtensionsDirectory
  resetExtensionDirectory
  : >"${VALET_CONFIG_EXTENSIONS_DIRECTORY}/my-extension"
  test::setTerminalInputs y n
  test::exit extensionsInit

  test::listPaths "${extensionDirectory}" recursive=true includeHidden=true
  assert::isFile "${VALET_CONFIG_EXTENSIONS_DIRECTORY}/my-extension"

  test::title "✅ Testing extensions init with existing extension and overwriting"
  test::setTerminalInputs y y
  test::exec extensionsInit
  assert::isLink "${VALET_CONFIG_EXTENSIONS_DIRECTORY}/my-extension"

  test::title "✅ Testing extensions init without registration"
  resetExtensionsDirectory
  resetExtensionDirectory
  test::setTerminalInputs n
  test::exec extensionsInit

  test::title "✅ Testing extensions init inside the extensions directory"
  resetExtensionsDirectory
  resetExtensionDirectory
  mkdir -p "${VALET_CONFIG_EXTENSIONS_DIRECTORY}/my-extension"
  bash::pushd "${VALET_CONFIG_EXTENSIONS_DIRECTORY}/my-extension"
  test::exec extensionsInit

  test::listPaths "${PWD}" recursive=true includeHidden=true
}

function resetExtensionDirectory() {
  command rm -rf "${extensionDirectory}"
  command mkdir -p "${extensionDirectory}"
}

function resetExtensionsDirectory() {
  command rm -rf "${VALET_CONFIG_EXTENSIONS_DIRECTORY}"
  command mkdir -p "${VALET_CONFIG_EXTENSIONS_DIRECTORY}"
}

function selfDocument() {
  log::info "Called selfDocument."
  : >"${VALET_CONFIG_EXTENSIONS_DIRECTORY}/lib-valet"
  : >"${VALET_CONFIG_EXTENSIONS_DIRECTORY}/lib-valet.md"
  : >"${VALET_CONFIG_EXTENSIONS_DIRECTORY}/valet.code-snippets"
}

function windows::startPs1Batch() {
  log::info "Starting a batch of ps1 commands to be executed at the end of the script."
}

function windows::endPs1Batch() {
  log::info "Ending the batch of ps1 commands and executing them."
}

function windows::createLink() {
  ln -s "${1}" "${2}"
}

main
