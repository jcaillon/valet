---
title: 📂 io
cascade:
  type: docs
url: /docs/libraries/io
---

## io::cat

Print the content of a file to stdout.
This is a pure bash equivalent of cat.

- $1: **path** _as string_:
      the file to print

```bash
io::cat "myFile"
```

> Also see log::printFile if you want to print a file for a user.


## io::checkAndFail

Check last return code and fail (exit) if it is an error.

- $1: **exit code** _as int_:
      the return code
- $@: **message** _as string_:
      the error message to display in case of error

```bash
command_that_could_fail || io::checkAndFail "$?" "The command that could fail has failed!"
```


## io::checkAndWarn

Check last return code and warn the user in case the return code is not 0.

- $1: **exit code** _as int_:
      the last return code
- $@: **message** _as string_:
      the warning message to display in case of error

```bash
command_that_could_fail || io::checkAndWarn "$?" "The command that could fail has failed!"
```


## io::cleanupTempFiles

Removes all the temporary files and directories that were created by the
io::createTempFile and io::createTempDirectory functions.

```bash
io::cleanupTempFiles
```
shellcheck disable=SC2016


## io::convertFromWindowsPath

Convert a Windows path to a unix path.

- $1: **path** _as string_:
      the path to convert

Returns:

- `RETURNED_VALUE`: The unix path.

```bash
io::convertFromWindowsPath "C:\path\to\file"
```

