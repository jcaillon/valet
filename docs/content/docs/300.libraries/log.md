---
title: 📂 log
cascade:
  type: docs
url: /docs/libraries/log
---

## log::debug

Displays a debug message.

- $@: **message** _as string_:
      the debug messages to display

```bash
log::debug "This is a debug message."
```

## log::error

Displays an error message.

- $@: **message** _as string_:
      the error messages to display

```bash
log::error "This is an error message."
```

> You probably want to exit immediately after an error and should consider using core::fail function instead.

## log::errorTrace

Displays an error trace message.
This is a trace message that is always displayed, independently of the log level.
It can be used before a fatal error to display useful information.

- $@: **message** _as string_:
      the trace messages to display

```bash
log::errorTrace "This is a debug message."
```

## log::getLevel

Get the current log level.

Returns:

- ${RETURNED_VALUE}: The current log level.

```bash
log::getLevel
printf '%s\n' "The log level is ⌜${RETURNED_VALUE}⌝."
```

## log::info

Displays an info message.

- $@: **message** _as string_:
      the info messages to display

```bash
log::info "This is an info message."
```

## log::isDebugEnabled

Check if the debug mode is enabled.

Returns:

- $?:
  - 0 if debug mode is enabled (log level is debug)
  - 1 if disabled

```bash
if log::isDebugEnabled; then printf '%s\n' "Debug mode is active."; fi
```

## log::isTraceEnabled

Check if the trace mode is enabled.

Returns:

- $?:
  - 0 if trace mode is enabled (log level is trace)
  - 1 if disabled

```bash
if log::isTraceEnabled; then printf '%s\n' "Debug mode is active."; fi
```

## log::print

Display a log message.

- $1: **color name** _as string_:
      The color name to use for the severity (TRACE, DEBUG...).
- $2: **icon** _as string_:
      The icon to display in the log message (utf8 character from nerd icons).
- $3: **severity** _as string_:
      The severity to display (max 7 chars for the default log pattern).
- $@: **message** _as string_:
      The message to log.

```bash
log::print "SUCCESS" $'\uf14a' "OK" "This is a success message."
```

## log::printCallStack

This function prints the current function stack in the logs.

- $1: Stack to skip _as int_:
      (optional) Can be set using the variable `_OPTION_STACK_TO_SKIP`.
      The number of stack to skip.
      (defaults to 2 which skips this function and the first calling function
      which is usually the onError function)
- $2: Stack to skip at end _as int_:
      (optional) Can be set using the variable `_OPTION_STACK_TO_SKIP_AT_END`.
      The number of stack to skip at the end.
      (defaults to 0)

```bash
log::printCallStack
log::printCallStack 0
```

> For test purposes, you can set the `GLOBAL_STACK_FUNCTION_NAMES`, `GLOBAL_STACK_SOURCE_FILES` and `GLOBAL_STACK_LINE_NUMBERS`
> variables to simulate a call stack.

## log::printFile

Display a file content with line numbers in the logs.
The file content will be aligned with the current log output and hard wrapped if necessary.

- $1: **path** _as string_:
      the file path to display.
- $2: max lines _as int_:
      (optional) Can be set using the variable `_OPTION_MAX_LINES`.
      Max lines to display, can be set to 0 to display all lines.
      (defaults to 0)

```bash
log::printFile "/my/file/path"
```

## log::printFileString

Display a file content with line numbers in the logs.
The file content will be aligned with the current log output and hard wrapped if necessary.

- $1: **content variable name** _as string_:
      The name of the variable containing the file content to print.
- $2: max lines _as int_:
      (optional) Can be set using the variable `_OPTION_MAX_LINES`.
      Max lines to display, can be set to 0 to display all lines.
      (defaults to 0)

```bash
log::printFileString "myvar"
```

> This function is not at all suited for large strings, print the content to a file instead.

## log::printRaw

Display something in the log stream.
Does not check the log level.

- $1: **content variable name** _as string_:
      The variable name containing the content to print (can contain new lines).

```bash
log::printRaw "my line"
```

## log::printString

Display a string in the log.
The string will be aligned with the current log output and hard wrapped if necessary.
Does not check the log level.

- $1: **content** _as string_:
      the content to log (can contain new lines)
- $2: new line pad string _as string_:
      (optional) the string with which to prepend each wrapped line
      (empty by default)

```bash
log::printString "my line"
```

## log::saveFile

Save the given file by copying it to a new file in the user local state directory
(using `core::createNewStateFilePath`).
Useful for debugging purposes, to save the state of a file during execution.

- $1: **path** _as string_:
      The file path to save.
- $2: **suffix** _as string_:
      The suffix to add to the file name.
- $3: log path _as bool_:
      (optional) if true, log the path of the saved file using `log::printString`
      (defaults to true)

Returns:

- ${RETURNED_VALUE}: The path to the saved file.

```bash
log::saveFile "/my/file/path" "suffix" "important result file"
```

## log::saveFileString

Save the given string to a new file in the user local state directory
(using `core::createNewStateFilePath`).
Useful for debugging purposes, to save the state of a string during execution.

- $1: **content variable name** _as string_:
      The variable name of the content to save.
- $2: **suffix** _as string_:
      The suffix to add to the file name.
- $3: log path _as bool_:
      (optional) if true, log the path of the saved file using `log::printString`
      (defaults to true)

Returns:

- ${RETURNED_VALUE}: The path to the saved file.

```bash
log::saveFileString "my content" "suffix" "important result file"
```

## log::setLevel

Set the log level.

- $1: **log level** _as string_:
      The log level to set (or defaults to info), acceptable values are:
  - trace
  - debug
  - info
  - success
  - warning
  - error
- $2: silent _as bool_:
      (optional) true to silently switch log level, i.e. does not print a message
      (defaults to false)

```bash
log::setLevel debug
log::setLevel debug true
```

## log::success

Displays a success message.

- $@: **message** _as string_:
      the success messages to display

```bash
log::success "This is a success message."
```

## log::trace

Displays a trace message.

- $@: **message** _as string_:
      the trace messages to display

```bash
log::trace "This is a trace message."
```

## log::warning

Displays a warning.

- $@: **message** _as string_:
      the warning messages to display

```bash
log::warning "This is a warning message."
```

> Documentation generated for the version 0.28.3846 (2025-03-18).
