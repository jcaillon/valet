#!/usr/bin/env bash

command::sourceFunction "selfSource"

function main() {
  test::title "✅ Testing self source command"

  test::exec selfSource
  test::exec selfSource -a
  test::exec selfSource -p
  test::exec selfSource -E

  test::prompt "eval \"\$(valet self source)\""
  bash -c 'eval "$("'"${GLOBAL_INSTALLATION_DIRECTORY}"'/valet" self source)"; exit 0'

  test::prompt "eval \"\$(valet self source -a)\""
  bash -c 'eval "$("'"${GLOBAL_INSTALLATION_DIRECTORY}"'/valet" self source -a)"; exit 0'

  test::prompt "eval \"\$(valet self source -p)\""
  bash -c 'eval "$("'"${GLOBAL_INSTALLATION_DIRECTORY}"'/valet" self source -p)"; exit 0'
}

main