#!/usr/bin/env bash

# shellcheck disable=SC2016
# shellcheck disable=SC2034
function main() {
  test::title "✅ test::log"
  test::markdown "You can add logs during tests using \`test::log\` for debugging purposes. These log will only appear if the test fails."
  test::exec test::log "Logged!"

  test::title "✅ test::markdown"
  test::markdown "You can insert markdown in the test report using \`test::markdown\`."
  test::exec test::markdown "**Added.**"

  test::title "✅ test::flush"
  test::markdown "Everything written to the standard or error output (file descriptor 1 and 2 respectively) is captured and can then be flushed to the test report (usually as a code block)." \
    'You can use the `test::flush` function to flush both captured outputs.'

  test::prompt 'echo "This was written to the standard output using: echo ..."'
  test::prompt 'echo "This was written to the error output using: echo ... 1>&2" 1>&2'
  test::prompt test::flush
  echo "This was written to the standard output using: echo ..."
  echo "This was written to the error output using: echo ... 1>&2" 1>&2
  test::flush

  test::title "🚽 Testing the more flushing functions"
  test::markdown 'You can flush a specific file descriptor using the `test::flushStdout` or `test::flushStderr` function.'
  echo "This was written to the standard output using: echo '...'"
  echo "Then flushed with test::flushStdout"
  test::flushStdout
  echo "This was written to the error output using: echo '...' 1>&2" 1>&2
  echo "Then flushed with test::flushStderr" 1>&2
  test::flushStderr "**Optional title for the code block:**"


  test::title "🧪 Generic testing method"
  test::markdown 'The generic way to test your commands is to simply call them. They will write their output to the standard or error (logs) file descriptors as they normally do.' \
  'You can then use `test::flush` to print their output to the report.'

  test::markdown '❯ `functionToTest "I am testing functionToTest." "This is supposed to be in the error output" 0`'
  functionToTest "I am testing functionToTest." "This is supposed to be in the error output" 0
  test::flush

  test::markdown 'An important thing to keep in mind is that shell options are set to exit on error, and exiting during a test is considered a failure.' \
  'You can use the `commandThatFails || echo "Failed as expected."` pattern to handle expected failures (unexpected failure are supposed to crash your tests anyway).'
  test::markdown '❯ `functionToTest "Second test." "Second test." 2 || echo "Failed as expected because functionToTest returned $?."`'
  functionToTest "Second test." "Second test." 2 || echo "Failed as expected because functionToTest returned $?."
  test::flush

  test::markdown 'For commands that directly call `exit`, you must run them in a subshell to avoid the test script to exit as well: `(myCommandThatExit) || || echo "Failed as expected."`.'
  test::markdown '❯ `(functionThatExit "Third test." "Third test." 3) || echo "Failed as expected because functionToTest returned ${PIPESTATUS[0]}."`'
  (functionThatExit "Third test." "Third test." 3) || echo "Failed as expected because functionToTest returned ${PIPESTATUS[0]}."
  test::flush


  test::title "🧪 Testing any command with test::exec"
  test::markdown 'Another approach is to use `test::exec` to run any command.' \
  'The command will be executed and its output will be captured then automatically flushed to the test report.' \
  'This convenient function also logs the command that was executed, handles errors and output the exit code if it is not zero.' \
  '> However, it is not adapted to handle commands that `exit`, see the next test on `test::exit` for that.'
  test::exec functionToTest "OK" "Success" 0
  test::markdown 'In this second test, we expect the command to fail and return the exit code 2.'
  test::exec functionToTest "KO" "Failure" 2


  test::title "👋 Testing an exiting command with test::exit"
  test::markdown 'The `test::exit` function is a variant of `test::exec` that is adapted to handle commands that `exit`.' \
  'It will run the command in a subshell and output the same format as `test::exec`.'
  test::exit functionThatExit "KO" "Exiting" 3


  test::title "🔬 Testing a function with test::func"
  test::markdown 'The `test::func` function is a variant of `test::exec` that is adapted to handle functions developed using the coding style of Valet.' \
  'Meaning functions that usually return values in a variables named `RETURNED_VALUE...` (or `RETURNED_ARRAY...`) and that can optionally print results to the standard output and push logs to the error output.' \
  'It function will be executed and its output will be added the report, including any declare `RETURNED_*` variable.'
  RETURNED_VALUE="This will be overridden"
  RETURNED_ARRAY=("This" "will" "be" "overridden")
  test::func functionWithReturnedVariables "VALUE" "Running functionWithReturnedVariables"


  test::title "🙈 Display reporting RETURNED variables"
  test::markdown 'You can manually report the content of the `RETURNED_*` variables using the `test::printReturnedVars` function.' \
  'The function `test::resetReturnedVars` can also be used to reset the content of the `RETURNED_*` variables.'
  test::resetReturnedVars
  RETURNED_VALUE2="This is the value of a returned string for RETURNED_VALUE2"
  RETURNED_ARRAY2=("This" "is" "the" "value" "of" "a" "returned" "array" "for" "RETURNED_ARRAY2")
  test::printReturnedVars


  test::title "👁️ Display the value of any variable"
  test::markdown 'You can manually report the definition of any variable using the `test::printVars` function.'
  MY_VAR1="This is the value of a global string"
  MY_VAR2=("This" "is" "the" "value" "of" "a" "global" "array")
  declare -iAu MY_VAR3=([key1]=1 [key2]=2 [key3]=3)
  test::prompt "test::printVars MY_VAR1 MY_VAR2 MY_VAR3"
  test::printVars MY_VAR1 MY_VAR2 MY_VAR3

  test::title "❤️ Recommendations for tests"
  test::markdown "It is also recommended to implement tests in bash functions and make use of local variables." \
    "While you can test a command by invoking valet (e.g. \`test::exec valet my-command argument1\`), it is recommended to test the command function itself (e.g. \`test::exec myCommandFunction argument1\`):" \
    "- The result is the same (and you are not testing valet, you are testing your command implementation),
- and this avoid bash to create a fork and start another bash process (for \`valet\`), which would slow down your tests."
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
function functionWithReturnedVariables() {
  echo "OUTPUT: ${1}"
  echo "LOG: ${2}" 1>&2
  RETURNED_VALUE="This is the returned value"
  RETURNED_ARRAY=("This" "is" "the" "returned" "array")
  RETURNED_ASSOCIATIVE_ARRAY=([key1]="This" [key2]="is" [key3]="the" [key4]="returned" [key5]="associative" [key6]="array")
}

main
