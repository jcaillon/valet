---
title: 📂 version
cascade:
  type: docs
url: /docs/libraries/version
---

## ⚡ version::bump

This function allows to bump a semantic version formatted like:
major.minor.patch-prerelease+build

Inputs:

- `$1`: **version** _as string_:

  the version to bump

- `$2`: **level** _as string_:

  the level to bump (major, minor, patch)

- `${keepPreRelease}` _as bool_:

  (optional) keep the prerelease and build strings

  (defaults to false)

Returns:

- `${REPLY}`: the new version string

Example usage:

```bash
version::bump "1.2.3-prerelease+build" "major" keepPreRelease=true
version::bump "1.2.3-prerelease+build" "major"
local newVersion="${REPLY}"
```

## ⚡ version::compare

This function allows to compare two semantic versions formatted like:
major.minor.patch-prerelease+build

Inputs:

- `$1`: **version1** _as string_:

  the first version to compare

- `$2`: **version2** _as string_:

  the second version to compare

Returns:

- `${REPLY}`:
  - 0 if the versions are equal,
  - 1 if version1 is greater,
  - -1 if version2 is greater

Example usage:

```bash
version::compare "2.3.4-prerelease+build" "1.2.3-prerelease+build"
local comparison="${REPLY}"
```

> The prerelease and build are ignored in the comparison.

> [!IMPORTANT]
> Documentation generated for the version 0.31.272 (2025-08-26).
