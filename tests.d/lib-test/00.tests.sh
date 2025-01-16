#!/usr/bin/env bash

# shellcheck disable=SC2016
# shellcheck disable=SC2034
function main() {

  test::title "#️⃣ Testing the basic functions of lib-test"
  test::log "This push logs for debugging purposes. They will only appear if the test fails."
  test::comment "You can insert comments that will appear as a paragraph in the test report." \
    "Everything written to the standard or error output (file descriptor 1 and 2 respectively) is captured and can then be flushed to the test report (usually as a code block)." \
    'You can use the `test::flush` function to flush both captured outputs.'

  echo "This was written to the standard output using: echo '...'"
  echo "This was written to the error output using: echo '...' 1>&2" 1>&2
  test::flush


  test::title "🚽 Testing the more flushing functions"
  test::comment 'You can flush a specific file descriptor using the `test::flushStdout` or `test::flushStderr` function.'
  echo "This was written to the standard output using: echo '...'"
  echo "Then flushed with test::flushStdout"
  test::flushStdout
  echo "This was written to the error output using: echo '...' 1>&2" 1>&2
  echo "Then flushed with test::flushStderr" 1>&2
  test::flushStderr "Optional title for the code block:"


  # 🧫 Testing using test::endTest
  functionToTest "I am testing functionToTest." "This is supposed to be in the error output" 0
  functionToTest "Second test." "Second test." 2 || echo "Failed as expected because functionToTest returned $?."
  (functionThatExit "Third test." "Third test." 3) || echo "Failed as expected because functionToTest returned ${PIPESTATUS[0]}."
  test::endTest "🧫 Testing using test::endTest" 42 'One way to test your commands is to simply call them, let them write their output to the standard or error (logs) file descriptors as they normally do.' \
  'An important thing to keep in mind is that shell options are set to exit on error, and exiting during a test is considered a failure.' \
  'You can use the `commandThatFails || echo "Failed as expected."` pattern to handle expected failures (unexpected failure are supposed to crash your tests anyway).' \
  'For commands that directly call `exit`, you must run them in a subshell to avoid the test script to exit as well: `(myCommandThatExit) || || echo "Failed as expected."`.'



  test::title "🧪 Testing any command with test::exec"
  test::comment 'Another approach is to use `test::exec` to run any command.' \
  'The command will be executed and its output will be captured then automatically flushed to the test report.' \
  'This convenient function also logs the command that was executed, handles errors and output the exit code if it is not zero.' \
  '> However, it is not adapted to handle commands that `exit`, see the next test on `test::exit` for that.'
  test::exec functionToTest "I am testing functionToTest." "This is supposed to be in the error output" 0
  test::comment 'In this second test, we expect the command to fail and return the exit code 2.'
  test::exec functionToTest "Second test." "Second test." 2


  test::title "👋 Testing an exiting command with test::exit"
  test::comment 'The `test::exit` function is a variant of `test::exec` that is adapted to handle commands that `exit`.' \
  'It will run the command in a subshell and output the same format as `test::exec`.'
  test::exit functionThatExit "I am testing functionThatExit." "This is supposed to be in the error output" 3


  test::title "🔬 Testing a function with test::func"
  test::comment 'The `test::func` function is a variant of `test::exec` that is adapted to handle functions developed using the coding style of Valet.' \
  'Meaning functions that usually return values in a variables named `RETURNED_VALUE...` (or `RETURNED_ARRAY...`) and that can optionally print results to the standard output and push logs to the error output.' \
  'It function will be executed and its output will be added the report, including any declare `RETURNED_*` variable.'


  test::title "🙈 Display reporting RETURNED variables"
  test::comment 'You can manually report the content of the `RETURNED_*` variables using the `test::revealReturnedVars` function.' \
  'The function `test::resetReturnedVars` can also be used to reset the content of the `RETURNED_*` variables.'
  RETURNED_VALUE="This will be overridden".
  test::resetReturnedVars
  test::revealReturnedVars


  test::title "👁️ Display the value of any variable"
  test::comment 'You can manually report the definition of any variable using the `test::revealVars` function.'
  GLOBAL_VAR1="This is the value of a global string"
  GLOBAL_VAR2=("This" "is" "the" "value" "of" "a" "global" "array.")
  echo "> test::revealVars GLOBAL_VAR1 GLOBAL_VAR2"
  test::flushStdout "Command executed in the test script:"
  test::revealVars GLOBAL_VAR1 GLOBAL_VAR2
}

function functionToTest() {
  echo "${1}"
  echo "${2}" 1>&2
  return "${3}"
}

function functionThatExit() {
  echo "${1}"
  echo "${2}" 1>&2
  exit "${3}"
}

# shellcheck disable=SC2034
function typicalValetFunction() {
  echo "OUTPUT: ${1}"
  echo "LOG: ${2}" 1>&2
  RETURNED_VALUE="This is the returned value."
  RETURNED_ARRAY=("This" "is" "the" "returned" "array.")
  RETURNED_ASSOCIATIVE_ARRAY=([key1]="This" [key2]="is" [key3]="the" [key4]="returned" [key5]="associative" [key6]="array.")
}

main
