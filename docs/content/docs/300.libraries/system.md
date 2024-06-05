---
title: 📂 system
cascade:
  type: docs
url: /docs/libraries/system
---

## system::env

Get the list of all the environment variables.
In pure bash, no need for env or printenv.

Returns:

- `RETURNED_ARRAY`: An array with the list of all the environment variables.

```bash
system::env
for var in "${RETURNED_ARRAY[@]}"; do
  printf '%s=%s\n' "${var}" "${!var}"
done
```

> This is faster than using mapfile on <(compgen -v).


## system::exportTerminalSize

This function exports the terminal size.

Returns:

- `GLOBAL_COLUMNS`: The number of columns in the terminal.
- `GLOBAL_LINES`: The number of lines in the terminal.

```bash
system::exportTerminalSize
printf '%s\n' "The terminal has ⌜${GLOBAL_COLUMNS}⌝ columns and ⌜${GLOBAL_LINES}⌝ lines."
```


## system::os

Returns the name of the current OS.

Returns:

- `RETURNED_VALUE`: the name of the current OS: "darwin", "linux" or "windows".

```bash
system::os
local osName="${RETURNED_VALUE}"
```


## system::date

Get the current date in the given format.

- $1: (optional) the format of the date to return (defaults to %(%F_%Hh%Mm%Ss)T).

Returns:

- `RETURNED_VALUE`: the current date in the given format.

```bash
system::date
local date="${RETURNED_VALUE}"
```

> This function avoid to call $(date) in a subshell (date is a an external executable).




> Documentation generated for the version 0.17.92 (2024-06-05).
