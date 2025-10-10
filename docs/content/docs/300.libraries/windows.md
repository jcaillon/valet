---
title: 📂 windows
cascade:
  type: docs
url: /docs/libraries/windows
---

## ⚡ windows::addToPath

Add the given path to the PATH environment variable on Windows (current user only).

Will also export the PATH variable in the current bash.

Inputs:

- `$1`: **path** _as string_:

  the path to add to the PATH environment variable.
  The path can be in unix format, it will be converted to windows format.

- `${prepend}` _as bool_:

  (optional) True to prepend the path to the PATH, false to append it.

  (defaults to false)

Example usage:

```bash
windows::addToPath "/path/to/bin"
windows::addToPath "/path/to/bin" prepend=true
```

> This function is only available on Windows, it uses `powershell` to directly modify the registry.

## ⚡ windows::createLink

Create a soft or hard link (original ← link).

Reminder:

- A soft (symbolic) link is a new file that contains a reference to another file or directory in the
  form of an absolute or relative path.
- A hard link is a directory entry that associates a new pathname with an existing
  file (inode + data block) on a file system.

Inputs:

- `$1`: **linked path** _as string_:

  the path to link to (the original file)

- `$2`: **link path** _as string_:

  the path where to create the link

- `${hardlink}` _as boolean_:

  (optional) True to create a hard link, false to create a symbolic link

  (defaults to false)

- `${force}` _as boolean_:

  (optional) True to overwrite the link or file if it already exists.
  Otherwise, the function will fail on an existing link.

  (defaults to false)

Example usage:

```bash
windows::createLink "/path/to/link" "/path/to/linked"
windows::createLink "/path/to/link" "/path/to/linked" hardlink=true force=true
```

> On Windows, the function uses `powershell` (and optionally ls to check the existing link).
> If you have the windows "developer mode" enabled + MSYS=winsymlinks:nativestrict,
> then it uses the ln command.

## ⚡ windows::createTempDirectory

Create a temporary directory on Windows and return the path both for Windows and Unix.

This is useful for creating temporary directories that can be used in both Windows and Unix.

Returns:

- `${REPLY}`: The Windows path.
- `${REPLY2}`: The Unix path.

Example usage:

```bash
windows::createTempDirectory
```

> Directories created this way are automatically cleaned up by the fs::cleanTempFiles
> function when valet ends.

## ⚡ windows::createTempFile

Create a temporary file on Windows and return the path both for Windows and Unix.

This is useful for creating temporary files that can be used in both Windows and Unix.

Returns:

- `${REPLY}`: The Windows path.
- `${REPLY2}`: The Unix path.

Example usage:

```bash
windows::createTempFile
```

> Files created this way are automatically cleaned up by the fs::cleanTempFiles
> function when valet ends.

## ⚡ windows::endPs1Batch

This function will run all the commands that were batched with `windows::startPs1Batch`.

Returns:

- `${REPLY_CODE}`:
  - 0 if the command was successful
  - 1 otherwise.
- `${REPLY}`: The content of stdout.
- `${REPLY2}`: The content of stderr.

Example usage:

```bash
windows::startPs1Batch
windows::runPs1 "Write-Host \"Hello\""
windows::runPs1 "Write-Host \"World\""
windows::endPs1Batch
```

## ⚡ windows::getEnvVar

Get the value of an environment variable for the current user on Windows.

Inputs:

- `$1`: **variable name** _as string_:

  the name of the environment variable to get.

Returns:

- `${REPLY}`: the value of the environment variable.

Example usage:

```bash
windows::getEnvVar "MY_VAR"
echo "${REPLY}"
```

## ⚡ windows::getUnixPathFromWindowsPath

Convert a Windows path to a unix path.

Inputs:

- `$1`: **path** _as string_:

  the path to convert

Returns:

- `${REPLY}`: The unix path.

Example usage:

```bash
windows::getUnixPathFromWindowsPath "C:\path\to\file"
```

> Handles paths starting with `X:\`.

## ⚡ windows::getWindowsPathFromUnixPath

Convert a unix path to a Windows path.

Inputs:

- `$1`: **path** _as string_:

  the path to convert

Returns:

- `${REPLY}`: The Windows path.

Example usage:

```bash
windows::getWindowsPathFromUnixPath "/path/to/file"
```

> Handles paths starting with `/mnt/x/` or `/x/` in pure bash,
> handles other msys2 paths using `cygpath`.

## ⚡ windows::runPs1

Runs a PowerShell command.
This is mostly useful on Windows.

Inputs:

- `$1`: **command** _as string_:

  the command to run.

- `${runAsAdmin}` _as bool_:

  (optional) Wether to run the command as administrator.

  (defaults to false).

- `${noFail}` _as bool_:

  (optional) A boolean to indicate if the function should call core::fail (exit) in case the execution fails.
  If true and the execution fails, the script will exit.

  (defaults to false)

Returns:

- `${REPLY_CODE}`:
  - 0 if the command was successful
  - 1 otherwise.
- `${REPLY}`: The content of stdout.
- `${REPLY2}`: The content of stderr.

Example usage:

```bash
windows::runPs1 "Write-Host \"Press any key:\"; Write-Host -Object ('The key that was pressed was: {0}' -f [System.Console]::ReadKey().Key.ToString());"
windows::runPs1 "Write-Host \"Hello\"" runAsAdmin=true noFail=true
```

## ⚡ windows::setEnvVar

Set an environment variable for the current user on Windows.

Inputs:

- `$1`: **variable name** _as string_:

  The name of the environment variable to set.

- `$2`: **variable value** _as string_:

  The value of the environment variable to set.
  An empty string will unset the variable.

Example usage:

```bash
windows::setEnvVar "MY_VAR" "my_value"
```

> This function is only available on Windows, it uses `powershell` to directly modify the registry.

## ⚡ windows::startPs1Batch

After running this function, all commands that should be executed by
`windows::runPs1` will be added to a batch that will only be played
when `windows::endPs1Batch` is called.

This is a convenient way to run multiple commands in a single PowerShell session.
It makes up for the fact that running a new PowerShell session for each command is slow.

Example usage:

```bash
windows::startPs1Batch
windows::runPs1 "Write-Host \"Hello\""
windows::runPs1 "Write-Host \"World\""
windows::endPs1Batch
```

> [!IMPORTANT]
> Documentation generated for the version 0.36.26 (2025-10-10).
