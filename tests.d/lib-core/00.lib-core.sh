#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_core::dump
  test_core::getSpecialPaths
  test_core::fail
  test_core::exit
  test_core::parseShellParameters
  test_source
}

function test_core::dump() {
  test::title "✅ Test core::dump"

  test::resetReplyVars
  test::exec core::dump
  test::printReplyVars
  local dumpFilePath="${REPLY}"
  test::exec fs::head "${dumpFilePath}" 2
}

function test_core::getSpecialPaths() {
  HOME="${PWD}/resources/home"

  test::markdown "HOME is set to '${HOME}'"

  test::title "✅ Test core::get*Directory"

  unset -v ${!VALET_CONFIG_*} XDG_CONFIG_HOME XDG_DATA_HOME XDG_CACHE_HOME XDG_STATE_HOME XDG_RUNTIME_DIR

  test::func core::getConfigurationDirectory
  test::func core::getUserDataDirectory
  test::func core::getUserCacheDirectory
  test::func core::getUserStateDirectory
  test::func core::getExtensionsDirectory

  test::title "✅ Test core::createSavedFilePath"

  test::func core::createSavedFilePath
  test::func core::createSavedFilePath suffix="suffix"

  test::markdown "Content of HOME directory:"
  test::func fs::listDirectories "${HOME}" recursive=true includeHidden=true
}

function test_core::fail() {
  test::title "✅ Test core::fail"

  test::setTestCallStack

  test::exit core::fail "Failure message."
  test::exit core::fail "Failure message." exitCode=255

  test::unsetTestCallStack
}

function test_core::exit() {
  test::title "✅ Test core::exit"

  test::setTestCallStack

  test::exit core::exit
  test::exit core::exit 255
  test::exit core::exit 1 silent=true


  test::title "✅ Test normal exit"
  test::exit exit
  test::exit exit 1

  test::unsetTestCallStack
}

function test_core::parseShellParameters() {
  test::title "✅ Test core::parseShellParameters"

  test::func core::parseShellParameters ---
  test::func core::parseShellParameters "arg1" "arg2" "arg3"
  test::func core::parseShellParameters "arg1" "arg2" "arg3" ---
  test::func core::parseShellParameters "arg1" "arg2" "arg3" --- myOption=one
  test::func core::parseShellParameters "arg1" "arg2" --- myOption=one myOption2="my value"
}

function test_source() {
  test::title "✅ Test source"

  test::exec core::resetIncludedFiles

  # shellcheck disable=SC2034
  CMD_LIBRARY_DIRECTORIES=("${PWD}/resources/ext2" "${PWD}/resources/ext1")
  # shellcheck disable=SC2034
  GLOBAL_INSTALLATION_DIRECTORY="${PWD}/resources"

  test::printVars CMD_LIBRARY_DIRECTORIES _CORE_INCLUDED_LIBRARIES

  test::markdown "Including the stuff library twice, expecting to be sourced once."
  test::exec source stuff
  test::exec source stuff
  test::flush

  test::markdown "Including a user defined library."
  test::exec source stuff2
  test::flush

  test::markdown "Including the custom file next to the calling script, expecting to be sourced once."
  test::exec source resources/script2.sh
  test::exec source resources/script2.sh
  test::flush

  test::markdown "Including a script using relative path twice, expecting to be sourced twice."
  test::exec source resources/script1.sh my arguments 1 2 3
  test::exec source resources/script1.sh my arguments 1 2 3
  test::flush

  test::markdown "Including a script using an absolute path twice, expecting to be sourced twice."
  test::exec source "${PWD}/resources/script1.sh"
  test::exec source "${PWD}/resources/script1.sh"
  test::flush

  test::markdown "Including non existing library."
  test::exit source NOPNOP
  test::exec _OPTION_CONTINUE_IF_NOT_FOUND=true source NOPNOP
  test::flush

  test::printVars _CORE_INCLUDED_LIBRARIES

  test::markdown "Returning a different code if already included."
  test::exec _OPTION_RETURN_CODE_IF_ALREADY_INCLUDED=2 source stuff

}

main
