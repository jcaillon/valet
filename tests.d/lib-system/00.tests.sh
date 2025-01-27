#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-system
source system
# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_system::os
  test_system::env
  test_system::date
  test_system::getUndeclaredVariables
  test_system::getNotExistingCommands
  test_system::commandExists
  test_system::addToPath
}

function test_system::os() {
  test::title "✅ Testing system::os"

  test::func OSTYPE=linux-bsd system::os
  test::func OSTYPE=msys system::os
  test::func OSTYPE=darwin-stuff system::os
  test::func OSTYPE=nop system::os
}

function test_system::env() {
  test::title "✅ Testing system::env"

  RETURNED_ARRAY=()
  test::exec system::env
  if ((${#RETURNED_ARRAY[*]} > 0)); then
    test::markdown "Found environment variables in RETURNED_ARRAY."
  fi
}

function test_system::date() {
  test::title "✅ Testing system::date"

  test::func system::date
  test::func system::date "'%(%H:%M:%S)T'"
}

function test_system::getUndeclaredVariables() {
  test::title "✅ Testing system::getUndeclaredVariables"

  test::func system::getUndeclaredVariables
  test::exec ABC="ok"
  test::func system::getUndeclaredVariables GLOBAL_TEST_TEMP_FILE dfg ABC NOP
}

function test_system::getNotExistingCommands() {
  test::title "✅ Testing system::getNotExistingCommands"

  test::func system::getNotExistingCommands

  test::func system::getNotExistingCommands NONEXISTINGSTUFF system::getNotExistingCommands rm YETANOTHERONEMISSING
}

function test_system::commandExists() {
  test::title "✅ Testing system::commandExists"

  test::exec system::commandExists
  test::exec system::commandExists NONEXISTINGSTUFF
  test::exec system::commandExists rm
}

# shellcheck disable=SC2317
function test_system::addToPath() {
  test::title "✅ Testing system::addToPath"

  HOME="resources/gitignored"
  function zsh() { :; }
  function tcsh() { :; }
  function csh() { :; }
  function xonsh() { :; }
  function fish() { :; }
  function ksh() { :; }
  function nu() { :; }

  test::exec system::addToPath "/coucou"

  test::exec fs::cat resources/gitignored/.zshrc
  test::exec fs::cat resources/gitignored/.tcshrc
  test::exec fs::cat resources/gitignored/.cshrc
  test::exec fs::cat resources/gitignored/.xonshrc
  test::exec fs::cat resources/gitignored/.config/fish/config.fish
  test::exec fs::cat resources/gitignored/.kshrc
  test::exec fs::cat resources/gitignored/.config/nushell/env.nu

  test::exec system::addToPath "/coucou"

  rm -Rf resources/gitignored
}

main
