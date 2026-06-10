#!/usr/bin/env bash

function main() {
  test_bash::catchErrors
  test_bash::runInSubshell
  test_bash::isFdValid
  test_bash::getFunctionDefinitionWithGlobalVars
  test_bash::injectCodeInFunction
  test_bash::sleep
  test_bash::readStdIn
  test_bash::countArgs
  test_bash::isMissingCommands
  test_bash::isCommand
  test_bash::isFunction
  test_bash::getBuiltinOutput
  test_bash::pushd
  test_bash::xxxShellOption
}

function test_bash::xxxShellOption() {
  test::title "✅ Testing bash::setShellOption and bash::restoreShellOption"

  function testOptionUnset() {
    if shopt -q nocasematch; then
      test::fail "nocasematch should be unset"
    else
      test::markdown "nocasematch is unset"
    fi
  }
  function testOptionSet() {
    if shopt -q nocasematch; then
      test::markdown "nocasematch is set"
    else
      test::fail "nocasematch should be set"
    fi
  }

  test::exec shopt -s nocasematch
  test::exec bash::unsetShellOption nocasematch
  testOptionUnset

  test::exec bash::restoreShellOption nocasematch
  testOptionSet

  test::exec shopt -u nocasematch
  test::exec bash::setShellOption nocasematch
  testOptionSet

  test::exec bash::restoreShellOption nocasematch
  testOptionUnset

  test::exec bash::restoreShellOption nocasematch
  testOptionUnset

  test::exec bash::unsetShellOption nocasematch
  testOptionUnset

  test::exec bash::restoreShellOption nocasematch
  testOptionUnset
}

function test_bash::pushd() {
  test::title "✅ Testing bash::pushd and bash::popd"

  dirs -c

  test::exec bash::pushd /tmp
  test::markdown "Current directory after pushd: ${PWD}"
  test::exec bash::popd
  test::markdown "Current directory after pushd: ${PWD}"

  test::exit bash::popd
  test::exit bash::pushd non-existing-directory

  pushd -n still-not-existing &>/dev/null
  test::exit bash::popd
}

function test_bash::catchErrors() {
  test::title "✅ Testing bash::catchErrors"

  function testFunction() {
    log::info "This is a test function."
    ((0 / 0)) # This will fail and trigger the error trap
    log::info "This line will be executed since we catch errors."
    ((0 / 0)) # This will fail and trigger the error trap
    log::info "Again."
  }

  # shellcheck disable=SC2317
  test::func bash::catchErrors echo "This should not fail"

  test::setTestCallStack
  test::exec bash::catchErrors testFunction
  test::printVars GLOBAL_ERROR_TRAP_LAST_ERROR_CODE GLOBAL_ERROR_TRAP_ERROR_CODES GLOBAL_ERROR_TRAP_ERROR_STACKS
  test::unsetTestCallStack
}

# shellcheck disable=SC2317
# shellcheck disable=SC2034
function test_bash::runInSubshell() {
  test::title "✅ Testing bash::runInSubshell"

  test::func bash::runInSubshell log::info "hello"

  function subshellThatFails() {
    ((0 / 0)) # This will fail and exit the subshell
    log::info "This line will not be executed because the previous command failed."
  }

  test::setTestCallStack
  test::func bash::runInSubshell subshellThatFails
  test::func bash::runInSubshell subshellThatFails
  test::exit _OPTION_EXIT_ON_FAIL=true bash::runInSubshell subshellThatFails
  test::unsetTestCallStack

  function subshellThatExits() {
    core::exit 2 silent=true
  }

  test::func bash::runInSubshell subshellThatExits
}

function test_bash::isFdValid() {
  test::title "✅ Testing bash::isFdValid"

  test::exec bash::isFdValid 2
  test::exec bash::isFdValid "${GLOBAL_TEST_TEMP_FILE}"
  test::exec bash::isFdValid 999
  test::exec bash::isFdValid /unknown/file/path
}

