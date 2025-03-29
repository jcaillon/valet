---
title: 📂 command
cascade:
  type: docs
url: /docs/libraries/command
---

## command::checkParsedResults

A convenience function to check the parsing results and fails with an error message if there are
parsing errors.
Will also display the help if the help option is true.

This should be called from a command function for which you want to check the parsing results.

It uses the variables `help` and `commandArgumentsErrors` to determine if the help should be displayed
and if there are parsing errors.

```bash
command::checkParsedResults
```

## command::parseArguments

Parse the arguments and options of a function and return a string that can be evaluated to set the variables.
This should be called from a command function for which you want to parse the arguments.

See the documentation for more details on the parser: <https://jcaillon.github.io/valet/docs/new-commands/#-implement-your-command>.


- $@: **arguments** _as any_:
      the arguments to parse

Returns:

- ${RETURNED_VALUE}: a string that can be evaluated to set the parsed variables

Output example:

```
local arg1 option1
arg1="xxx"
option1="xxx"
```

```bash
command::parseArguments "$@" && eval "${RETURNED_VALUE}"
```

## command::showHelp

Show the help for the current function.
This should be called directly from a command function for which you want to display the help text.

```bash
command::showHelp
```

## command::sourceFunction

Source the file associated with a command function.
This allows you to call a command function without having to source the file manually.

- $1: **function name** _as string_:
      the function name

```bash
command::sourceFunction "functionName"
```

{{< callout type="info" >}}
Documentation generated for the version 0.29.197 (2025-03-29).
{{< /callout >}}
