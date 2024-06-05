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
This also allows us to specify to spellcheck the included file.

- $1: the name of the library (array, interactive, string...) or the file path to include.
- $2+: the arguments to pass to the included file (mimics the builtin source command).

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

- $1: the help option
- $2: the parsing errors
- $3: the function name (optional, default to the calling function)

```bash
core::checkParseResults "${help:-}" "${parsingErrors:-}"
core::checkParseResults "${help:-}" "${parsingErrors:-}" "myFunctionName"
```


## core::sourceFunction

Source the file associated with a command function.
This allows you to call a command function without having to source the file manually.

- $1: the function name

```bash
core::sourceFunction "functionName"
```


## core::failWithCode

Displays an error message and then exit the program with error.

- $1: the exit code to use, should be between 1 and 255
- $2+: the error message to display

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

- $@: the error message to display

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


- $@: the arguments to parse

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




> Documentation generated for the version 0.17.92 (2024-06-05).
