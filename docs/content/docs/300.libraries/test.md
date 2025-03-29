---
title: 📂 test
cascade:
  type: docs
url: /docs/libraries/test
---

## test::exec

Call this function to execute a command and write the command and its output to the report file.
The command can fail, in which case the returned exit code is written to the report file.
However, the command must not call `exit` (in which case, use test::exit).

- $@: **command** _as string_:
      The command to execute.

```bash
test::exec echo "Hello, world!"
```

## test::exit

Call this function to execute a command that can call `exit` and write the command and its output to the report file.
The command is executed in a subshell to catch the exit.

- $@: **command** _as string_:
      The command to execute.

```bash
test::exit exit 3
```

## test::fail

Call this function to log a message and exit with the status 142, which
indicates to the self test command that the test failed and that we know the
reason (it is a bad implementation of the test itself).

- $@: **message** _as string_:
      The message to log.

```bash
test::fail "This is a failure message with a clear reason."
```

## test::flush

Call this function to flush the standard and error outputs to the report file.
They will be added as code blocks in the report file (one for the standard
output, one for the standard error).

```bash
test::flush
```

## test::flushStderr

Call this function to flush the standard error to the report file.
It will be added as a code block in the report file.

- $1: blockTitle _as string_:
      (optional) Can be set using the variable `_OPTION_BLOCK_TITLE`.
      Add a 'title' to the code block (`**title**:` before the code block).
      (defaults to '' which will not add a title)

```bash
test::flushStderr
```

## test::flushStdout

Call this function to flush the standard output to the report file.
It will be added as a code block in the report file.

- $1: blockTitle _as string_:
      (optional) Can be set using the variable `_OPTION_BLOCK_TITLE`.
      Add a 'title' to the code block (`**title**:` before the code block).
      (defaults to '' which will not add a title)

```bash
test::flushStdout
```

## test::func

Call this function to test a function that returns a value using the valet
conventions (RETURNED_VALUE, RETURNED_VALUE2, RETURNED_ARRAY, etc...).

It will write the command and its output to the report file.
It will also print the returned values.

- $@: **command** _as string_:
      The command to execute (function and its arguments).

```bash
test::func myFunction
```

## test::log

Call this function to log a message during a test.
This log will only show in case of a script error or when the debug
log level is enabled when running the tests.

- $@: **messages** _as string_:
      The messages to log.

```bash
test::log "This is a log message."
```

## test::markdown

Call this function to add some markdown in the report file.

- $@: **markdown** _as string_:
      The markdown to add in the report file.

```bash
test::markdown "> This is a **quote**."
```

## test::printReturnedVars

This function can be called to print the returned values,
e.g. RETURNED_VALUE, RETURNED_VALUE2, RETURNED_ARRAY...
They will each be printed in a code block in the report file.

```bash
test::printReturnedVars
```

## test::printVars

This function can be called to print the global variables in the report file.
They will printed in a code block in the report file.

- $@: **variables** _as string_:
      The variables to print.

```bash
test::printVars myVar
```

## test::prompt

Call this function to print a 'prompt' (markdown that looks like a prompt) in the report file.

- $@: **command** _as string_:
      The command to print as a prompt.

```bash
test::prompt "echo 'Hello, world!'"
```

## test::resetReturnedVars

Resets the value of each RETURNED_ variable.

```bash
test::resetReturnedVars
```

## test::title

Call this function to add an H3 title in the report file.

- $1: title _as string_:
      (optional) Can be set using the variable `_OPTION_TITLE`.
      The title of the test.
     (defaults to "Test")

```bash
test::title "Testing something"
```

## test::transformReturnedVarsBeforePrinting

This function can be defined to modify the returned variables before printing them in the report.

> You can define this function directly in the test script, or in a test hook if
> you need it to be available for multiple tests.
> Note however that this function can be called very often, so it should be optimized.

## test::transformTextBeforeFlushing

This function can be defined to modify the flushed text before adding it to the report.

The text to transform is in the global variable `_TEST_OUTPUT`.

Returns:

- `_TEST_OUTPUT`: The modified text.

> You can define this function directly in the test script, or in a test hook if
> you need it to be available for multiple tests.
> Note however that this function can be called very often, so it should be optimized.

{{< callout type="info" >}}
Documentation generated for the version 0.29.197 (2025-03-29).
{{< /callout >}}
