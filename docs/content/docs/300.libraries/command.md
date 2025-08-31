---
title: 📂 command
cascade:
  type: docs
url: /docs/libraries/command
---

## ⚡ command::checkParsedResults

A convenience function to check the parsing results and fails with an error message if there are
parsing errors.
Will also display the help if the help option is true.

This should be called from a command function for which you want to check the parsing results.

It uses the variables `help` and `commandArgumentsErrors` to determine if the help should be displayed
and if there are parsing errors.

Example usage:

```bash
command::checkParsedResults
```

## ⚡ command::parseArguments

Parse the arguments and options of a function and return a string that can be evaluated to set the variables.
This should be called from a command function for which you want to parse the arguments.

See the documentation for more details on the parser: <https://jcaillon.github.io/valet/docs/new-commands/#-implement-your-command>.


Inputs:

- `$@`: **arguments** _as any_:

  the arguments to parse

Returns:

- `${REPLY}`: a string that can be evaluated to set the parsed variables

Output example:

```
local arg1 option1
arg1="xxx"
option1="xxx"
```

Example usage:

```bash
command::parseArguments "$@"; eval "${REPLY}"
```

## ⚡ command::showHelp

Show the help for the current function.
This should be called directly from a command function for which you want to display the help text.

Example usage:

```bash
command::showHelp
```

## ⚡ command::sourceFunction

Source the file associated with a command function.
This allows you to call a command function without having to source the file manually.

Inputs:

- `$1`: **function name** _as string_:

  the function name

Example usage:

```bash
command::sourceFunction "functionName"
```

> [!IMPORTANT]
> Documentation generated for the version 0.32.168 (2025-08-31).
