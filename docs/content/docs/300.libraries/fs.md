---
title: 📂 fs
cascade:
  type: docs
url: /docs/libraries/fs
---

## ⚡ fs::cat

Print the content of a file to stdout.
This is a pure bash equivalent of cat.

Inputs:

- `$1`: **path** _as string_:

  the file to print

Example usage:

```bash
fs::cat myFile
```

> Also see log::printFile if you want to print a file for a user.

## ⚡ fs::cleanTempFiles

Removes all the temporary files and directories that were created by the
`fs::createTempFile` and `fs::createTempDirectory` functions.

Example usage:

```bash
fs::cleanTempFiles
```

## ⚡ fs::createDirectoryIfNeeded

Create the directory tree if needed.

Inputs:

- `$1`: **path** _as string_:

  The directory path to create.

Returns:

- `${REPLY}`: The absolute path to the directory.

Example usage:

```bash
fs::createDirectoryIfNeeded "/my/directory"
echo "${REPLY}"
```

## ⚡ fs::createFileIfNeeded

Make sure that the given file exists.
Create the directory tree and the file if needed.

Inputs:

- `$1`: **path** _as string_:

  the file path to create

Returns:

- `${REPLY}`: The absolute path of the file.

Example usage:

```bash
fs::createFileIfNeeded "myFile"
echo "${REPLY}"
```

## ⚡ fs::createLink

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
fs::createLink "/path/to/link" "/path/to/linked"
fs::createLink "/path/to/link" "/path/to/linked" hardlink=true force=true
```

> The function uses the `ln` command.

## ⚡ fs::createTempDirectory

Creates a temporary directory.

Inputs:

- `${pathOnly}` _as bool_:

  (optional) If true, does not create the file, only returns the path.

  (defaults to false)

Returns:

- `${REPLY}`: The created path.

Example usage:

```bash
fs::createTempDirectory
echo "${REPLY}"
fs::createTempDirectory pathOnly=true
```

> Directories created this way are automatically cleaned up by the fs::cleanTempFiles
> function when valet ends.

## ⚡ fs::createTempFile

Creates a temporary file and return its path.

Inputs:

- `${pathOnly}` _as bool_:

  (optional) If true, does not create the file, only returns the path.

  (defaults to false)

Returns:

- `${REPLY}`: The created path.

Example usage:

```bash
fs::createTempFile
echo "${REPLY}"
fs::createTempFile pathOnly=true
```

> Files created this way are automatically cleaned up by the fs::cleanTempFiles
> function when valet ends.

## ⚡ fs::getAbsolutePath

This function returns the absolute path of a path.
Also normalizes the path (removing `..` and `.`),
but does not resolve symlinks (see `fs::getRealPath` for that).

Inputs:

- `$1`: **path** _as string_:

  The path to translate to absolute path.

Returns:

- `${REPLY}`: The absolute path of the path.

Example usage:

```bash
fs::getAbsolutePath "myPath"
echo "${REPLY}"
```

> This is a pure bash alternative to `realpath` or `readlink`.
> The `..` will be processed before following any symlinks, by removing
> the immediate pathname component.

## ⚡ fs::getCommandPath

Get the absolute path of a command ().

Inputs:

- `$1`: **command** _as string_:

  the command to find

Returns:

- `${REPLY}`: The absolute path of the command (or empty if command not found).

Example usage:

```bash
fs::getCommandPath "command"
echo "${REPLY}"
```

## ⚡ fs::getFileLineCount

Get the number of lines in a file.

Inputs:

- `$1`: **path** _as string_:

  the file path to read

Returns:

- `${REPLY}`: The number of lines in the file.

Example usage:

```bash
fs::getFileLineCount "/path/to/file"
echo "${REPLY}"
```

TODO: fails to count the last line if empty

## ⚡ fs::getPwdRealPath

Get the real path of the current directory.
By default, the `${PWD}` variable is the logical path, which may contain symlinks.

Example usage:

```bash
fs::getPwdRealPath
echo "${REPLY}"
```

Returns:

- `${REPLY}`: The realpath for the current directory.

> This is a pure bash alternative to `realpath` or `readlink` for directories.

## ⚡ fs::getRealPath

Get the real path of a path, following symlinks.
Returns the absolute path.

Inputs:

- `$1`: **path** _as string_:

  The path to translate.

Returns:

- `${REPLY}`: The real path of the path.

Example usage:

```bash
fs::getRealPath "myPath"
echo "${REPLY}"
```

> This is a pure bash alternative to `realpath` or `readlink` only for directories.
> To resolve files, it uses one of these two external tools.

## ⚡ fs::getScriptDirectory

This function returns the absolute path of the directory of the script that called it.

Returns:

- `${REPLY}`: the directory of the script that called it.

Example usage:

```bash
fs::getScriptDirectory
echo "${REPLY}"
```

## ⚡ fs::head

Print the first lines of a file to stdout.
This is a pure bash equivalent of head.

Inputs:

- `$1`: **path** _as string_:

  The file to print.

- `$2`: **number of lines** _as int_:

  The number of lines to print.

- `${toArray}` _as bool_:

  (optional) If true, the output will be stored in the variable `REPLY_ARRAY`
  instead of being printed to stdout.

  (defaults to false)

Example usage:

```bash
fs::head myFile 10
fs::head myFile 10 toArray=true
```

> #TODO: faster with mapfile + quantum?

## ⚡ fs::isDirectoryWritable

Check if the directory is writable. Creates the directory if it does not exist.

Inputs:

- `$1`: **directory** _as string_:

  the directory to check

- `${testFileName}` _as string_:

  (optional) The name of the file to create in the directory to test the write access

  (defaults to "writable-test-${BASHPID}")

Returns:

- `$?`:
  - 0 if the directory is writable
  - 1 otherwise

Example usage:

```bash
if fs::isDirectoryWritable "/path/to/directory"; then
  echo "The directory is writable."
