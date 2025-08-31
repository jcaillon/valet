---
title: 📂 log
cascade:
  type: docs
url: /docs/libraries/log
---

## ⚡ log::debug

Displays a debug message.

Inputs:

- `$1`: **message** _as string_:

  the debug messages to display

Example usage:

```bash
log::debug "This is a debug message."
```

## ⚡ log::error

Displays an error message.

Inputs:

- `$1`: **message** _as string_:

  the error messages to display

Example usage:

```bash
log::error "This is an error message."
```

> You probably want to exit immediately after an error and should consider using core::fail function instead.

## ⚡ log::errorTrace

Displays an error trace message.
This is a trace message that is always displayed, independently of the log level.
It can be used before a fatal error to display useful information.

Inputs:

- `$1`: **message** _as string_:

  the trace messages to display

Example usage:

```bash
log::errorTrace "This is a debug message."
```

## ⚡ log::getCallStack

This function returns the current function stack.

Inputs:

- `${stackToSkip}` _as int_:

  (optional) The number of stack to skip.
  For instance, a value of 1 will skip this function.

  (defaults to 1)

- `${stackToSkipAtEnd}` _as int_:

  (optional) The number of stack to skip at the end.

  (defaults to 0)

- `${wrapWidth}` _as int_:

  (optional) The width to wrap the call stack.

  (defaults to 0)

Returns:

- `${REPLY}`: The call stack as a string.

Example usage:

```bash
log::getCallStack
echo "${REPLY}"
log::getCallStack stackToSkip=2 stackToSkipAtEnd=1 wrapWidth=80
```

> For test purposes, you can set the `GLOBAL_MOCK_STACK_FUNCTION_NAMES`, `GLOBAL_MOCK_STACK_SOURCE_FILES` and `GLOBAL_MOCK_STACK_LINE_NUMBERS`
> variables to simulate a call stack.

## ⚡ log::getLevel

Get the current log level.

Returns:

- `${REPLY}`: The current log level.

Example usage:

```bash
log::getLevel
printf '%s\n' "The log level is ⌜${REPLY}⌝."
```

## ⚡ log::info

Displays an info message.

Inputs:

- `$1`: **message** _as string_:

  the info messages to display

Example usage:

```bash
log::info "This is an info message."
```

## ⚡ log::isDebugEnabled

Check if the debug mode is enabled.

Returns:

- `$?`:
  - 0 if debug mode is enabled (log level is debug)
  - 1 if disabled

Example usage:

```bash
if log::isDebugEnabled; then printf '%s\n' "Debug mode is active."; fi
```

## ⚡ log::isTraceEnabled

Check if the trace mode is enabled.

Returns:

- `$?`:
  - 0 if trace mode is enabled (log level is trace)
  - 1 if disabled

Example usage:

```bash
if log::isTraceEnabled; then printf '%s\n' "Debug mode is active."; fi
```

## ⚡ log::printCallStack

This function prints the current function stack in the logs.

Inputs:

- `${stackToSkip}` _as int_:

  (optional) The number of stack to skip.
  For instance, a value of 2 will skip this function and the first calling function.

  (defaults to 2)

- `${stackToSkipAtEnd}` _as int_:

  (optional) The number of stack to skip at the end.

  (defaults to 0)

Example usage:

```bash
log::printCallStack
log::printCallStack stackToSkip=0
```

> For test purposes, you can set the `GLOBAL_MOCK_STACK_FUNCTION_NAMES`, `GLOBAL_MOCK_STACK_SOURCE_FILES` and `GLOBAL_MOCK_STACK_LINE_NUMBERS`
> variables to simulate a call stack.

## ⚡ log::printFile

Display a file content with line numbers in the logs.
The file content will be aligned with the current log output and hard wrapped if necessary.

Inputs:

- `$1`: **path** _as string_:

  the file path to display.

- `${maxLines}` _as int_:

  (optional) Max lines to display, can be set to 0 to display all lines.

  (defaults to 0)

Example usage:

```bash
log::printFile "/my/file/path"
log::printFile "/my/file/path" maxLines=10
```

## ⚡ log::printFileString

Display a file content with line numbers in the logs.
The file content will be aligned with the current log output and hard wrapped if necessary.

Inputs:

- `$1`: **content variable name** _as string_:

  The name of the variable containing the file content to print.

- `${maxLines}` _as int_:

  (optional) Max lines to display, can be set to 0 to display all lines.

  (defaults to 0)

Example usage:

```bash
log::printFileString "myvar"
log::printFileString "myvar" maxLines=10
```

> This function is not at all suited for large strings, print the content to a file instead.

## ⚡ log::printRaw

Display something in the log stream.
Does not check the log level.

Inputs:

- `$1`: **content variable name** _as string_:

  The variable name containing the content to print (can contain new lines).

Example usage:

```bash
log::printRaw "my line"
```

## ⚡ log::printString

Display a string in the log.
The string will be aligned with the current log output and hard wrapped if necessary.
Does not check the log level.

Inputs:

- `$1`: **content** _as string_:

  the content to log (can contain new lines)

- `${newLinePadString}` _as string_:

  (optional) the string with which to prepend each wrapped line

  (defaults to "")

Example usage:

```bash
log::printString "my line"
log::printString "my line" newLinePadString="  "
```

## ⚡ log::saveFile

Save the given file by copying it to a new file in the user local state directory
(using `core::createSavedFilePath`).
Useful for debugging purposes, to save the state of a file during execution.

Inputs:

- `$1`: **path** _as string_:

  The file path to save.

- `${suffix}` _as string_:

  (optional) The suffix for the file to create.

  (defaults to "")

- `${silent}` _as bool_:

  (optional) if true, do not log the path of the saved file using `log::printString`

  (defaults to false)

Returns:

- `${REPLY}`: The path to the saved file.

Example usage:

```bash
log::saveFile "/my/file/path" "suffix" "important result file"
```

## ⚡ log::saveFileString

Save the given string to a new file in the user local state directory
(using `core::createSavedFilePath`).
Useful for debugging purposes, to save the state of a string during execution.

Inputs:

- `$1`: **content variable name** _as string_:

  The variable name of the content to save.

- `${suffix}` _as string_:

  (optional) The suffix for the file to create.

  (defaults to "")

- `${silent}` _as bool_:

  (optional) if true, do not log the path of the saved file using `log::printString`

  (defaults to false)

Returns:

- `${REPLY}`: The path to the saved file.

Example usage:

```bash
log::saveFileString "my content" "suffix" "important result file"
```

## ⚡ log::setLevel

Set the log level.

Inputs:

- `$1`: **log level** _as string_:

  The log level to set (or defaults to info), acceptable values are:
  - trace
  - debug
  - info
  - success
  - warning
  - error

- `${silent}` _as bool_:

  (optional) true to silently switch log level, i.e. does not print a message

  (defaults to false)

Example usage:

```bash
log::setLevel debug
log::setLevel debug silent=true
```

## ⚡ log::success

Displays a success message.

Inputs:

- `$1`: **message** _as string_:

  the success messages to display

Example usage:

```bash
log::success "This is a success message."
```

## ⚡ log::trace

Displays a trace message.

Inputs:

- `$1`: **message** _as string_:

  the trace messages to display

Example usage:

```bash
log::trace "This is a trace message."
```

## ⚡ log::warning

Displays a warning.

Inputs:

- `$1`: **message** _as string_:

  the warning messages to display

Example usage:

```bash
log::warning "This is a warning message."
```

> [!IMPORTANT]
> Documentation generated for the version 0.33.0 (2025-08-31).
