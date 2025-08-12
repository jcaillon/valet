#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-command
source command

function main() {
  test_command::getHelpAsMarkdown
}

function test_command::getHelpAsMarkdown() {
  test::title "✅ Testing command::getHelpAsMarkdown"

  test::func command::getHelpAsMarkdown "showcaseCommand1"
}

main
