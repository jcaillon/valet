---
title: 📂 bash
cascade:
  type: docs
url: /docs/libraries/bash
---

## bash::countArgs

Returns the number of arguments passed.

A convenient function that can be used to:

- count the files/directories in a directory:
  `bash::countArgs "${PWD}"/* && local numberOfFiles="${RETURNED_VALUE}"`
- count the number of variables starting with VALET_
  `bash::countArgs "${!VALET_@}" && local numberOfVariables="${RETURNED_VALUE}"`

Inputs:

- $@: **arguments** _as any_:
      the arguments to count

Returns:

- ${RETURNED_VALUE}: The number of arguments passed.

```bash
bash::countArgs 1 2 3
```

## bash::countJobs

This function counts the number of jobs currently running in the background.

Returns:

- ${RETURNED_VALUE}: the number of jobs currently running in the background.

```bash
bash::countJobs
echo "There are currently ${RETURNED_VALUE} jobs running in the background."
```

## bash::getFunctionDefinitionWithGlobalVars

This function can be used to get the definition of an existing function,
rename it, and replace the use of positional parameters by global variables.

This can be useful for performance reasons when a function is called many times,
to avoid copying the positional parameters each time.

- $1: **function name** _as string_:
      the name of the function to re-export
- $2: **new function name** _as string_:
      the name of the new function to create
- $@: global variable name _as string_:
      the name of the global variable to use instead of the positional parameters
      (can be repeated multiple times, for each parameter)

Returns:

- $?:
  - 0 if the function was successfully re-exported
  - 1 if the function does not exist
- ${RETURNED_VALUE}: the modified function definition
- ${RETURNED_VALUE2}: the original function

```bash
bash::getFunctionDefinitionWithGlobalVars "myFunction" "myFunctionWithGlobalVars" "MY_VAR1" "MY_VAR2"
eval "${RETURNED_VALUE}"
myFunctionWithGlobalVars
```

## bash::getMissingCommands

This function returns the list of not existing commands for the given names.

- $@: **command names** _as string_:
      the list of command names to check.

Returns:

- $?
  - 0 if there are not existing commands
  - 1 otherwise.
- ${RETURNED_ARRAY[@]}: the list of not existing commands.

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
- ${RETURNED_ARRAY[@]}: the list of undeclared variables.

```bash
if bash::getMissingVariables "var1" "var2"; then
  printf 'The following variables are not declared: %s' "${RETURNED_ARRAY[*]}"
fi
```

## bash::injectCodeInFunction

This function injects code at the beginning or the end of a function and
returns the modified function to be evaluated.

- $1: **function name** _as string_:
      The name of the function to inject the code into.
- $2: **code** _as string_:
      The code to inject.
- $3: inject at beginning _as bool_:
      (optional) Can be set using the variable `_OPTION_INJECT_AT_BEGINNING`.
      Whether to inject the code at the beginning of the function (or at the end).
      (defaults to false)

Returns:

- ${RETURNED_VALUE}: the modified function.
- ${RETURNED_VALUE2}: the original function.

```bash
bash::injectCodeInFunction myFunction "echo 'Hello world!'" true
eval "${RETURNED_VALUE}"
myFunction
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

## bash::isFunction

Check if the given function exists.

- $1: **function name** _as string_:
      the function name to check.

Returns:

- $?
  - 0 if the function exists
  - 1 otherwise.

```bash
if bash::isFunction "function1"; then
  printf 'The function exists.'
fi
```

## bash::readStdIn

Read the content of the standard input.
Will immediately return if the standard input is empty.

Returns:

- ${RETURNED_VALUE}: The content of the standard input.

```bash
bash::readStdIn && local stdIn="${RETURNED_VALUE}"
```

## bash::runInParallel

This function runs a list of commands in parallel with a maximum number of parallel jobs.

- $1: **job names array name** _as string_:
      The name of the array containing the names of the jobs to run.
- $2: **job commands array name** _as string_:
      The name of the array containing the commands to run.
- $3: max parallel jobs _as integer_:
      (optional) Can be set using the variable `_OPTION_MAX_PARALLEL_JOBS`.
      The maximum number of parallel jobs to run.
      (defaults to 4)
- $4: job completed callback _as string_:
      (optional) Can be set using the variable `_OPTION_JOB_COMPLETED_CALLBACK`.
      The name of the function to call when a job is completed.
      The function will receive the following arguments:
      - the job index
      - the job name
      - the job exit code
      - the percentage of jobs completed
      If the function returns 1, the script will exit early.
      (defaults to "")
- ${_OPTION_TIMEOUT_BETWEEN_CHECKS} _as float_:
      (optional) Can be set using the variable `_OPTION_TIMEOUT_BETWEEN_CHECKS`.
      The time to wait between checks for completed jobs (when no jobs finished
      when we last checked).
      (defaults to 0.2)

Returns:

- $?:
  - 0: if all the jobs completed successfully.
  - 1: if the job completed callback returned 1.
- ${RETURNED_ARRAY[@]}: an array containing the exit codes of the jobs.

```bash
declare -a jobNames=("job1" "job2" "job3")
declare -a jobCommands=("sleep 1" "sleep 2" "sleep 3")
_OPTION_MAX_PARALLEL_JOBS=2 bash::runInParallel jobNames jobCommands
```

## bash::sleep

Sleep for the given amount of time.
This is a pure bash replacement of sleep.

- $1: **time** _as float_:
      the time to sleep in seconds (can be a float)

```bash
bash::sleep 1.5
```

> The sleep command is not a built-in command in bash, but a separate executable. When you use sleep, you are creating a new process.

{{< callout type="info" >}}
Documentation generated for the version 0.29.197 (2025-03-29).
{{< /callout >}}
