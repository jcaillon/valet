---
title: 📂 exe
cascade:
  type: docs
url: /docs/libraries/exe
---

## ⚡ exe::invoke

This function call an executable with its optional arguments.

By default it redirects the stdout and stderr and captures them to output variables.
This makes the executes silent unless the executable fails.
By default, it will exit (core::fail) if the executable returns a non-zero exit code.

This function should be used as a wrapper around any external program as it allows to easily
mock the program during tests and facilitates debugging with trace level log.

Inputs:

- `$1`: **executable** _as string_:

  the executable or function to execute

- `$@`: **arguments** _as any_:

  the arguments to pass to the executable

- `${noFail}` _as bool_:

  (optional) A boolean to indicate if the function should call core::fail (exit) in case the execution fails.
  If true and the execution fails, the script will exit.

  (defaults to false)

- `${replyPathOnly}` _as bool_:

  (optional) If set to true, the function will return the file path of the stdout and stderr files
  instead of their content. This will make the function faster.

  (defaults to false)

- `${stdoutPath}` _as string_:

  (optional) The file path to use for the stdout of the executable. Otherwise a temporary work file will be used.

  (defaults to "")

- `${stderrPath}` _as string_:

  (optional) The file path to use for the stderr of the executable. Otherwise a temporary work file will be used.

  (defaults to "")

- `${stdinFile}` _as bool_:

  (optional) The file path to use as stdin for the executable.

  (defaults to "")

- `${stdin}` _as string_:

  (optional) The stdin content to pass to the executable.
  Can be empty if not used.

  (defaults to "")

- `${acceptableCodes}` _as string_:

  (optional) The acceptable error codes, comma separated.
  If the error code is matched, then REPLY_CODE is set to 0)

  (defaults to "0")

- `${failMessage}` _as string_:

  (optional) The message to display on failure.

  (defaults to "")

- `${appendRedirect}` _as bool_:

  (optional) If true will append the output to the stdout/stderr files instead of overwriting them (>> redirect).
  This is useful when you want to run the same command multiple times and keep the previous output.
  The stderr and stdout REPLY variables will both have the same content.

  (defaults to false)

- `${groupRedirect}` _as bool_:

  (optional) If true will output stdout/stderr to the same file (&> redirect).

  (defaults to false)

- `${noRedirection}` _as bool_:

  (optional) If set to true, the function will not redirect the stdout and stderr to temporary files.

  (defaults to false)

Returns:

- `${REPLY_CODE}`: The exit code of the executable.
- `${REPLY}`: The content of stdout (or file path to stdout if `replyPathOnly=true`).
- `${REPLY2}`: The content of stderr (or file path to stdout if `replyPathOnly=true`).

Example usage:

```bash
# basic usage with some arguments:
exe::invoke git branch --list --sort=-committerdate
echo "${REPLY}"

# invoke a command that is allowed to return an error code:
exe::invoke risky-command --- noFail=true
echo "${REPLY_CODE}"

# invoke a command with custom stdout / stderr files and do not read the output into REPLY vars:
exe::invoke thing --- stdoutPath=/path/to/stdout stderrPath=/path/to/stderr replyPathOnly=true

# invoke a command and let the outputs go to the console:
exe::invoke cat file --- noRedirection=true

# invoke a command with stdin from a string:
exe::invoke cat --- stdin="Hello World"
```

> - In windows, this is tremendously faster to do:
>   `exe::invoke mycommand; myvar="${REPLY}"`
>   than doing:
>   `myvar="$(mycommand)".`
> - On linux, it is slightly faster (but it might be slower if you don't have SSD?).
> - On linux, you can use a tmpfs directory for massive gains over subshells.

> [!IMPORTANT]
> Documentation generated for the version 0.33.0 (2025-08-31).
