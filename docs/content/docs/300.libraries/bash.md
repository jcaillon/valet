---
title: 📂 bash
cascade:
  type: docs
url: /docs/libraries/bash
---

## ⚡ bash::catchErrors

This function runs a command and will catch any error that occurs instead of failing the program.
The execution will continue if an error occurs in the command, but each error will be stored for later processing.
For a function closer to a try/catch block, see `bash::runInSubshell`.

Inputs:

- `$@`: **command with args** _as string_:

  The command to run.

Returns:

- `${GLOBAL_ERROR_TRAP_LAST_ERROR_CODE}`: the last error code encountered (or zero if none).
- `${GLOBAL_ERROR_TRAP_ERROR_CODES}`: the list of error codes that occurred during the execution of the command.
- `${GLOBAL_ERROR_TRAP_ERROR_STACKS}`: the list of error stacks that occurred during the execution of the command.

Example usage:

```bash
bash::catchErrors myFunction "arg1" "arg2"
if (( GLOBAL_ERROR_TRAP_LAST_ERROR_CODE != 0 )); then
  core::fail "The command failed with code ${GLOBAL_ERROR_TRAP_LAST_ERROR_CODE}."
fi
```

> While you can also put the execution of a command in an `if` (or in a pipeline) statement to effectively
> discard any errors happening in that command, the advantage of using this function is that the ERR trap
> is still triggered and you can use trace level debugging to see the caught issues.
> Additionally, it will report all the errors that occurred during the execution of the command.

## ⚡ bash::countArgs

Returns the number of arguments passed.

A convenient function that can be used to:

- count the files/directories in a directory:
  `bash::countArgs "${PWD}"/* && local numberOfFiles="${REPLY}"`
- count the number of variables starting with VALET_
  `bash::countArgs "${!VALET_@}" && local numberOfVariables="${REPLY}"`

Inputs:

- `$@`: **arguments** _as any_:

  the arguments to count

Returns:

- `${REPLY}`: The number of arguments passed.

Example usage:

```bash
bash::countArgs 1 2 3
```

## ⚡ bash::getBuiltinOutput

Capture the output of a builtin command. Can be used on bash builtins that produce output.
It captures the stdout and stderr of said command.

This function is a lot more basic than `exe::invoke` and does not support all its features.

Inputs:

- `$@`: **command with arguments** _as string_:

  The command to run.

Returns:

- `${REPLY_CODE}`:
  - 0 if the command was successful
  - 1 otherwise.
- `${REPLY}`: The captured output.

Example usage:

```bash
bash::getBuiltinOutput declare -f bash::getBuiltinOutput
echo "${REPLY}"
```

## ⚡ bash::injectCodeInFunction

This function injects code at the beginning or the end of a function and
returns the modified function to be evaluated.

Creates an empty function if the function does not exist initially.

Inputs:

- `$1`: **function name** _as string_:

  The name of the function to inject the code into.

- `$2`: **code** _as string_:

  The code to inject.

- `${injectAtBeginning}` _as bool_:

  (optional) Whether to inject the code at the beginning of the function (or at the end).

  (defaults to false)

Returns:

- `${REPLY}`: the modified function.
- `${REPLY2}`: the original function.

Example usage:

```bash
bash::injectCodeInFunction myFunction "echo 'Hello!'" injectAtBeginning=true
bash::injectCodeInFunction myFunction "echo 'world!'"
eval "${REPLY}"
myFunction
```

## ⚡ bash::isCommand

Check if the given command exists.

Inputs:

- `$1`: **command name** _as string_:

  the command name to check.

Returns:

- `$?`
  - 0 if the command exists
  - 1 otherwise.

Example usage:

```bash
if bash::isCommand "command1"; then
  printf 'The command exists.'
fi
```

## ⚡ bash::isFdValid

Check if the given file descriptor is valid.

Inputs:

- `$1`: **file descriptor** _as string_:

  The file descriptor to check.

Returns:

- `$?`
  - 0 if the file descriptor is valid
  - 1 otherwise.

Example usage:

```bash
if bash::isFdValid 1; then
  echo "File descriptor 1 is valid."
fi
```

## ⚡ bash::isFunction

Check if the given function exists.

Inputs:

- `$1`: **function name** _as string_:

  the function name to check.

Returns:

- `$?`
  - 0 if the function exists
  - 1 otherwise.

Example usage:

```bash
if bash::isFunction "function1"; then
  printf 'The function exists.'
fi
```

## ⚡ bash::isMissingCommands

