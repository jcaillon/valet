#!/usr/bin/env bash

function main() {
  test_bash::runInSubshell
  test_bash::isFdValid
  test_bash::getFunctionDefinitionWithGlobalVars
  test_bash::countJobs
  test_bash::injectCodeInFunction
  test_bash::sleep
  test_bash::readStdIn
  test_bash::countArgs
  test_bash::getMissingVariables
  test_bash::getMissingCommands
  test_bash::isCommand
  test_bash::isFunction
  test_bash::getBuiltinOutput
}

function test_bash::runInSubshell() {
  test::title "✅ Testing bash::runInSubshell"

  function onSubshellExit() {
    log::warning "Subshell exited with code $1"
  }

  test::exec bash::runInSubshell log::info "hello"

  # shellcheck disable=SC2034
  # shellcheck disable=SC2317
  function subshellThatFails() {
    # fix stuff for printCallStack
    GLOBAL_STACK_FUNCTION_NAMES=(log::getCallStack log::printCallStack log::error myCmd::subFunction myCmd::function)
    GLOBAL_STACK_SOURCE_FILES=("core" "core" "core" "/path/to/subFunction.sh" "/path/to/function.sh")
    GLOBAL_STACK_LINE_NUMBERS=(10 100 200 300)
    
    ((0/0)) # This will fail and exit the subshell
    log::info "This line will not be executed because the previous command failed."
  }

  test::exec bash::runInSubshell subshellThatFails
  test::exit _OPTION_EXIT_ON_FAIL=true bash::runInSubshell subshellThatFails

  unset -f onSubshellExit subshellThatFails
}

function test_bash::isFdValid() {
  test::title "✅ Testing bash::isFdValid"

  test::exec bash::isFdValid 2
  test::exec bash::isFdValid "${GLOBAL_TEST_TEMP_FILE}"
  local fd
  exec {fd}>&2
  test::exec bash::isFdValid "${fd}"
  exec {fd}>&-

  test::exec bash::isFdValid 999
  test::exec bash::isFdValid /unknown/file/path
}

function test_bash::injectCodeInFunction() {
  test::title "✅ Testing bash::injectCodeInFunction"

  function simpleFunction() { :;}
  test::exec declare -f simpleFunction
  test::exec bash::injectCodeInFunction simpleFunction "echo 'injected at the beginning!'" true
  test::prompt "echo \${RETURNED_VALUE}; echo \${RETURNED_VALUE2};"
  echo "${RETURNED_VALUE}"
  echo "${RETURNED_VALUE2}"
  test::flush

  test::exec bash::injectCodeInFunction simpleFunction "echo 'injected at the end!'"
  test::prompt "echo \${RETURNED_VALUE}; echo \${RETURNED_VALUE2};"
  echo "${RETURNED_VALUE}"
  echo "${RETURNED_VALUE2}"
  test::flush

  test::exec bash::injectCodeInFunction newName "echo 'injected in a new function!'"
  test::prompt "echo \${RETURNED_VALUE}; echo \${RETURNED_VALUE2};"
  echo "${RETURNED_VALUE}"
  echo "${RETURNED_VALUE2}"
  test::flush
}

function test_bash::countJobs() {
  test::title "✅ Testing bash::countJobs"

  # overriding the builtin jobs command
  # shellcheck disable=SC2317
  function jobs() {
    echo "[1]   Running                 stuff &
[2]-  Running                 stuff &
[3]+  Running                 stuff &
"
  }
  test::prompt "stuff &; stuff &; stuff &"
  test::func bash::countJobs
  unset -f jobs
}

function test_function_to_reexport() {
  local -i firstArg=$1
  local secondArg="${2}"
  local -A thirdArg="${3:-egez}"
  local -a fourth="${4?"The function ⌜${FUNCNAME:-?}⌝ requires more than $# arguments."}"

  if (( firstArg == 0 )); then
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
  test::prompt "echo \${RETURNED_VALUE}"
  echo "${RETURNED_VALUE}"
  test::flush


  test::markdown "Testing without arguments"
  test::exec bash::getFunctionDefinitionWithGlobalVars test_function_to_reexport new_name
  test::prompt "echo \${RETURNED_VALUE}"
  echo "${RETURNED_VALUE}"
  test::flush
}

function test_bash::sleep() {
  test::title "✅ Testing bash::sleep"

  test::exec bash::sleep 0.001
}

function test_bash::readStdIn() {
  test::title "✅ Testing bash::readStdIn"

  test::prompt "bash::readStdIn <<<'coucou'"
  test::resetReturnedVars
  bash::readStdIn <<<"coucou"
  test::printReturnedVars

  test::func bash::readStdIn
}

function test_bash::countArgs() {
  test::title "✅ Testing bash::countArgs"

  test::func bash::countArgs 'arg1' 'arg2' 'arg3'
  test::func bash::countArgs "\${PWD}/resources/*"
}

function test_bash::getMissingVariables() {
  test::title "✅ Testing bash::getMissingVariables"

  test::func bash::getMissingVariables
  test::exec ABC="ok"
  test::func bash::getMissingVariables GLOBAL_TEST_TEMP_FILE dfg ABC NOP
}

function test_bash::getMissingCommands() {
  test::title "✅ Testing bash::getMissingCommands"

  test::func bash::getMissingCommands

  test::func bash::getMissingCommands NONEXISTINGSTUFF bash::getMissingCommands rm YETANOTHERONEMISSING
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
  function func1() { :;}
  test::exec bash::isFunction func1
}

function test_bash::getBuiltinOutput() {
  test::title "✅ Testing bash::getBuiltinOutput"

  test::func bash::getBuiltinOutput echo coucou
  test::func bash::getBuiltinOutput declare -f bash::getBuiltinOutput
  test::func bash::getBuiltinOutput false || echo "Failed as expected"
}

main