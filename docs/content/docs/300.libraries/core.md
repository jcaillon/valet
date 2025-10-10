---
title: 📂 core
cascade:
  type: docs
url: /docs/libraries/core
---

## ⚡ core::createSavedFilePath

Returns the path to a new file stored in the user state directory under `saved-files`.
Can be used to save the state of important temporary files generated during a program
execution.

Inputs:

- `${suffix}` _as string_:

  (optional) The suffix for the file to create.

  (defaults to "")

Returns:

- `${REPLY}`: The path to the created file.

Example usage:

```bash
core::createSavedFilePath
core::createSavedFilePath suffix="my-file"
printf '%s\n' "The file is ⌜${REPLY}⌝."
```

## ⚡ core::dump

Dumps information about the current bash session into a new file.

Inputs:

- `${dumpSuffix}` _as string_:

  (optional) The suffix for the file to create.

  (defaults to "")

Returns:

- `${REPLY}`: the path to the created file.

Example usage:

```bash
core::dump
```

## ⚡ core::exit

Exits the program with the given exit code.

We replace the builtin exit command to make sure that we can correctly capture where
the exit was called and print the call stack.

Inputs:

- `$1`: exit code _as int_:

  (optional) the exit code to use, should be between 0 and 255

  (defaults to 0)

- `${silent}` _as bool_:

  (optional) If true, will not print the exit message and call stack for non zero exit codes.

  (defaults to false)

Example usage:

```bash
core::exit 0
core::exit 0 silent=true
```

## ⚡ core::fail

Displays an error message and then exit the program with error.

Inputs:

- `$1`: **message** _as string_:

  The error message to display

- `${exitCode}` _as int_:

  (optional) the exit code to use, should be between 1 and 255

  (defaults to 1)

Example usage:

```bash
core::fail "This is an error message."
core::fail "This is an error message." exitCode=255
```

## ⚡ core::getConfigurationDirectory

Returns the path to the valet configuration directory.
Creates it if missing.

Returns:

- `${REPLY}`: the path to the valet configuration directory

Example usage:

```bash
core::getConfigurationDirectory
local directory="${REPLY}"
```

> The default configuration directory is `~/.config/valet`.

## ⚡ core::getExtensionsDirectory

Returns the path to the user extensions directory.
Creates it if missing.

Returns:

- `${REPLY}`: the path to the valet user directory

Example usage:

```bash
core::getExtensionsDirectory
local directory="${REPLY}"
```

> The default extensions directory is `~/.valet.d`.

## ⚡ core::getUserCacheDirectory

Returns the path to the valet local cache directory.
Where user-specific non-essential (cached) data should be written (analogous to /var/cache).
Creates it if missing.

Returns:

- `${REPLY}`: the path to the valet local state directory

Example usage:

```bash
core::getUserCacheDirectory
local directory="${REPLY}"
```

> The default cache directory is `~/.cache/valet`.

## ⚡ core::getUserDataDirectory

Returns the path to the valet local data directory.
Where user-specific data files should be written (analogous to /usr/share).
Creates it if missing.

Returns:

- `${REPLY}`: the path to the valet local state directory

Example usage:

```bash
core::getUserDataDirectory
local directory="${REPLY}"
```

> The default data directory is `~/.local/share/valet`.

## ⚡ core::getUserStateDirectory

Returns the path to the valet local cache directory.
Where user-specific state files should be written (analogous to /var/lib).
Ideal location for storing runtime information, logs, etc...
Creates it if missing.

Returns:

- `${REPLY}`: the path to the valet local state directory

Example usage:

```bash
core::getUserStateDirectory
local directory="${REPLY}"
```

> The default state directory is `~/.local/state/valet`.

## ⚡ core::getVersion

Returns the version of Valet.

Returns:

- `${REPLY}`: The version of Valet.

Example usage:

```bash
core::getVersion
printf '%s\n' "The version of Valet is ⌜${REPLY}⌝."
```

## ⚡ core::initSubshell

Do the necessary initialization for a new subshell, ensuring coherent behavior:

- Set the correct traps.
- Initialize specific temporary files/directories location.
- Reset the elapsed time to 0.
- Reset the background processes.

Example usage:

```bash
core::initSubshell
```

## ⚡ core::parseFunctionOptions

Parses the shell parameters passed as arguments and sets the REPLY variable to a string that can be
evaluated to set the local variables required in the calling function.

This should be called when you need to parse the arguments of a function that has a finite number of arguments
(i.e. that uses $@ or $*) in which case we expect the shell parameters to be passed after a separator `---`.

Inputs:

- `$@`: arguments _as any_:

  The arguments to parse.

Returns:

- `${REPLY}`: The string to evaluate to set the local variables.

Example usage:

```bash
core::parseFunctionOptions 1 2 3 --- myOption=one
eval "${REPLY}"
# REPLY will be: local myOption="one"; set -- "${@:1:3}"
```

## ⚡ include

Allows to include multiple library files.

It calls `source` for each argument.
Useful if you don't have arguments to pass to the sourced files.

Inputs:

- `$@`: **libraries** _as string_:

  The names of the libraries (array, interactive, string...) or the file paths to include.

Example usage:

```bash
include string array ./my/path
```

## ⚡ source

Allows to source/include a library file or sources a file.

When sourcing a library, omit the `lib-` prefix.
It will source all user and core libraries with the given name.

It replaces the builtin source command to make sure that we do not source the same library twice.
We replace source instead of creating a new function to allow us to
specify the included file for spellcheck.

Inputs:

- `$1`: **library name or path** _as string_:

  the name of the library (array, interactive, string...) or the file path to include.

- `$@`: arguments _as any_:

  (optional) the arguments to pass to the sourced file (mimics the builtin source command).

- `$_OPTION_CONTINUE_IF_NOT_FOUND` _as bool_:

  (optional) Do not fail the program if we do not find a file to source, we simply return 1.

  (defaults to false)

- `$_OPTION_RETURN_CODE_IF_ALREADY_INCLUDED` _as int_:

  (optional) The function return code if the given file or library was already
  included.

  (defaults to 0)

Example usage:

```bash
source string
source ./my/path
_OPTION_CONTINUE_IF_NOT_FOUND=false _OPTION_RETURN_CODE_IF_ALREADY_INCLUDED=2 source ./my/path
```

> - The file can be relative to the current script (script that calls this function).
> - Use `builtin source` if you want to include the file even if it was already included.

> [!IMPORTANT]
> Documentation generated for the version 0.36.26 (2025-10-10).