> Handles paths starting with `X:\`.


## io::convertToWindowsPath

Convert a unix path to a Windows path.

- $1: **path** _as string_:
      the path to convert

Returns:

- `RETURNED_VALUE`: The Windows path.

```bash
io::convertToWindowsPath "/path/to/file"
```

> Handles paths starting with `/mnt/x/` or `/x/`.


## io::countArgs

Returns the number of arguments passed.

A convenient function that can be used to:

- count the files/directories in a directory
  `io::countArgs "${PWD}"/* && local numberOfFiles="${RETURNED_VALUE}"`
- count the number of variables starting with VALET_
  `io::countArgs "${!VALET_@}" && local numberOfVariables="${RETURNED_VALUE}"`

- $@: **arguments** _as any_:
      the arguments to count

Returns:

- `RETURNED_VALUE`: The number of arguments passed.

```bash
io::countArgs 1 2 3
```


## io::createDirectoryIfNeeded

Create the directory tree if needed.

- $1: **path** _as string_:
      The directory path to create.

Returns:

- `RETURNED_VALUE`: The absolute path to the directory.

```bash
io::createDirectoryIfNeeded "/my/directory"
```


## io::createFilePathIfNeeded

Make sure that the given file path exists.
Create the directory tree and the file if needed.

- $1: **path** _as string_:
      the file path to create

Returns:

- `RETURNED_VALUE`: The absolute path of the file.

```bash
io::createFilePathIfNeeded "myFile"
```


## io::createLink

Create a soft or hard link (original ← link).

Reminder:

- A soft (symbolic) link is a new file that contains a reference to another file or directory in the
  form of an absolute or relative path.
- A hard link is a directory entry that associates a new pathname with an existing
  file (inode + data block) on a file system.

This function allows to create a symbolic link on Windows as well as on Unix.

- $1: **linked path** _as string_:
      the path to link to (the original file)
- $2: **link path** _as string_:
      the path where to create the link
- $3: hard link _as boolean_:
      (optional) true to create a hard link, false to create a symbolic link
      (defaults to false)
- $4: force _as boolean_:
      (optional) true to overwrite the link or file if it already exists.
      Otherwise, the function will fail on an existing link.
      (defaults to true)

```bash
io::createLink "/path/to/link" "/path/to/linked"
io::createLink "/path/to/link" "/path/to/linked" true
```

> On unix, the function uses the `ln` command.
> On Windows, the function uses `powershell` (and optionally ls to check the existing link).


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


## io::invoke

This function call an executable and its arguments.
If the execution fails, it will fail the script and show the std/err output.
Otherwise it hides both streams, effectively rendering the execution silent unless it fails.

It redirects the stdout and stderr to environment variables.
Equivalent to io::invoke5 true 0 '' '' "${@}"

- $1: **executable** _as string_:
      the executable or command
- $@: **arguments** _as any_:
      the command and its arguments

Returns:

- $?: The exit code of the executable.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::invoke git add --all
```

> See io::invokef5 for more information.


## io::invoke2

This function call an executable and its arguments.
It redirects the stdout and stderr to environment variables.
Equivalent to io::invoke5 "${1}" 0 "" "" "${@:2}"

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

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


## io::invoke2piped

This function call an executable and its arguments and input a given string as stdin.
It redirects the stdout and stderr to environment variables.
Equivalent to io::invoke5 "${1}" 0 false "${2}" "${@:3}"

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **stdin** _as string_:
      the stdin to pass to the executable
- $3: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

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


## io::invokef2

This function call an executable and its arguments.
It redirects the stdout and stderr to temporary files.
Equivalent to io::invokef5 "${1}" 0 "" "" "${@:2}"

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

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


## io::invokef2piped

This function call an executable and its arguments and input a given string as stdin.
It redirects the stdout and stderr to temporary files.
Equivalent to io::invokef5 "${1}" 0 false "${2}" "${@:3}"

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
      If true and the execution fails, the script will exit.
- $2: **stdin** _as string_:
      the stdin to pass to the executable
- $3: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

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


## io::invokef5

This function call an executable and its arguments.
It redirects the stdout and stderr to temporary files.

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails.
                     If true and the execution fails, the script will exit.
- $2: **acceptable codes** _as string_:
      the acceptable error codes, comma separated
        (if the error code is matched, then set the output error code to 0)
- $3: **fail** _as bool_:
      true/false to indicate if the 4th argument represents a file path or directly the content for stdin
- $4: **sdtin** _as string_:
      the stdin (can be empty)
- $5: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable

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
> - On linux, it is slightly faster (but it might be slower if you don't have SSD?).
> - On linux, you can use a tmpfs directory for massive gains over subshells.


## io::isDirectoryWritable

Check if the directory is writable. Creates the directory if it does not exist.

- $1: **directory** _as string_:
      the directory to check
- $2: test file name _as string_:
      (optional) the name of the file to create in the directory to test the write access

Returns:

- $?:
  - 0 if the directory is writable
  - 1 otherwise

```bash
if io::isDirectoryWritable "/path/to/directory"; then
  echo "The directory is writable."
fi
```


## io::listDirectories

List all the directories in the given directory.

- $1: **directory** _as string_:
      the directory to list
- $2: recursive _as bool_:
      (optional) true to list recursively, false otherwise
      (defaults to false)
- $3: hidden _as bool_:
      (optional) true to list hidden paths, false otherwise
      (defaults to false)
- $4: directory filter function name _as string_:
      (optional) a function name that is called to filter the sub directories (for recursive listing)
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.
      (defaults to empty string, no filter)

Returns:

- `RETURNED_ARRAY`: An array with the list of all the files.

```bash
io::listDirectories "/path/to/directory" true true myFilterFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```


## io::listFiles

List all the files in the given directory.

- $1: **directory** _as string_:
      the directory to list
- $2: recursive _as bool_:
      (optional) true to list recursively, false otherwise
      (defaults to false)
- $3: hidden _as bool_:
      (optional) true to list hidden paths, false otherwise
      (defaults to false)
- $4: directory filter function name _as string_:
      (optional) a function name that is called to filter the directories (for recursive listing)
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.
      (defaults to empty string, no filter)

Returns:

- `RETURNED_ARRAY`: An array with the list of all the files.

```bash
io::listFiles "/path/to/directory" true true myFilterFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```


## io::listPaths

List all the paths in the given directory.

- $1: **directory** _as string_:
      the directory to list
- $2: recursive _as bool_:
      (optional) true to list recursively, false otherwise
      (defaults to false)
- $3: hidden _as bool_:
      (optional) true to list hidden paths, false otherwise
      (defaults to false)
- $4: path filter function name _as string_:
      (optional) a function name that is called to filter the paths that will be listed
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.
      (defaults to empty string, no filter)
- $5: directory filter function name _as string_:
      (optional) a function name that is called to filter the directories (for recursive listing)
      The function should return 0 if the path is to be kept, 1 otherwise.
      The function is called with the path as the first argument.
      (defaults to empty string, no filter)

Returns:

- `RETURNED_ARRAY`: An array with the list of all the paths.

```bash
io::listPaths "/path/to/directory" true true myFilterFunction myFilterDirectoryFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```

> - It will correctly list files under symbolic link directories.


## io::readFile

Reads the content of a file and returns it in the global variable RETURNED_VALUE.
Uses pure bash.

- $1: **path** _as string_:
      the file path to read
- $2: max char _as int_:
      (optional) the maximum number of characters to read
      (defaults to 0, which means read the whole file)

> If the file does not exist, the function will return an empty string instead of failing.

Returns:

- `RETURNED_VALUE`: The content of the file.

```bash
io::readFile "/path/to/file" && local fileContent="${RETURNED_VALUE}"
io::readFile "/path/to/file" 500 && local fileContent="${RETURNED_VALUE}"
```


## io::readStdIn

Read the content of the standard input.
Will immediately return if the standard input is empty.

Returns:

- `RETURNED_VALUE`: The content of the standard input.

```bash
io::readStdIn && local stdIn="${RETURNED_VALUE}"
```


## io::sleep

Sleep for the given amount of time.
This is a pure bash replacement of sleep.

- $1: **time** _as float_:
      the time to sleep in seconds (can be a float)

```bash
io:sleep 1.5
```

> The sleep command is not a built-in command in bash, but a separate executable. When you use sleep, you are creating a new process.


## io::toAbsolutePath

This function returns the absolute path of a path.

- $1: **path** _as string_:
      The path to translate to absolute path.

Returns:

- `RETURNED_VALUE`: The absolute path of the path.

```bash
io::toAbsolutePath "myFile"
local myFileAbsolutePath="${RETURNED_VALUE}"
```

> This is a pure bash alternative to `realpath` or `readlink`.


## io::windowsCreateTempDirectory

Create a temporary directory on Windows and return the path both for Windows and Unix.

This is useful for creating temporary directories that can be used in both Windows and Unix.

Returns:

- `RETURNED_VALUE`: The Windows path.
- `RETURNED_VALUE2`: The Unix path.

```bash
io::windowsCreateTempDirectory
```

> Directories created this way are automatically cleaned up by the io::cleanupTempFiles
> function when valet ends.


## io::windowsCreateTempFile

Create a temporary file on Windows and return the path both for Windows and Unix.

This is useful for creating temporary files that can be used in both Windows and Unix.

Returns:

- `RETURNED_VALUE`: The Windows path.
- `RETURNED_VALUE2`: The Unix path.

```bash
io::windowsCreateTempFile
```

> Files created this way are automatically cleaned up by the io::cleanupTempFiles
> function when valet ends.


## io::windowsPowershellBatchEnd

This function will run all the commands that were batched with `io::windowsPowershellBatchStart`.

Returns:

- $?
  - 0 if the command was successful
  - 1 otherwise.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::windowsPowershellBatchStart
io::windowsRunInPowershell "Write-Host \"Hello\""
io::windowsRunInPowershell "Write-Host \"World\""
io::windowsPowershellBatchEnd
```


## io::windowsPowershellBatchStart

After running this function, all commands that should be executed by
`io::windowsRunInPowershell` will be added to a batch that will only be played
when `io::windowsPowershellBatchEnd` is called.

This is a convenient way to run multiple commands in a single PowerShell session.
It makes up for the fact that running a new PowerShell session for each command is slow.

```bash
io::windowsPowershellBatchStart
io::windowsRunInPowershell "Write-Host \"Hello\""
io::windowsRunInPowershell "Write-Host \"World\""
io::windowsPowershellBatchEnd
```


## io::windowsRunInPowershell

Runs a PowerShell command.
This is mostly useful on Windows.

- $1: **command** _as string_:
      the command to run.
- $2: run as administrator _as boolean_:
      (optional) whether to run the command as administrator.
      (defaults to false).

Returns:

- $?
  - 0 if the command was successful
  - 1 otherwise.
- `RETURNED_VALUE`: The content of stdout.
- `RETURNED_VALUE2`: The content of stderr.

```bash
io::windowsRunInPowershell "Write-Host \"Press any key:\"; Write-Host -Object ('The key that was pressed was: {0}' -f [System.Console]::ReadKey().Key.ToString());"
```




> Documentation generated for the version 0.27.285 (2024-12-05).
