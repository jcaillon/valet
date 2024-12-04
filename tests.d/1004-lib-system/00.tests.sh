#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-system
source system
# shellcheck source=../../libraries.d/lib-io
source io

function testSystem::os() {

  echo "→ OSTYPE=linux-bsd system::os"
  OSTYPE=linux-bsd system::os && echo "${RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=msys system::os"
  OSTYPE=msys system::os && echo "${RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=darwin-stuff system::os"
  OSTYPE=darwin-stuff system::os && echo "${RETURNED_VALUE}"
  echo

  echo "→ OSTYPE=nop system::os"
  OSTYPE=nop system::os && echo "${RETURNED_VALUE}"
  echo

  test::endTest "Testing system::os" 0
}

function testSystem::env() {

  RETURNED_ARRAY=()
  echo "→ system::env"
  system::env
  if ((${#RETURNED_ARRAY[*]} > 0)); then
    echo "Found environment variables."
  fi

  test::endTest "Testing system::env" 0
}

function testSystem::date() {

  echo "→ system::date"
  system::date && echo "Returned date with length ${#RETURNED_VALUE}."
  echo

  echo "→ system::date %(%H:%M:%S)T"
  system::date '%(%H:%M:%S)T' && echo "Returned date with length ${#RETURNED_VALUE}."

  test::endTest "Testing system::date" 0
}

function testSystem::getUndeclaredVariables() {

  echo "→ system::getUndeclaredVariables"
  if ! system::getUndeclaredVariables; then
    echo "No undeclared variables found.${RETURNED_ARRAY[*]}"
  fi

  echo
  local abc="ok"
  echo "→ system::getUndeclaredVariables GLOBAL_TEST_TEMP_FILE"
  system::getUndeclaredVariables GLOBAL_TEST_TEMP_FILE abc dfg NOP
  if system::getUndeclaredVariables GLOBAL_TEST_TEMP_FILE abc dfg NOP; then
    echo "Found undeclared variables: ⌜${RETURNED_ARRAY[*]}⌝."
  fi

  test::endTest "Testing system::date" 0
}

function testSystem::getNotExistingCommands() {

  echo "→ system::getNotExistingCommands"
  if ! system::getNotExistingCommands; then
    echo "No not existing commands found.${RETURNED_ARRAY[*]}"
  fi

  echo
  echo "→ system::getNotExistingCommands NONEXISTINGSTUFF system::getNotExistingCommands rm YETANOTHERONEMISSING"
  if system::getNotExistingCommands NONEXISTINGSTUFF system::getNotExistingCommands rm YETANOTHERONEMISSING; then
    echo "Found not existing commands: ⌜${RETURNED_ARRAY[*]}⌝."
  fi

  test::endTest "Testing system::getNotExistingCommands" 0
}

function testSystem::commandExists() {

  echo "→ system::commandExists"
  if ! system::commandExists; then
    echo "Command not found."
  fi

  echo
  echo "→ system::commandExists NONEXISTINGSTUFF"
  if ! system::commandExists NONEXISTINGSTUFF; then
    echo "Command not found."
  fi

  echo
  echo "→ system::commandExists rm ls"
  if system::commandExists rm ls; then
    echo "Found command."
  fi

  test::endTest "Testing system::commandExists" 0
}

function test_system::addToPath() {
  local oldHome="${HOME}"

  HOME="resources/gitignored"
  function zsh() { :; }
  function tcsh() { :; }
  function csh() { :; }
  function xonsh() { :; }
  function fish() { :; }
  function ksh() { :; }
  function nu() { :; }

  echo "→ system::addToPath"
  system::addToPath "/coucou"
  echo
  echo "content of files:"
  cat resources/gitignored/.zshrc
  cat resources/gitignored/.tcshrc
  cat resources/gitignored/.cshrc
  cat resources/gitignored/.xonshrc
  cat resources/gitignored/.config/fish/config.fish
  cat resources/gitignored/.kshrc
  cat resources/gitignored/.config/nushell/env.nu

  system::addToPath "/coucou"

  unset -f zsh tcsh csh xonsh fish ksh nu
  HOME="${oldHome}"
  rm -Rf resources/gitignored
  test::endTest "Testing system::addToPath" 0
}

function test_system::windowsSetEnvVar() {
  echo "→ system::windowsSetEnvVar VAR VALUE"
  OSTYPE=msys system::windowsSetEnvVar VAR VALUE
  echo
  echo "→ system::windowsSetEnvVar VAR ''"
  OSTYPE=msys system::windowsSetEnvVar VAR ''
  echo
  test::endTest "Testing system::windowsSetEnvVar" 0
}

function test_system::windowsGetEnvVar() {
  echo "→ system::windowsGetEnvVar VAR"
  OSTYPE=msys system::windowsGetEnvVar VAR
  echo
  test::endTest "Testing system::windowsGetEnvVar" 0
}

function test_system::windowsAddToPath() {
  echo "→ system::windowsAddToPath /coucou"
  OSTYPE=msys system::windowsAddToPath /coucou
  echo
  test::endTest "Testing system::windowsAddToPath" 0
}

function main() {
  testSystem::os
  testSystem::env
  testSystem::date
  testSystem::getUndeclaredVariables
  testSystem::getNotExistingCommands
  testSystem::commandExists
  test_system::addToPath
  test_system::windowsSetEnvVar
  test_system::windowsGetEnvVar
  test_system::windowsAddToPath
}

# backup original function
io::invoke declare -f io::windowsRunInPowershell
_ORIGINAL_FUNCTION="${RETURNED_VALUE//declare -? /}"

# shellcheck disable=SC2317
function io::windowsRunInPowershell() { echo "io::windowsRunInPowershell: $*"; }

main

unset -f io::windowsRunInPowershell
eval "${_ORIGINAL_FUNCTION}"