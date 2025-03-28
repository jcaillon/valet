#!/usr/bin/env bash

command::sourceFunction "selfExport"

function main() {
  test::title "✅ Testing self export command"

  test::exec selfExport
  test::exec selfExport -a
  test::exec selfExport -p
  test::exec selfExport -E

  test::prompt "eval \"\$(valet self export)\""
  bash -c 'eval "$("'"${GLOBAL_INSTALLATION_DIRECTORY}"'/valet" self export)"; exit 0'

  test::prompt "eval \"\$(valet self export -a)\""
  bash -c 'eval "$("'"${GLOBAL_INSTALLATION_DIRECTORY}"'/valet" self export -a)"; exit 0'

  test::prompt "eval \"\$(valet self export -p)\""
  bash -c 'eval "$("'"${GLOBAL_INSTALLATION_DIRECTORY}"'/valet" self export -p)"; exit 0'
}

main