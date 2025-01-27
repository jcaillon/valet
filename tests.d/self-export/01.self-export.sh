#!/usr/bin/env bash

command::sourceFunction "selfExport"

function main() {
  test::title "✅ Testing self export command"

  test::prompt "eval \"\$(valet self export)\""
  bash -c 'eval "$("'"${GLOBAL_INSTALLATION_DIRECTORY}"'/valet" self export)"'

  test::exec selfExport

  test::prompt "eval \"\$(valet self export -a)\""
  bash -c 'eval "$("'"${GLOBAL_INSTALLATION_DIRECTORY}"'/valet" self export -a)"'

  test::exec selfExport -a
}

main