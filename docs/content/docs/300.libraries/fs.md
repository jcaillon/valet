---
title: 📂 fs
cascade:
  type: docs
url: /docs/libraries/fs
---

## fs::cat

Print the content of a file to stdout.
This is a pure bash equivalent of cat.

- $1: **path** _as string_:
      the file to print

```bash
fs::cat "myFile"
```

> Also see log::printFile if you want to print a file for a user.

## fs::cleanTempFiles

Removes all the temporary files and directories that were created by the
fs::createTempFile and fs::createTempDirectory functions.

```bash
fs::cleanTempFiles
```

## fs::createDirectoryIfNeeded

Create the directory tree if needed.

- $1: **path** _as string_:
      The directory path to create.

Returns:

- ${RETURNED_VALUE}: The absolute path to the directory.

```bash
fs::createDirectoryIfNeeded "/my/directory"
```

## fs::createFilePathIfNeeded

Make sure that the given file path exists.
Create the directory tree and the file if needed.

- $1: **path** _as string_:
      the file path to create

Returns:

- ${RETURNED_VALUE}: The absolute path of the file.

```bash
fs::createFilePathIfNeeded "myFile"
```

## fs::createLink

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
fs::createLink "/path/to/link" "/path/to/linked"
fs::createLink "/path/to/link" "/path/to/linked" true
```

> The function uses the `ln` command.

## fs::createTempDirectory

Creates a temporary directory.

- ${_OPTION_PATH_ONLY} _as bool_:
      (optional) If true, does not create the file, only returns the path.
      (defaults to false)

Returns:

- ${RETURNED_VALUE}: The created path.

```bash
fs::createTempDirectory
local directory="${RETURNED_VALUE}"
```

> Directories created this way are automatically cleaned up by the fs::cleanTempFiles
> function when valet ends.

## fs::createTempFile

Creates a temporary file and return its path.

- ${_OPTION_PATH_ONLY} _as bool_:
      (optional) If true, does not create the file, only returns the path.
      (defaults to false)

Returns:

- ${RETURNED_VALUE}: The created path.

```bash
fs::createTempFile
local file="${RETURNED_VALUE}"
```

> Files created this way are automatically cleaned up by the fs::cleanTempFiles
> function when valet ends.

## fs::getFileLineCount

Get the number of lines in a file.

- $1: **path** _as string_:
      the file path to read

Returns:

- ${RETURNED_VALUE}: The number of lines in the file.

```bash
fs::getFileLineCount "/path/to/file"
local lineCount="${RETURNED_VALUE}"
```

TODO: fails to count the last line if empty

## fs::getPwdRealPath

Get the real path of the current directory.
By default, the `${PWD}` variable is the logical path, which may contain symlinks.

```bash
fs::getPwdRealPath
```

Returns:

- ${RETURNED_VALUE}: The realpath for the current directory.

> This is a pure bash alternative to `realpath` or `readlink`.

## fs::head

Print the first lines of a file to stdout.
This is a pure bash equivalent of head.

- $1: **path** _as string_:
      The file to print.
- $2: **number of lines** _as int_:
      The number of lines to print.
- $3: to variable _as bool_:
      (optional) Can be set using the variable `_OPTION_TO_VARIABLE`.
      If true, the output will be stored in the variable `RETURNED_ARRAY`
      instead of being printed to stdout.
      (defaults to false)

```bash
fs::head "myFile" 10
```

> #TODO: faster with mapfile + quantum?

## fs::isDirectoryWritable

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
if fs::isDirectoryWritable "/path/to/directory"; then
  echo "The directory is writable."
fi
```

## fs::listDirectories

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

- ${RETURNED_ARRAY[@]}: An array with the list of all the files.

```bash
fs::listDirectories "/path/to/directory" true true myFilterFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```

## fs::listFiles

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

- ${RETURNED_ARRAY[@]}: An array with the list of all the files.

```bash
fs::listFiles "/path/to/directory" true true myFilterFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```

## fs::listPaths

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

- ${RETURNED_ARRAY[@]}: An array with the list of all the paths.

```bash
fs::listPaths "/path/to/directory" true true myFilterFunction myFilterDirectoryFunction
for path in "${RETURNED_ARRAY[@]}"; do
  printf '%s' "${path}"
done
```

> - It will correctly list files under symbolic link directories.

## fs::readFile

Reads the content of a file and returns it in the global variable RETURNED_VALUE.
Uses pure bash.

- $1: **path** _as string_:
      the file path to read
- $2: max char _as int_:
      (optional) the maximum number of characters to read
      (defaults to 0, which means read the whole file)

> If the file does not exist, the function will return an empty string instead of failing.

Returns:

- ${RETURNED_VALUE}: The content of the file.

```bash
fs::readFile "/path/to/file" && local fileContent="${RETURNED_VALUE}"
fs::readFile "/path/to/file" 500 && local fileContent="${RETURNED_VALUE}"
```

## fs::tail

Print the last lines of a file to stdout.
This is a pure bash equivalent of tail.
However, because we have to read the whole file, it is not efficient for large files.

- $1: **path** _as string_:
      The file to print.
- $2: **number of lines** _as int_:
      The number of lines to print from the end of the file.
- $3: to variable _as bool_:
      (optional) Can be set using the variable `_OPTION_TO_VARIABLE`.
      If true, the output will be stored in the variable `RETURNED_ARRAY`
      instead of being printed to stdout.
      (defaults to false)

```bash
fs::tail "myFile" 10
```

> #TODO: use mapfile quantum to not have to read the whole file in a single go.

## fs::toAbsolutePath

This function returns the absolute path of a path.

If the path exists, it can be resolved to the real path, following symlinks,
using the option `_OPTION_REALPATH=true`.

- $1: **path** _as string_:
      The path to translate to absolute path.
- ${_OPTION_REALPATH} _as bool_:
      (optional) true to resolve the path to the real path, following symlinks.
      (defaults to false)

Returns:

- ${RETURNED_VALUE}: The absolute path of the path.

```bash
fs::toAbsolutePath "myPath"
local myPathAbsolutePath="${RETURNED_VALUE}"
```

> This is a pure bash alternative to `realpath` or `readlink`.
> The `..` will be processed before following any symlinks, by removing
> the immediate pathname component.

> Documentation generated for the version 0.28.3846 (2025-03-18).
