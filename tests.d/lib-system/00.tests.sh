#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-system
source system
# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_system::isDarwin
  test_system::isLinux
  test_system::isWindows
  test_system::getArchitecture
  test_system::getOs
  test_system::getEnvVars
  test_system::addToPath
}

function test_system::isDarwin() {
  test::title "✅ Testing system::isDarwin"

  test::func OSTYPE=darwin system::isDarwin
  test::func OSTYPE=darwin-bsd system::isDarwin
  test::func OSTYPE=msys system::isDarwin
  test::func OSTYPE=cygwin system::isDarwin
}

function test_system::isLinux() {
  test::title "✅ Testing system::isLinux"

  test::func OSTYPE=linux system::isLinux
  test::func OSTYPE=linux-bsd system::isLinux
  test::func OSTYPE=msys system::isLinux
  test::func OSTYPE=cygwin system::isLinux
}

function test_system::isWindows() {
  test::title "✅ Testing system::isWindows"

  test::func OSTYPE=msys system::isWindows
  test::func OSTYPE=cygwin system::isWindows
  test::func OSTYPE=windows system::isWindows
  test::func OSTYPE=linux system::isWindows
}

function test_system::getArchitecture() {
  test::title "✅ Testing system::getArchitecture"

  test::func MACHTYPE=x86_64-pc-msys system::getArchitecture
}

function test_system::getOs() {
  test::title "✅ Testing system::getOs"

  test::func OSTYPE=linux-bsd system::getOs
  test::func OSTYPE=msys system::getOs
  test::func OSTYPE=darwin-stuff system::getOs
  test::func OSTYPE=nop system::getOs
}

function test_system::getEnvVars() {
  test::title "✅ Testing system::getEnvVars"

  REPLY_ARRAY=()
  test::exec system::getEnvVars
  if ((${#REPLY_ARRAY[*]} > 0)); then
    test::markdown "Found environment variables in REPLY_ARRAY."
  fi
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
