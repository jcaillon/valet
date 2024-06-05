---
title: 📂 io
cascade:
  type: docs
url: /docs/libraries/io
---

## io::toAbsolutePath

This function returns the absolute path of a file.

- $1: The file to get the absolute path.

Returns:

- `RETURNED_VALUE`: The absolute path of the file.

```bash
io::toAbsolutePath "myFile"
local myFileAbsolutePath="${RETURNED_VALUE}"
```


## io::listPaths

List all the paths in the given directory.

- $1: the directory to list
- $2: (optional) true to list recursively, false otherwise (default to false)
- $3: (optional) true to list hidden paths, false otherwise (default to false)
- $4: (optional) a function name that is called to filter the paths that will be listed
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.
- $5: (optional) a function name that is called to filter the directories (for recursive listing)
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.

Returns:

- `RETURNED_ARRAY`: An array with the list of all the paths.

```bash
io::listPaths "/path/to/directory" true true myFilterFunction myFilterDirectoryFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```

> - It will correctly list files under symbolic link directories.


## io::createFilePathIfNeeded

Make sure that the given file path exists.
Create the directory tree and the file if needed.

- $1: the file path to create

Returns:

- `RETURNED_VALUE`: The absolute path of the file.

```bash
io::createFilePathIfNeeded "myFile"
```


## io::checkAndFail

Check last return code and fail (exit) if it is an error.

- $1: the return code
- $2+ : the error message to display in case of error

```bash
command_that_could_fail || io::checkAndFail "$?" "The command that could fail has failed!"
```


## io::listFiles

List all the files in the given directory.

- $1: the directory to list
- $2: (optional) true to list recursively, false otherwise (default to false)
- $3: (optional) true to list hidden paths, false otherwise (default to false)
- $4: (optional) a function name that is called to filter the directories (for recursive listing)
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.

Returns:

- `RETURNED_ARRAY`: An array with the list of all the files.

```bash
io::listFiles "/path/to/directory" true true myFilterFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```


## io::cleanupTempFiles

Removes all the temporary files and directories that were created by the
io::createTempFile and io::createTempDirectory functions.

```bash
io::cleanupTempFiles
```
shellcheck disable=SC2016


## io::listDirectories

List all the directories in the given directory.

- $1: the directory to list
- $2: (optional) true to list recursively, false otherwise (default to false)
- $3: (optional) true to list hidden paths, false otherwise (default to false)
- $4: (optional) a function name that is called to filter the sub directories (for recursive listing)
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.

Returns:

- `RETURNED_ARRAY`: An array with the list of all the files.

```bash
io::listDirectories "/path/to/directory" true true myFilterFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```


## io::cat

Print the content of a file to stdout.
This is a pure bash equivalent of cat.

- $1: the file to print

```bash
io::cat "myFile"
```

> Also see log::printFile if you want to print a file for a user.


## io::countArgs

Returns the number of arguments passed.

A convenient function that can be used to:
- count the files/directories in a directory
  `io::countArgs "${PWD}"/* && local numberOfFiles="${RETURNED_VALUE}"`
- count the number of variables starting with VALET_
  `io::countArgs "${!VALET_@}" && local numberOfVariables="${RETURNED_VALUE}"`

Returns:

- `RETURNED_VALUE`: The number of arguments passed.

```bash
io::countArgs 1 2 3
```


## io::createTempFile

Creates a temporary file and return its path.

Returns:

- `RETURNED_VALUE`: The created path.

```bash
io::createTempFile
local file="${RETURNED_VALUE}"
```

> Files created this way are automatically cleaned up by the io::cleanupTempFiles
> function when valet ends.


## io::invoke2piped

This function call an executable and its arguments and input a given string as stdin.
It redirects the stdout and stderr to environment variables.
Equivalent to io::invoke5 "${1}" 0 false "${2}" "${@:3}"

- $1: true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: the stdin to pass to the executable
- $3: the executable or function to execute
- $4+: the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::invoke2piped true "key: val" yq -o json -p yaml -
stdout="${RETURNED_VALUE}"
stderr="${RETURNED_VALUE2}"
```

> This is the equivalent of:
> `myvar="$(printf '%s\n' "mystring" | mycommand)"`
> But without using a subshell.
>
> See io::invokef5 for more information.


## io::invokef2piped

This function call an executable and its arguments and input a given string as stdin.
It redirects the stdout and stderr to temporary files.
Equivalent to io::invokef5 "${1}" 0 false "${2}" "${@:3}"

- $1: true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: the stdin to pass to the executable
- $3: the executable or function to execute
- $4+: the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The file path containing the stdout of the executable.
- `RETURNED_VALUE2`: The file path containing the stderr of the executable.

```bash
io::invokef2piped true "key: val" yq -o json -p yaml -
stdoutFilePath="${RETURNED_VALUE}"
stderrFilePath="${RETURNED_VALUE2}"
```

> This is the equivalent of:
> `myvar="$(printf '%s\n' "mystring" | mycommand)"`
> But without using a subshell.
>
> See io::invokef5 for more information.


## io::invoke

This function call an executable and its arguments.
If the execution fails, it will fail the script and show the std/err output.
Otherwise it hides both streams, effectively rendering the execution silent unless it fails.

It redirects the stdout and stderr to environment variables.
Equivalent to io::invoke5 true 0 '' '' "${@}"

- $@: the command and its arguments

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::invoke git add --all
```

