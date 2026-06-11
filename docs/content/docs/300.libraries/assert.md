---
title: 📂 assert
cascade:
  type: docs
url: /docs/libraries/assert
---

## ⚡ assert::equals

Assert that the two given values are equal.

Inputs:

- `$1`: **expected value** _as string_:

  The expected value.

- `$2`: **actual value** _as string_:

  The actual value to compare with the expected value.

Example usage:

```bash
assert::equals "expected value" "actual value"
```

## ⚡ assert::isDirectory

Assert that the given directory exists and is a directory.

Inputs:

- `$1`: **directory path** _as string_:

  The path of the directory to check.

Example usage:

```bash
assert::isDirectory "/path/to/directory"
```

## ⚡ assert::isFile

Assert that the given file exists and is a regular file.

Inputs:

- `$1`: **file path** _as string_:

  The path of the file to check.

Example usage:

```bash
assert::isFile "/path/to/file"
```

## ⚡ assert::isLink

Assert that the given path exists and is a symbolic link.

Inputs:

- `$1`: **link path** _as string_:

  The path of the symbolic link to check.

Example usage:

```bash
assert::isLink "/path/to/link"
```

## ⚡ assert::isPath

Assert that the given path exists (can be a file, directory, or link).

Inputs:

- `$1`: **file path** _as string_:

  The path of the file to check.

Example usage:

```bash
assert::isPath "/path/to/file"
```

> [!IMPORTANT]
> Documentation generated for the version 0.41.182 (2026-06-11).
