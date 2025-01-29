---
title: 📂 system
cascade:
  type: docs
url: /docs/libraries/system
---

## system::addToPath

Add the given path to the PATH environment variable for various shells,
by adding the appropriate export command to the appropriate file.

Will also export the PATH variable in the current bash.

- $1: **path** _as string_:
      the path to add to the PATH environment variable.

```bash
system::addToPath "/path/to/bin"
```


## bash::isCommand

Check if the given command exists.

- $1: **command name** _as string_:
      the command name to check.

Returns:

- $?
  - 0 if the command exists
  - 1 otherwise.

```bash
if bash::isCommand "command1"; then
  printf 'The command exists.'
fi
```


## time::getDate

Get the current date in the given format.

- $1: format _as string_:
      (optional) the format of the date to return
      (defaults to %(%F_%Hh%Mm%Ss)T).

Returns:

- `RETURNED_VALUE`: the current date in the given format.

```bash
time::getDate
local date="${RETURNED_VALUE}"
```

> This function avoid to call $(date) in a subshell (date is a an external executable).


## system::getEnvVars

Get the list of all the environment variables.
In pure bash, no need for env or printenv.

Returns:

- `RETURNED_ARRAY`: An array with the list of all the environment variables.

```bash
system::getEnvVars
for var in "${RETURNED_ARRAY[@]}"; do
  printf '%s=%s\n' "${var}" "${!var}"
done
```

> This is faster than using mapfile on <(compgen -v).


## interactive::getTerminalSize

This function exports the terminal size.

Returns:

- `GLOBAL_COLUMNS`: The number of columns in the terminal.
- `GLOBAL_LINES`: The number of lines in the terminal.

```bash
interactive::getTerminalSize
printf '%s\n' "The terminal has ⌜${GLOBAL_COLUMNS}⌝ columns and ⌜${GLOBAL_LINES}⌝ lines."
```


## bash::getMissingCommands

This function returns the list of not existing commands for the given names.

- $@: **command names** _as string_:
      the list of command names to check.

Returns:

- $?
  - 0 if there are not existing commands
  - 1 otherwise.
- `RETURNED_ARRAY`: the list of not existing commands.

```bash
if bash::getMissingCommands "command1" "command2"; then
  printf 'The following commands do not exist: %s' "${RETURNED_ARRAY[*]}"
fi
```


## bash::getMissingVariables

This function returns the list of undeclared variables for the given names.

- $@: **variable names** _as string_:
      the list of variable names to check.

Returns:

- $?
  - 0 if there are variable undeclared
  - 1 otherwise.
- `RETURNED_ARRAY`: the list of undeclared variables.

```bash
if bash::getMissingVariables "var1" "var2"; then
  printf 'The following variables are not declared: %s' "${RETURNED_ARRAY[*]}"
fi
```


## system::isRoot

Check if the script is running as root.

Returns:

- $?
  - 0 if the script is running as root
  - 1 otherwise.

```bash
if system::isRoot; then
  printf 'The script is running as root.'
fi
```


## system::getOs

Returns the name of the current OS.

Returns:

- `RETURNED_VALUE`: the name of the current OS: "darwin", "linux" or "windows".

```bash
system::getOs
local osName="${RETURNED_VALUE}"
```


## windows::addToPath

Add the given path to the PATH environment variable on Windows (current user only).

Will also export the PATH variable in the current bash.

- $1: **path** _as string_:
      the path to add to the PATH environment variable.
      The path can be in unix format, it will be converted to windows format.

```bash
windows::addToPath "/path/to/bin"
```

> This function is only available on Windows, it uses `powershell` to directly modify the registry.


## windows::getEnvVar

Get the value of an environment variable for the current user on Windows.

- $1: **variable name** _as string_:
      the name of the environment variable to get.

Returns:

- `RETURNED_VALUE`: the value of the environment variable.

```bash
windows::getEnvVar "MY_VAR"
echo "${RETURNED_VALUE}"
```


## windows::setEnvVar

Set an environment variable for the current user on Windows.

- $1: **variable name** _as string_:
      the name of the environment variable to set.
- $2: **variable value** _as string_:
      the value of the environment variable to set.

```bash
windows::setEnvVar "MY_VAR" "my_value"
```

> This function is only available on Windows, it uses `powershell` to directly modify the registry.




> Documentation generated for the version 0.27.285 (2024-12-05).