fi
```

## ⚡ fs::isValidLink

Check if the linked path is a valid link to the target.

Inputs:

- `$1`: **linked path** _as string_:

  the path to link to (the original file)

- `$2`: **link path** _as string_:

  the path where to create the link

- `${hardlink}` _as boolean_:

  (optional) True to create a hard link, false to create a symbolic link

  (defaults to false)

Returns:

- `$?`:
  - 0 if the linked path is a valid link to the target
  - 1 otherwise

Example usage:

```bash
if fs::isValidLink "/path/to/link" "/path/to/linked"; then
  echo "The link is valid."
fi
```

## ⚡ fs::listDirectories

List all the directories in the given directory.

Inputs:

- `$1`: **directory** _as string_:

  the directory to list

- `${recursive}` _as bool_:

  (optional) true to list recursively, false otherwise

  (defaults to false)

- `${includeHidden}` _as bool_:

  (optional) true to list hidden directories, false otherwise

  (defaults to false)

- `${filter}` _as string_:

  (optional) A function name that is called to filter the directories that will be listed
  The function should return 0 if the path is to be kept, 1 otherwise.
  The function is called with the path as the first argument.

  (defaults to "")

- `${filterDirectory}` _as string_:

  (optional) A function name that is called to filter the directories (for recursive listing)
  The function should return 0 if the path is to be kept, 1 otherwise.
  The function is called with the path as the first argument.

  (defaults to "")

Returns:

- `${REPLY_ARRAY[@]}`: An array with the list of all the files.

Example usage:

```bash
fs::listDirectories "/path/to/directory" true true myFilterFunction
for path in "${REPLY_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```

## ⚡ fs::listFiles

List all the files in the given directory.

Inputs:

- `$1`: **directory** _as string_:

  the directory to list

- `${recursive}` _as bool_:

  (optional) true to list recursively, false otherwise

  (defaults to false)

- `${includeHidden}` _as bool_:

  (optional) true to list hidden files, false otherwise

  (defaults to false)

- `${filter}` _as string_:

  (optional) A function name that is called to filter the files that will be listed
  The function should return 0 if the path is to be kept, 1 otherwise.
  The function is called with the path as the first argument.

  (defaults to "")

- `${filterDirectory}` _as string_:

  (optional) A function name that is called to filter the directories (for recursive listing)
  The function should return 0 if the path is to be kept, 1 otherwise.
  The function is called with the path as the first argument.

  (defaults to "")

Returns:

- `${REPLY_ARRAY[@]}`: An array with the list of all the files.

Example usage:

```bash
fs::listFiles "/path/to/directory" true true myFilterFunction
for path in "${REPLY_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```

## ⚡ fs::listPaths

List all the paths in the given directory.

Inputs:

- `$1`: **directory** _as string_:

  the directory to list

- `${recursive}` _as bool_:

  (optional) true to list recursively, false otherwise

  (defaults to false)

- `${includeHidden}` _as bool_:

  (optional) true to list hidden paths, false otherwise

  (defaults to false)

- `${filter}` _as string_:

  (optional) A function name that is called to filter the paths that will be listed
  The function should return 0 if the path is to be kept, 1 otherwise.
  The function is called with the path as the first argument.

  (defaults to "")

- `${filterDirectory}` _as string_:

  (optional) A function name that is called to filter the directories (for recursive listing)
  The function should return 0 if the path is to be kept, 1 otherwise.
  The function is called with the path as the first argument.

  (defaults to "")

Returns:

- `${REPLY_ARRAY[@]}`: An array with the list of all the paths.

Example usage:

```bash
fs::listPaths "/path/to/directory" true true myFilterFunction myFilterDirectoryFunction
for path in "${REPLY_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```

> - It will correctly list files under symbolic link directories.
> - #TODO: see if we are faster with ** and then looping over dirs to check for symbolic links
> - #TODO: introduce an optional (with default 10k) parameter to limit the number of results to avoid looping for too long
> - #TODO: introduce an optional parameter for max depth for recursive listing

## ⚡ fs::readFile

Reads the content of a file and returns it in the global variable REPLY.
Uses pure bash.

Inputs:

- `$1`: **path** _as string_:

  the file path to read

- `${maxCharacters}` _as int_:

  (optional) the maximum number of characters to read
  If set to 0, the whole file will be read.

  (defaults to 0)

> If the file does not exist, the function will return an empty string instead of failing.

Returns:

- `${REPLY}`: The content of the file.

Example usage:

```bash
fs::readFile /path/to/file
fs::readFile /path/to/file maxCharacters=100
echo "${REPLY}"
```

## ⚡ fs::tail

Print the last lines of a file to stdout.
This is a pure bash equivalent of tail.
However, because we have to read the whole file, it is not efficient for large files.

Inputs:

- `$1`: **path** _as string_:

  The file to print.

- `$2`: **number of lines** _as int_:

  The number of lines to print from the end of the file.

- `${toArray}` _as bool_:

  (optional) If true, the output will be stored in the variable `REPLY_ARRAY`
  instead of being printed to stdout.

  (defaults to false)

Example usage:

```bash
fs::tail myFile 10
```

> #TODO: use mapfile quantum to not have to read the whole file in a single go.

> [!IMPORTANT]
> Documentation generated for the version 0.41.182 (2026-06-11).
