---
title: 📂 exe
cascade:
  type: docs
url: /docs/libraries/exe
---

## exe::captureOutput

Capture the output of a command.
Made to be used on bash builtins that produce output.
It captures the stdout and stderr of the command.

This function is a lot more basic than `exe::invoke` and does not support all its features.

- $@: **command** _as string_:
      The command to run.

Returns:

- $?
  - 0 if the command was successful
  - 1 otherwise.
- ${RETURNED_VALUE}: The captured output.

```bash
exe::captureOutput declare -f exe::captureOutput
echo "${RETURNED_VALUE}"
```

## exe::invoke

This function call an executable and its arguments.
If the execution fails, it will fail the script and show the std/err output.
Otherwise it hides both streams, effectively rendering the execution silent unless it fails.

It redirects the stdout and stderr to environment variables.
Equivalent to `exe::invoke5 true 0 '' '' "${@}"`

- $1: **executable** _as string_:
      the executable or command
- $@: **arguments** _as any_:
      the command and its arguments

Returns:

- $?:The exit code of the executable.
- ${RETURNED_VALUE}: The content of stdout.
- ${RETURNED_VALUE2}: The content of stderr.

```bash
exe::invoke git add --all
```

> See exe::invokef5 for more information.

## exe::invoke2

This function call an executable and its arguments.
It redirects the stdout and stderr to environment variables.
Equivalent to `exe::invoke5 "${1}" 0 "" "" "${@:2}"`

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?:The exit code of the executable.
- ${RETURNED_VALUE}: The content of stdout.
- ${RETURNED_VALUE2}: The content of stderr.

```bash
exe::invoke2 false git status || core::fail "status failed."
stdout="${RETURNED_VALUE}"
stderr="${RETURNED_VALUE2}"
```

> See exe::invokef5 for more information.

## exe::invoke3piped

This function call an executable and its arguments and input a given string as stdin.
It redirects the stdout and stderr to environment variables.
Equivalent to `exe::invoke5 "${1}" 0 false "${2}" "${@:3}"`

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **stdin** _as string_:
      The stdin content to pass to the executable
- $3: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?:The exit code of the executable.
- ${RETURNED_VALUE}: The content of stdout.
- ${RETURNED_VALUE2}: The content of stderr.

```bash
exe::invoke3piped true "key: val" yq -o json -p yaml -
stdout="${RETURNED_VALUE}"
stderr="${RETURNED_VALUE2}"
```

> This is the equivalent of:
> `myvar="$(printf '%s\n' "mystring" | mycommand)"`
> But without using a subshell.
>
> See exe::invokef5 for more information.

## exe::invoke5

This function call an executable and its arguments.
It redirects the stdout and stderr to environment variables.
It calls invoke5 and reads the files to set the environment variables.

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **acceptable codes** _as string_:
      the acceptable error codes, comma separated
      (if the error code is matched, then set the output error code to 0)
- $3: **stdin from file** _as bool_:
      true/false to indicate if the 4th argument represents a file path or directly the content for stdin
- $4: **stdin** _as string_:
      the stdin (can be empty)
- $5: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?:The exit code of the executable.
- ${RETURNED_VALUE}: The content of stdout.
- ${RETURNED_VALUE2}: The content of stderr.

```bash
exe::invoke5 "false" "130,2" "false" "This is the stdin" "stuff" "--height=10" || core::fail "stuff failed."
stdout="${RETURNED_VALUE}"
stderr="${RETURNED_VALUE2}"
```

> See exe::invokef5 for more information.

## exe::invokef2

This function call an executable and its arguments.
It redirects the stdout and stderr to temporary files.
Equivalent to `exe::invokef5 "${1}" 0 "" "" "${@:2}"`

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?:The exit code of the executable.
- ${RETURNED_VALUE}: The file path containing the stdout of the executable.
- ${RETURNED_VALUE2}: The file path containing the stderr of the executable.

```bash
exe::invokef2 false git status || core::fail "status failed."
stdoutFilePath="${RETURNED_VALUE}"
stderrFilePath="${RETURNED_VALUE2}"
```

> See exe::invokef5 for more information.

## exe::invokef3piped

This function call an executable and its arguments and input a given string as stdin.
It redirects the stdout and stderr to temporary files.
Equivalent to `exe::invokef5 "${1}" 0 false "${2}" "${@:3}"`

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **stdin** _as string_:
      The stdin content to pass to the executable
- $3: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?:The exit code of the executable.
- ${RETURNED_VALUE}: The file path containing the stdout of the executable.
- ${RETURNED_VALUE2}: The file path containing the stderr of the executable.

```bash
exe::invokef3piped true "key: val" yq -o json -p yaml -
stdoutFilePath="${RETURNED_VALUE}"
stderrFilePath="${RETURNED_VALUE2}"
```

> This is the equivalent of:
> `myvar="$(printf '%s\n' "mystring" | mycommand)"`
> But without using a subshell.
>
> See exe::invokef5 for more information.

## exe::invokef5

This function call an executable and its arguments.
It redirects the stdout and stderr to temporary files.

- $1: **fail** _as bool_:
      A boolean to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **acceptable codes** _as string_:
      The acceptable error codes, comma separated.
      (if the error code is matched, then set the output error code to 0)
- $3: **sdtin from file** _as bool_:
      A boolean to indicate if the 4th argument represents a file path or
      directly the content for stdin.
- $2: **stdin** _as string_:
      The stdin content to pass to the executable.
      Can be empty if not used.
- $5: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable
- ${_OPTION_NO_REDIRECTION}: _as bool_:
      (optional) If set to true, the function will not redirect the stdout and stderr to temporary files.
      (default to false)

Returns:

- $?:The exit code of the executable.
- ${RETURNED_VALUE}: The file path containing the stdout of the executable.
- ${RETURNED_VALUE2}: The file path containing the stderr of the executable.

```bash
exe::invokef5 "false" "130,2" "false" "This is the stdin" "stuff" "--height=10" || core::fail "stuff failed."
stdoutFilePath="${RETURNED_VALUE}"
stderrFilePath="${RETURNED_VALUE2}"
```

> - In windows, this is tremendously faster to do (or any other invoke flavor):
>   `exe::invokef5 false 0 false '' mycommand && myvar="${RETURNED_VALUE}"`
>   than doing:
>   `myvar="$(mycommand)".`
> - On linux, it is slightly faster (but it might be slower if you don't have SSD?).
> - On linux, you can use a tmpfs directory for massive gains over subshells.

## exe::invoket2

This function call an executable and its arguments.
It does not redirect the stdout and stderr so it outputs to the
default 1/2 file descriptors.
Equivalent to `_OPTION_NO_REDIRECTION=true exe::invokef5 "${1}" 0 "" "" "${@:2}"`

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

Returns:

- $?:The exit code of the executable.

```bash
exe::invoket2 false git status || core::fail "status failed."
```

> See exe::invokef5 for more information.

{{< callout type="info" >}}
Documentation generated for the version 0.29.197 (2025-03-29).
{{< /callout >}}
