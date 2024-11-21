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

- `RETURNED_VALUE`: The current log level.

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


## log::printCallStack

This function prints the current function stack in the logs.

- $1: **stack to skip** _as int_:
      the number of stack to skip (defaults to 2 which skips this function
      and the first calling function which is usually the onError function)

```bash
log::printCallStack 2
```


## log::printFile

Display a file content with line numbers in the logs.
The file content will be aligned with the current log output and hard wrapped if necessary.

- $1: **path** _as string_:
      the file path to display.
- $2: max lines _as int_:
      (optional) max lines to display (defaults to 0 which prints all lines).

```bash
log::printFile "/my/file/path"
```
shellcheck disable=SC2317


## log::printFileString

Display a file content with line numbers in the logs.
The file content will be aligned with the current log output and hard wrapped if necessary.

- $1: **content** _as string_:
      the file content.
- $2: **max lines** _as int_:
      (optional) max lines to display (defaults to 0 which prints all lines).

```bash
log::printFileString "myfilecontent"
```
shellcheck disable=SC2317


## log::printRaw

Display something in the log stream.
Does not check the log level.

- $1: **content** _as string_:
      the content to print (can contain new lines)

```bash
log::printRaw "my line"
```
shellcheck disable=SC2317


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
shellcheck disable=SC2317


## log::setLevel

Set the log level.

- $1: **log level** _as string_:
      the log level to set (or defaults to info), acceptable values are:
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




> Documentation generated for the version 1.3.1 (2024-11-21).
