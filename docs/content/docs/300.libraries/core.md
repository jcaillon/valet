---
title: 📂 core
cascade:
  type: docs
url: /docs/libraries/core
---

## core::createNewStateFilePath

Returns the path to a new file stored in the user state directory.
Can be used to save the state of important temporary files generated during a program
execution.

- $1: **file suffix** _as string_:
      The suffix for the file to create.

Returns:

- ${RETURNED_VALUE}: The path to the created file.

```bash
core::createNewStateFilePath "my-file"
printf '%s\n' "The file is ⌜${RETURNED_VALUE}⌝."
```

## core::dump

Dumps information about the current environment into a new state file.

- ${_OPTION_DUMP_SUFFIX} _as string_:
      (optional) The suffix for the file to create.
      (defaults to an empty string)

Returns:

- ${RETURNED_VALUE}: the path to the created file.

```bash
core::dump
```

## core::fail

Displays an error message and then exit the program with error.

- $@: **message** _as string_:
      the error message to display

```bash
core::fail "This is an error message."
```

## core::failWithCode

Displays an error message and then exit the program with error.

- $1: **exit code** _as int_:
      the exit code to use, should be between 1 and 255
- $@: **message** _as string_:
      the error message to display

```bash
core::failWithCode 255 "This is an error message."
```

## core::getConfigurationDirectory

Returns the path to the valet configuration directory.
Creates it if missing.

Returns:

- ${RETURNED_VALUE}: the path to the valet configuration directory

```bash
core::getConfigurationDirectory
local directory="${RETURNED_VALUE}"
```

## core::getExtensionsDirectory

Returns the path to the user extensions directory.
Does not create it if missing.

Returns:

- ${RETURNED_VALUE}: the path to the valet user directory

```bash
core::getExtensionsDirectory
local directory="${RETURNED_VALUE}"
```

## core::getUserCacheDirectory

Returns the path to the valet local cache directory.
Where user-specific non-essential (cached) data should be written (analogous to /var/cache).
Creates it if missing.

Returns:

- ${RETURNED_VALUE}: the path to the valet local state directory

```bash
core::getUserCacheDirectory
local directory="${RETURNED_VALUE}"
```

## core::getUserDataDirectory

Returns the path to the valet local data directory.
Where user-specific data files should be written (analogous to /usr/share).
Creates it if missing.

Returns:

- ${RETURNED_VALUE}: the path to the valet local state directory

```bash
core::getUserDataDirectory
local directory="${RETURNED_VALUE}"
```

## core::getUserStateDirectory

Returns the path to the valet local cache directory.
Where user-specific state files should be written (analogous to /var/lib).
Ideal location for storing runtime information, logs, etc...
Creates it if missing.

Returns:

- ${RETURNED_VALUE}: the path to the valet local state directory

```bash
core::getUserStateDirectory
local directory="${RETURNED_VALUE}"
```

## core::getVersion

Returns the version of Valet.

Returns:

- ${RETURNED_VALUE}: The version of Valet.

```bash
core::getVersion
printf '%s\n' "The version of Valet is ⌜${RETURNED_VALUE}⌝."
```

## include

Allows to include multiple library files.

It calls `source` for each argument.
Useful if you don't have arguments to pass to the sourced files.

- $@: **libraries** _as string_:
      The names of the libraries (array, interactive, string...) or the file paths to include.

```bash
include string array ./my/path
```

## source

Allows to source/include a library file or sources a file.

It replaces the builtin source command to make sure that we do not source the same library twice.
We replace source instead of creating a new function to allow us to
specify the included file for spellcheck.

- $1: **library name or path** _as string_:
      the name of the library (array, interactive, string...) or the file path to include.
- $@: arguments _as any_:
      (optional) the arguments to pass to the sourced file (mimics the builtin source command).

```bash
  source string
  source ./my/path
```

> - The file can be relative to the current script (script that calls this function).
> - Use `builtin source` if you want to include the file even if it was already included.

{{< callout type="info" >}}
Documentation generated for the version 0.29.197 (2025-03-29).
{{< /callout >}}