function test_bash::injectCodeInFunction() {
  test::title "✅ Testing bash::injectCodeInFunction"

  function simpleFunction() { :; }
  test::exec declare -f simpleFunction
  test::exec bash::injectCodeInFunction simpleFunction "echo 'injected at the beginning!'" injectAtBeginning=true
  test::prompt "echo \${REPLY}; echo \${REPLY2};"
  echo "${REPLY}"
  echo "${REPLY2}"
  test::flush

  test::exec bash::injectCodeInFunction simpleFunction "echo 'injected at the end!'"
  test::prompt "echo \${REPLY}; echo \${REPLY2};"
  echo "${REPLY}"
  echo "${REPLY2}"
  test::flush

  test::exec bash::injectCodeInFunction newName "echo 'injected in a new function!'"
  test::prompt "echo \${REPLY}; echo \${REPLY2};"
  echo "${REPLY}"
  echo "${REPLY2}"
  test::flush
}

function test_function_to_reexport() {
  local -i firstArg=$1
  local secondArg="${2}"
  local -A thirdArg="${3:-egez}"
  local -a fourth="${4?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"

  if ((firstArg == 0)); then
    echo "cool"
  fi
  if [[ "${secondArg}" == "cool" ]]; then
    echo "${secondArg}"
  fi
  if [[ "${thirdArg[cool]}" == "cool" ]]; then
    echo "${thirdArg[cool]}"
  fi
  if [[ "${fourth[cool]}" == "cool" ]]; then
    echo "${fourth[cool]}"
  fi
}

function test_bash::getFunctionDefinitionWithGlobalVars() {
  test::title "✅ Testing bash::getFunctionDefinitionWithGlobalVars"

  test::exec declare -f test_function_to_reexport
  test::exec bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name FIRST_ARG SECOND_ARG THIRD_ARG FOURTH_ARG
  test::prompt "echo \${REPLY}"
  echo "${REPLY}"
  test::flush

  test::markdown "Testing without arguments"
  test::exec bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name
  test::prompt "echo \${REPLY}"
  echo "${REPLY}"
  test::flush
}

function test_bash::sleep() {
  test::title "✅ Testing bash::sleep"

  test::exec bash::sleep 0.001
}

function test_bash::readStdIn() {
  test::title "✅ Testing bash::readStdIn"

  test::prompt "bash::readStdIn <<<'coucou'"
  test::resetReplyVars
  bash::readStdIn <<<"coucou"
  test::printReplyVars

  test::func bash::readStdIn
}

function test_bash::countArgs() {
  test::title "✅ Testing bash::countArgs"

  test::func bash::countArgs 'arg1' 'arg2' 'arg3'
  # shellcheck disable=SC2016
  test::func bash::countArgs '"${PWD}/resources/*"'
}

function test_bash::isMissingCommands() {
  test::title "✅ Testing bash::isMissingCommands"

  test::func bash::isMissingCommands

  test::func bash::isMissingCommands NONEXISTINGSTUFF bash::isMissingCommands rm YETANOTHERONEMISSING
}

function test_bash::isCommand() {
  test::title "✅ Testing bash::isCommand"

  test::exec bash::isCommand NONEXISTINGSTUFF
  test::exec bash::isCommand rm
}

function test_bash::isFunction() {
  test::title "✅ Testing bash::isFunction"

  unset -v func1
  test::exec bash::isFunction func1
  function func1() { :; }
  test::exec bash::isFunction func1
}

function test_bash::getBuiltinOutput() {
  test::title "✅ Testing bash::getBuiltinOutput"

  test::func bash::getBuiltinOutput echo coucou
  test::func bash::getBuiltinOutput declare -f bash::getBuiltinOutput
  test::func bash::getBuiltinOutput false

  function testOutput() {
    echo "This is stdout"
    echo "This is stderr" >&2
    return 42
  }

  test::func bash::getBuiltinOutput testOutput
}

main
