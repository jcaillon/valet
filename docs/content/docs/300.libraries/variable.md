---
title: 📂 variable
cascade:
  type: docs
url: /docs/libraries/variable
---

## ⚡ variable::deserialize

Get a string to eval in order to restore the variables stored using variable::serialize.

Inputs:

- `$1`: **file** _as string_:

  If an absolute file path (starting with /) is given, the variables will be restored from this file.
  Otherwise, the variables will be restored from a file in the user state directory with the given file name.

Returns:

- `${REPLY}`: a string to eval in order to restore the variables stored using variable::serialize.
- `${REPLY_CODE}`:
  - 0 if the file exists and was successfully sourced to restore the variables.
  - 1 if the file does not exist

Example usage:

```bash
variable::deserialize my-variables
eval "${REPLY}"
```

## ⚡ variable::isMissing

This function returns the list of undeclared variables for the given names.

Inputs:

- `$@`: **variable names** _as string_:

  the list of variable names to check.

Returns:

- `$?`
  - 0 if there are variable undeclared
  - 1 otherwise.
- `${REPLY_ARRAY[@]}`: the list of undeclared variables.

Example usage:

```bash
if variable::isMissing "var1" "var2"; then
  printf 'The following variables are not declared: %s' "${REPLY_ARRAY[*]}"
fi
```

## ⚡ variable::serialize

Serialize the variables given as arguments to a script that can be evaluated to restore the variables with the same values.
(call variable::deserialize to restore the variables from the script).

Inputs:

- `$1`: **file** _as string_:

  If an absolute file path (starting with /) is given, the script will be written to this file.
  Otherwise, the script will be written to a file created in the user state directory with the given file name.

- `$@`: **variable names** _as string_:

  The variable names to serialize. At least one variable name must be given.

Returns:

- `${REPLY}`: the path of the file containing the script to restore the variables.

Example usage:

```bash
variable::serialize my-variables VAR1 VAR2
local scriptPath="${REPLY}"
```

> [!IMPORTANT]
> Documentation generated for the version 0.40.137 (2026-06-03).
