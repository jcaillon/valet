---
title: 📂 version
cascade:
  type: docs
url: /docs/libraries/version
---

## version::bump

This function allows to bump a semantic version formatted like:
major.minor.patch-prerelease+build

- $1: **version** _as string_:
      the version to bump
- $2: **level** _as string_:
      the level to bump (major, minor, patch)
- $3: clear build and prerelease _as bool_:
      (optional) clear the prerelease and build
      (defaults to true)

Returns:

- ${RETURNED_VALUE}: the new version string

```bash
version::bump "1.2.3-prerelease+build" "major"
local newVersion="${RETURNED_VALUE}"
```

## version::compare

This function allows to compare two semantic versions formatted like:
major.minor.patch-prerelease+build

- $1: **version1** _as string_:
      the first version to compare
- $2: **version2** _as string_:
      the second version to compare

Returns:

- ${RETURNED_VALUE}:
  - 0 if the versions are equal,
  - 1 if version1 is greater,
  - -1 if version2 is greater

```bash
version::compare "2.3.4-prerelease+build" "1.2.3-prerelease+build"
local comparison="${RETURNED_VALUE}"
```

> The prerelease and build are ignored in the comparison.

> Documentation generated for the version 0.28.3846 (2025-03-18).
