---
title: 📂 log
cascade:
  type: docs
url: /docs/libraries/log
---

## log::warning

Displays a warning.

- $@: the warning messages to display

```bash
log::warning "This is a warning message."
```


## log::isDebugEnabled

Check if the debug mode is active.

Returns:

- $?: 0 if debug mode (log debug level) is active, 1 otherwise.

```bash
if log::isDebugEnabled; then printf '%s\n' "Debug mode is active."; fi
```


## log::setLevel

Set the log level. The log level can be set to one of the following values:

- trace
- debug
- info
- success
- warning
- error

- $1: the log level to set (or defaults to info)
- $2: true to silently switch log level (does not print a message)

```bash
log::setLevel debug
log::setLevel debug true
```


## log::printString

Display a string in the log.
The string will be aligned with the current log output and hard wrapped if necessary.
Does not check the log level.

- $1: the content to log (can contain new lines)
- $2: the string with which to prepend each wrapped line (empty by default)

```bash
log::printString "my line"
```
shellcheck disable=SC2317


## log::trace

Displays a trace message.

- $@: the trace messages to display

```bash
log::trace "This is a trace message."
```


## log::success

Displays a success message.

- $@: the success messages to display

```bash
log::success "This is a success message."
```


## log::printCallStack

This function prints the current function stack in the logs.

- $1: the number of levels to skip (default to 2 which skips this function
      and the first calling function which is usually the onError function)

```bash
log::printCallStack 2
```


## log::isTraceEnabled

Check if the trace mode is active.

Returns:

- $?: 0 if trace mode (log debug level) is active, 1 otherwise.

```bash
if log::isTraceEnabled; then printf '%s\n' "Debug mode is active."; fi
```


## log::printRaw

Display something in the log stream.
Does not check the log level.

- $1: the content to print (can contain new lines)

```bash
log::printRaw "my line"
```
shellcheck disable=SC2317


## log::error

Displays an error message.

- $@: the error messages to display

```bash
log::error "This is an error message."
```

> You probably want to exit immediately after an error and should consider using core::fail function instead.


## log::info

Displays an info message.

- $@: the info messages to display

```bash
log::info "This is an info message."
```


## log::printFileString

Display a file content with line numbers in the logs.
The file content will be aligned with the current log output and hard wrapped if necessary.

- $1: the file content.
- $2: (optional) max lines to display (default to 0 which prints all lines).

```bash
log::printFileString "myfilecontent"
```
shellcheck disable=SC2317


## log::debug

Displays a debug message.

- $@: the debug messages to display

```bash
log::debug "This is a debug message."
```


## log::getLevel

Get the current log level.

Returns:

- `RETURNED_VALUE`: The current log level.

```bash
log::getLevel
printf '%s\n' "The log level is ⌜${RETURNED_VALUE}⌝."
```


## log::printFile

Display a file content with line numbers in the logs.
The file content will be aligned with the current log output and hard wrapped if necessary.

- $1: the file path to display.
- $2: (optional) max lines to display (default to 0 which prints all lines).

```bash
log::printFile "/my/file/path"
```
shellcheck disable=SC2317


## log::errorTrace

Displays an error trace message.
This is a trace message that is always displayed, independently of the log level.
It can be used before a fatal error to display useful information.

- $@: the trace messages to display

```bash
log::errorTrace "This is a debug message."
```




> Documentation generated for the version 0.17.92 (2024-06-05).