This function returns the list of not existing commands for the given names.

Inputs:

- `$@`: **command names** _as string_:

  the list of command names to check.

Returns:

- `$?`
  - 0 if there are not existing commands
  - 1 otherwise.
- `${REPLY_ARRAY[@]}`: the list of not existing commands.

Example usage:

```bash
if bash::isMissingCommands "command1" "command2"; then
  printf 'The following commands do not exist: %s' "${REPLY_ARRAY[*]}"
fi
```

## ⚡ bash::popd

Change the current directory to the one on top of the directory stack and remove it from the stack.

Contrary to the builtin popd, this function does not print the directory stack after changing the directory
and will print an error message before calling core::fail if the directory change fails.

Example usage:

```bash
bash::popd
```

## ⚡ bash::pushd

Change the current directory and push the old one to the directory stack.

Contrary to the builtin pushd, this function does not print the directory stack after changing the directory
and will print an error message before calling core::fail if the directory change fails.

Inputs:

- `$1`: **directory** _as string_:

  The directory to change to.

Example usage:

```bash
bash::pushd "/path/to/directory"
```

## ⚡ bash::readStdIn

Read the content of the standard input.
Will immediately return if the standard input is empty.

Returns:

- `${REPLY}`: The content of the standard input.

Example usage:

```bash
bash::readStdIn
echo "${REPLY}"
```

## ⚡ bash::restoreShellOption

Restores the given shell option to its original state (see `bash::setShellOption` or `bash::unsetShellOption`).

Inputs:

- `$1`: **option name** _as string_:

  The option to restore (e.g. `nocasematch`).

Example usage:

```bash
bash::restoreShellOption nocasematch
```

## ⚡ bash::runInSubshell

This functions runs a command in a subshell.
The command can fail and can trigger errors; it will be caught and this function will return
the exit code of the subshell.
This function can almost be considered as a try/catch block for bash as the execution will stop on error
but the error will be caught and stored for later processing instead of exiting the program.

Inputs:

- `$@`: **command with args** _as string_:

  The command to run in the subshell.

- `$_OPTION_EXIT_ON_FAIL` _as bool_:

  (optional) If set to true, the main program will exit with code 1 if the command fails.

  (defaults to false)

Returns:

- `${REPLY_CODE}`: the exit code of the subshell.

Example usage:

```bash
bash::runInSubshell myFunction
if (( REPLY_CODE != 0 )); then
  core::fail "The subshell failed with code ${REPLY_CODE}"
fi
_OPTION_EXIT_ON_FAIL=true bash::runInSubshell myFunction
```

> This function exists because the behavior of bash subshells are not what you would expect.
> This function ensures that errors are properly handled and make the command list fail,
> it ensures that we run the exit trap and it gives you the correct exit code of the subshell.
> As a reminder, the error trap is not triggered for commands part of until while if ! || && tests,
> see <https://www.gnu.org/software/bash/manual/bash.html#index-trap> and
> <https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin-1>.

## ⚡ bash::setShellOption

Sets the given shell optional behavior if it is not already set.
Allows to later use `bash::restoreShellOption` to restore the original state of the given shell option.

Inputs:

- `$1`: **option name** _as string_:

  The option to set (e.g. `nocasematch`).

Example usage:

```bash
bash::setShellOption nocasematch
```

> To set shell options, simply use `local -; set -/+ optionName` in functions (`local -` makes it local).
> The builtin shopt cannot be scoped to a function (it is always global), this is why this function exists.

## ⚡ bash::sleep

Sleep for the given amount of time.
This is a pure bash replacement of sleep.

Inputs:

- `$1`: **time** _as float_:

  the time to sleep in seconds (can be a float)
  If 0, waits indefinitely.

Example usage:

```bash
bash::sleep 1.5
```

> The sleep command is not a built-in command in bash, but a separate executable. When you use sleep, you are creating a new process.

## ⚡ bash::unsetShellOption

Unsets the given shell optional behavior if it is not already unset.
Allows to later use `bash::restoreShellOption` to restore the original state of the given shell option.

Inputs:

- `$1`: **option name** _as string_:

     The option to unset (e.g. `nocasematch`).

Example usage:

```bash
bash::unsetShellOption nocasematch
```

> To unset shell options, simply use `local -; set -/+ optionName` in functions (`local -` makes it local).
> The builtin shopt cannot be scoped to a function (it is always global), this is why this function exists.

> [!IMPORTANT]
> Documentation generated for the version 0.40.137 (2026-06-03).
