#!/usr/bin/env bash

command::sourceFunction extensionsCreate

function main() {
  fs::createTempDirectory pathOnly=true
  export VALET_CONFIG_EXTENSIONS_DIRECTORY="${REPLY}"

  test::title "✅ Testing extensions create"
  OSTYPE="linux-gnu"
  test::exec extensionsCreate test1

  test::listPaths "${VALET_CONFIG_EXTENSIONS_DIRECTORY}/test1" recursive=true includeHidden=true

  test::title "✅ Testing extensions create with existing extension"
  test::exit extensionsCreate test1
}

function command() {
  if [[ ${1} == "-v" ]]; then
    return 0
  fi
  "${@}"
}

function selfDocument() {
  log::info "Called selfDocument."
  : >"${VALET_CONFIG_EXTENSIONS_DIRECTORY}/lib-valet"
  : >"${VALET_CONFIG_EXTENSIONS_DIRECTORY}/lib-valet.md"
  : >"${VALET_CONFIG_EXTENSIONS_DIRECTORY}/valet.code-snippets"
}

main
