---
title: 📂 system
cascade:
  type: docs
url: /docs/libraries/system
---

## system::addToPath

Add the given path to the PATH environment variable for various shells,
by adding the appropriate export command to the appropriate file.

Will also export the PATH variable in the current bash.

- $1: **path** _as string_:
      the path to add to the PATH environment variable.

```bash
system::addToPath "/path/to/bin"
```

## system::getArchitecture

Returns the CPU architecture of the current machine.

Returns:

- ${RETURNED_VALUE}: the CPU architecture of the current machine.

```bash
system::getArchitecture
local architecture="${RETURNED_VALUE}"
```

## system::getEnvVars

Get the list of all the environment variables.
In pure bash, no need for env or printenv.

Returns:

- ${RETURNED_ARRAY[@]}: An array with the list of all the environment variables.

```bash
system::getEnvVars
for var in "${RETURNED_ARRAY[@]}"; do
  printf '%s=%s\n' "${var}" "${!var}"
done
```

## system::getOs

Returns the name of the current OS.

Returns:

- ${RETURNED_VALUE}: the name of the current OS: "darwin", "linux" or "windows".

```bash
system::getOs
local osName="${RETURNED_VALUE}"
```

## system::isDarwin

Check if the current OS is macOS.

Returns:

- $?
  - 0 if the current OS is macOS
  - 1 otherwise.

```bash
if system::isDarwin; then
  printf 'The current OS is macOS.'
fi
```

## system::isLinux

Check if the current OS is Linux.

Returns:

- $?
  - 0 if the current OS is Linux
  - 1 otherwise.

```bash
if system::isLinux; then
  printf 'The current OS is Linux.'
fi
```

## system::isRoot

Check if the script is running as root.

Returns:

- $?
  - 0 if the script is running as root
  - 1 otherwise.

```bash
if system::isRoot; then
  printf 'The script is running as root.'
fi
```

## system::isWindows

Check if the current OS is Windows.

Returns:

- $?
  - 0 if the current OS is Windows
  - 1 otherwise.

```bash
if system::isWindows; then
  printf 'The current OS is Windows.'
fi
```

{{< callout type="info" >}}
Documentation generated for the version 0.29.197 (2025-03-29).
{{< /callout >}}
