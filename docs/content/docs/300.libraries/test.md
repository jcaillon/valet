---
title: 📂 test
cascade:
  type: docs
url: /docs/libraries/test
---

## ⚡ test::addOutputScrubber

Add a scrubber function to modify the flushed text (both stdout and stderr) before adding it to the report.

Scrubbers are required when we need to convert non-deterministic text to something stable so that
tests are reproducible.

The referenced function should modify text to transform stored in the global variable  `GLOBAL_TEST_OUTPUT_CONTENT`.
You can also use `GLOBAL_TEST_FD_NUMBER` to know which file descriptor is being flushed (1 for stdout, 2 for stderr).

Inputs:

- `$1`: **function name** _as string_:

  The name of the function to add as a scrubber.

Example usage:

```bash
test::addOutputScrubber myScrubberFunction
```

## ⚡ test::addReplyVarsScrubber

Add a scrubber function to modify the REPLY variables before printing them in the report.

Scrubbers are required when we need to convert non-deterministic text to something stable so that
tests are reproducible.

The referenced function should modify the REPLY variables (e.g. REPLY, REPLY2, REPLY_ARRAY...) directly.

Inputs:

- `$1`: **function name** _as string_:

  The name of the function to add as a scrubber.

Example usage:

```bash
test::addReplyVarsScrubber myScrubberFunction
```

## ⚡ test::cat

Print the content of a file in a consistent way for testing.
It will also print the file path before the content.

Inputs:

- `$1`: **file** _as string_:

  The file to print.

Example usage:

```bash
test::cat "/path/to/file"
```

## ⚡ test::clearOutputScrubbers

Clear the list of scrubbers to modify the flushed text (both stdout and stderr) before adding it to the report.

Example usage:

```bash
test::clearOutputScrubbers
```

## ⚡ test::clearReplyVarsScrubbers

Clear the list of scrubbers to modify the REPLY variables before printing them in the report.

Example usage:

```bash
test::clearReplyVarsScrubbers
```

## ⚡ test::exec

Call this function to execute a command and write the command and its output to the report file.
The command can fail, in which case the returned exit code is written to the report file.
However, the command must not call `exit` (in which case, use test::exit).

Inputs:

- `$@`: **command** _as string_:

  The command to execute.

Example usage:

```bash
test::exec echo "Hello, world!"
```

## ⚡ test::exit

Call this function to execute a command that can call `exit` and write the command and its output to the report file.
The command is executed in a subshell to catch the exit.

Inputs:

- `$@`: **command** _as string_:

  The command to execute.

Example usage:

```bash
test::exit exit 3
```

## ⚡ test::fail

Call this function to log a message and exit with the status 142.
This should be used to purposefully throw a test failure.
For example, it can be used to indicate that a tested function did not produce the
expected output, or that a tested command did not return the expected exit code.

Inputs:

- `$@`: **message** _as string_:

  The message to log.

Example usage:

```bash
test::fail "This is a failure message with a clear reason."
```

## ⚡ test::flush

Call this function to flush the standard and error outputs to the report file.
They will be added as code blocks in the report file (one for the standard
output, one for the standard error).

Example usage:

```bash
test::flush
```

## ⚡ test::flushStderr

Call this function to flush the standard error to the report file.
It will be added as a code block in the report file.

Inputs:

- `${blockTitle}` _as string_:

  (optional) Add a 'title' to the code block (`**title**:` before the code block).

  (defaults to "")

Example usage:

```bash
test::flushStderr
```

## ⚡ test::flushStdout

Call this function to flush the standard output to the report file.
It will be added as a code block in the report file.

Inputs:

- `${blockTitle}` _as string_:

  (optional) Add a 'title' to the code block (`**title**:` before the code block).

  (defaults to "")

Example usage:

```bash
test::flushStdout
```

## ⚡ test::func

Call this function to test a function that returns a value using the valet
conventions (REPLY, REPLY2, REPLY_ARRAY, etc...).

It will write the command and its output to the report file.
It will also print the REPLY values.

Inputs:

- `$@`: **command** _as string_:

  The command to execute (function and its arguments).

Example usage:

```bash
test::func myFunction
```

## ⚡ test::listPaths

Print the content of a directory in a consistent way for testing, by sorting the entries
and printing the type of each entry (file, directory or link).

Inputs:

- `$1`: **directory** _as string_:

  The directory to list.

- `${recursive}` _as bool_:

  (optional) true to list recursively, false otherwise

  (defaults to false)

- `${includeHidden}` _as bool_:

  (optional) true to list hidden paths, false otherwise

  (defaults to false)

Example usage:

```bash
test::listPaths "/path/to/directory" recursive=true includeHidden=true
```

## ⚡ test::log

Call this function to log a message during a test.
This log will only show in case of a script error or when the debug
log level is enabled when running the tests.

Inputs:

- `$@`: **messages** _as string_:

  The messages to log.

Example usage:

```bash
test::log "This is a log message."
```

## ⚡ test::markdown

Call this function to add some markdown in the report file.

Inputs:

- `$@`: **markdown** _as string_:

  The markdown to add in the report file.

Example usage:

```bash
test::markdown "> This is a **quote**."
```

## ⚡ test::printReplyVars

This function can be called to print the REPLY values,
e.g. REPLY, REPLY2, REPLY_ARRAY...
They will each be printed in a code block in the report file.

Example usage:

```bash
test::printReplyVars
```

## ⚡ test::printVars

This function can be called to print the global variables in the report file.
They will printed in a code block in the report file.

Inputs:

- `$@`: **variables** _as string_:

  The variables to print.

Example usage:

```bash
test::printVars myVar
```

## ⚡ test::prompt

Call this function to print a 'prompt' (markdown that looks like a prompt) in the report file.

Inputs:

- `$@`: **command** _as string_:

  The command to print as a prompt.

Example usage:

```bash
test::prompt "echo 'Hello, world!'"
```

## ⚡ test::resetReplyVars

Resets the value of each REPLY variable.

Example usage:

```bash
test::resetReplyVars
```

## ⚡ test::setTerminalInputs

Replaces the functions `terminal::waitForChar` and `terminal::waitForKeyPress` by custom functions
that return keys defined as an input of this function.

Inputs:

- `$@`: **keys** _as string_:

  The keys to return when `terminal::waitForChar` or `terminal::waitForKeyPress` are called.
  Keys are consumed in the order they are provided.

Example usage:

```bash
test::setTerminalInputs "a" "b" "c"
```

## ⚡ test::setupBashForConsistency

This function is used to set up the Bash environment for maximum consistency during testing.
It will override important dynamic bash variables to have more static results.

Example usage:

```bash
test::setupBashForConsistency
```

## ⚡ test::skipTestSuite

Call this function to log a message and exit with the status 143.
This can be used to skip the current test suite without failing the whole test execution,
for example because a required dependency is not fulfilled.

Inputs:

- `$@`: **message** _as string_:

  The message to log.

Example usage:

```bash
test::skipTestSuite "This test is not applicable."
```

## ⚡ test::title

Call this function to add an H3 title in the report file.

Inputs:

- `$1`: title _as string_:

  The title of the test.

Example usage:

```bash
test::title "Testing something"
```

> [!IMPORTANT]
> Documentation generated for the version 0.40.137 (2026-06-03).