> See io::invokef5 for more information.


## io::createTempDirectory

Creates a temporary directory.

Returns:

- `RETURNED_VALUE`: The created path.

```bash
io::createTempDirectory
local directory="${RETURNED_VALUE}"
```

> Directories created this way are automatically cleaned up by the io::cleanupTempFiles
> function when valet ends.


## io::sleep

Sleep for the given amount of time.
This is a pure bash replacement of sleep.

- $1: the time to sleep in seconds (can be a float)

```bash
io:sleep 1.5
```

> The sleep command is not a built-in command in bash, but a separate executable. When you use sleep, you are creating a new process.


## io::invokef2

This function call an executable and its arguments.
It redirects the stdout and stderr to temporary files.
Equivalent to io::invokef5 "${1}" 0 "" "" "${@:2}"

- $1: true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: the executable or function to execute
- $3+: the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The file path containing the stdout of the executable.
- `RETURNED_VALUE2`: The file path containing the stderr of the executable.

```bash
io::invokef2 false git status || core::fail "status failed."
stdoutFilePath="${RETURNED_VALUE}"
stderrFilePath="${RETURNED_VALUE2}"
```

> See io::invokef5 for more information.


## io::invokef5

This function call an executable and its arguments.
It redirects the stdout and stderr to temporary files.

- $1: true/false to indicate if the function should fail in case the execution fails.
  If true and the execution fails, the script will exit.
- $2: the acceptable error codes, comma separated
  (if the error code is matched, then set the output error code to 0)
- $3: true/false to indicate if the 4th argument represents a file path or directly the content for stdin
- $4: the stdin (can be empty)
- $5: the executable or function to execute
- $6+: the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The file path containing the stdout of the executable.
- `RETURNED_VALUE2`: The file path containing the stderr of the executable.

```bash
io::invokef5 "false" "130,2" "false" "This is the stdin" "stuff" "--height=10" || core::fail "stuff failed."
stdoutFilePath="${RETURNED_VALUE}"
stderrFilePath="${RETURNED_VALUE2}"
```

> - In windows, this is tremendously faster to do (or any other invoke flavor):
>   `io::invokef5 false 0 false '' mycommand && myvar="${RETURNED_VALUE}"`
>   than doing:
>   `myvar="$(mycommand)".`
> - On linux, it is slighly faster (but it might be slower if you don't have SSD?).
> - On linux, you can use a tmpfs directory for massive gains over subshells.


## io::readFile

Reads the content of a file and returns it in the global variable RETURNED_VALUE.
Uses pure bash.

- $1: the file path to read
- $2: (optional) the maximum number of characters to read

> If the file does not exist, the function will return an empty string instead of failing.

Returns:

- `RETURNED_VALUE`: The content of the file.

```bash
io::readFile "/path/to/file" && local fileContent="${RETURNED_VALUE}"
io::readFile "/path/to/file" 500 && local fileContent="${RETURNED_VALUE}"
```


## io::checkAndWarn

Check last return code and warn the user in case the return code is not 0.

- $1: the last return code
- $2+ : the warning message to display in case of error

```bash
command_that_could_fail || io::checkAndWarn "$?" "The command that could fail has failed!"
```


## io::invoke2

This function call an executable and its arguments.
It redirects the stdout and stderr to environment variables.
Equivalent to io::invoke5 "${1}" 0 "" "" "${@:2}"

- $1: true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: the executable or function to execute
- $3+: the arguments to pass to the executable

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::invokef2 false git status || core::fail "status failed."
stdout="${RETURNED_VALUE}"
stderr="${RETURNED_VALUE2}"
```

> See io::invokef5 for more information.


## io::readStdIn

Read the content of the standard input.
Will immediately return if the standard input is empty.

Returns:

- `RETURNED_VALUE`: The content of the standard input.

```bash
io::readStdIn && local stdIn="${RETURNED_VALUE}"
```




> Documentation generated for the version 0.17.92 (2024-06-05).