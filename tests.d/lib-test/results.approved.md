# Test suite lib-test

## Test script 00.tests

### ✅ Testing the basic functions of lib-test

You can insert comments that will appear as a paragraph in the test report.

Everything written to the standard or error output (file descriptor 1 and 2 respectively) is captured and can then be flushed to the test report (usually as a code block).

You can use the `test::flush` function to flush both captured outputs.

**Standard output**:

```text
This was written to the standard output using: echo '...'
```

**Error output**:

```text
This was written to the error output using: echo '...' 1>&2
```

### 🚽 Testing the more flushing functions

You can flush a specific file descriptor using the `test::flushStdout` or `test::flushStderr` function.

```text
This was written to the standard output using: echo '...'
Then flushed with test::flushStdout
```

**Optional title for the code block:**:

```text
This was written to the error output using: echo '...' 1>&2
Then flushed with test::flushStderr
```

### 🧫 Testing using test::endTest

One way to test your commands is to simply call them, let them write their output to the standard or error (logs) file descriptors as they normally do.

An important thing to keep in mind is that shell options are set to exit on error, and exiting during a test is considered a failure.

You can use the `commandThatFails || echo "Failed as expected."` pattern to handle expected failures (unexpected failure are supposed to crash your tests anyway).

For commands that directly call `exit`, you must run them in a subshell to avoid the test script to exit as well: `(myCommandThatExit) || || echo "Failed as expected."`.

Exit code: `42`

**Standard output**:

```text
❯ functionToTest "I am testing functionToTest." "This is supposed to be in the error output" 0
I am testing functionToTest.
Second test.
Failed as expected because functionToTest returned 2.
Third test.
Failed as expected because functionToTest returned 3.
```

**Error output**:

```text
This is supposed to be in the error output
Second test.
Third test.
```

### 🧪 Testing any command with test::exec

Another approach is to use `test::exec` to run any command.

The command will be executed and its output will be captured then automatically flushed to the test report.

This convenient function also logs the command that was executed, handles errors and output the exit code if it is not zero.

> However, it is not adapted to handle commands that `exit`, see the next test on `test::exit` for that.

❯ `functionToTest I\ am\ testing\ functionToTest. This\ is\ supposed\ to\ be\ in\ the\ error\ output 0`

**Standard output**:

```text
I am testing functionToTest.
```

**Error output**:

```text
This is supposed to be in the error output
```

In this second test, we expect the command to fail and return the exit code 2.

❯ `functionToTest Second\ test. Second\ test. 2`

Exited with code: `2`

**Standard output**:

```text
Second test.
```

**Error output**:

```text
Second test.
```

### 👋 Testing an exiting command with test::exit

The `test::exit` function is a variant of `test::exec` that is adapted to handle commands that `exit`.

It will run the command in a subshell and output the same format as `test::exec`.

❯ `functionThatExit I\ am\ testing\ functionThatExit. This\ is\ supposed\ to\ be\ in\ the\ error\ output 3`

Exited with code: `3`

**Standard output**:

```text
I am testing functionThatExit.
```

**Error output**:

```text
This is supposed to be in the error output
```

### 🔬 Testing a function with test::func

The `test::func` function is a variant of `test::exec` that is adapted to handle functions developed using the coding style of Valet.

Meaning functions that usually return values in a variables named `RETURNED_VALUE...` (or `RETURNED_ARRAY...`) and that can optionally print results to the standard output and push logs to the error output.

It function will be executed and its output will be added the report, including any declare `RETURNED_*` variable.

❯ `typicalValetFunction Function\ output A\ log\ line.`

**Standard output**:

```text
OUTPUT: Function output
```

**Error output**:

```text
LOG: A log line.
```

Returned variables:

```text
RETURNED_VALUE='This is the returned value.'
RETURNED_ARRAY=(
[0]='This'
[1]='is'
[2]='the'
[3]='returned'
[4]='array.'
)
```

### 🙈 Display reporting RETURNED variables

You can manually report the content of the `RETURNED_*` variables using the `test::printReturnedVars` function.

The function `test::resetReturnedVars` can also be used to reset the content of the `RETURNED_*` variables.

Returned variables:

```text
RETURNED_VALUE2='This is the value of a returned string for RETURNED_VALUE2'
RETURNED_ARRAY2=(
[0]='This'
[1]='is'
[2]='the'
[3]='value'
[4]='of'
[5]='a'
[6]='returned'
[7]='array'
[8]='for'
[9]='RETURNED_ARRAY2'
)
```

### 👁️ Display the value of any variable

You can manually report the definition of any variable using the `test::printVars` function.

**Command executed in the test script:**:

```text
> test::printVars GLOBAL_VAR1 GLOBAL_VAR2
```

Variables:

```text
GLOBAL_VAR1="This is the value of a global string"
GLOBAL_VAR2=(
[0]='This'
[1]='is'
[2]='the'
[3]='value'
[4]='of'
[5]='a'
[6]='global'
[7]='array.'
)
```

### 🪝 Testing the self test hooks

This shows which hook have been executed. This test is written in the 'after-each-test' script. We can't see the 'after-each-test-suites' and 'after-tests' because they are executed after the test script exits, thus we can't output their results in this report.

Exit code: `0`

**Standard output**:

```text
before-tests
before-each-test-suite
after-each-test

```

