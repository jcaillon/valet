---
title: 📂 core
cascade:
  type: docs
url: /docs/libraries/core
---

## core::sourceUserCommands

Source the user 'commands' file from the valet user directory.
If the file does not exist, we build it on the fly.

```bash
core::sourceUserCommands
```


## core::resetIncludedFiles

Allows to reset the included files.
When calling the source function, it will source all the files again.
This is useful when we want to reload the libraries.

```bash
core::resetIncludedFiles
```


## core::getConfigurationDirectory

Returns the path to the valet configuration directory.
Creates it if missing.

Returns:

- `RETURNED_VALUE`: the path to the valet configuration directory

```bash
core::getConfigurationDirectory
local directory="${RETURNED_VALUE}"
```


## core::showHelp

Show the help for the current function.
This should be called directly from a command function for which you want to display the help text.

```bash
core::showHelp
```


## source

Allows to include a library file or sources a file.

It replaces the builtin source command to make sure that we do not include the same file twice.
We replace source instead of creating a new function to allow us to
specify the included file for spellcheck.

- $1: **library name** _as string_:
      the name of the library (array, interactive, string...) or the file path to include.
- $@: arguments _as any_:
      (optional) the arguments to pass to the included file (mimics the builtin source command).

```bash
  source string array system
  source ./my/path my/other/path
```

> - The file can be relative to the current script (script that calls this function).
> - This function makes sure that we do not include the same file twice.
> - Use `builtin source` if you want to include the file even if it was already included.


## core::getUserDirectory

Returns the path to the valet user directory.
Does not create it if missing.

Returns:

- `RETURNED_VALUE`: the path to the valet user directory

```bash
core::getUserDirectory
local directory="${RETURNED_VALUE}"
```


## core::checkParseResults

A convenience function to check the parsing results and fails with an error message if there are
parsing errors.
Will also display the help if the help option is true.

This should be called from a command function for which you want to check the parsing results.

- $1: **display help** _as bool_:
      the help option
- $2: **parsing errors** _as string_:
      the parsing errors
- $3: function name _as string_:
      (optional) the function name
      (defaults to the calling function)

```bash
core::checkParseResults "${help:-}" "${parsingErrors:-}"
core::checkParseResults "${help:-}" "${parsingErrors:-}" "myFunctionName"
```


## core::sourceFunction

Source the file associated with a command function.
This allows you to call a command function without having to source the file manually.

- $1: **function name** _as string_:
      the function name

```bash
core::sourceFunction "functionName"
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


## core::getLocalStateDirectory

Returns the path to the valet locla state directory.
The base directory relative to which user-specific state files should be stored.
Creates it if missing.

Returns:

- `RETURNED_VALUE`: the path to the valet local state directory

```bash
core::getLocalStateDirectory
local directory="${RETURNED_VALUE}"
```


## core::fail

Displays an error message and then exit the program with error.

- $@: **message** _as string_:
      the error message to display

```bash
core::fail "This is an error message."
```


## core::reloadUserCommands

Forcibly source again the user 'commands' file from the valet user directory.

```bash
core::reloadUserCommands
```


## core::parseArguments

Parse the arguments and options of a function and return a string that can be evaluated to set the variables.
This should be called from a command function for which you want to parse the arguments.

See the documentation for more details on the parser: <https://jcaillon.github.io/valet/docs/new-commands/#-implement-your-command>.


- $@: **arguments** _as any_:
      the arguments to parse

Returns:

- `RETURNED_VALUE`: a string that can be evaluated to set the parsed variables

Output example:

```
local arg1 option1
arg1="xxx"
option1="xxx"
```

```bash
core::parseArguments "$@" && eval "${RETURNED_VALUE}"
```




> Documentation generated for the version 0.18.426 (2024-07-08).
