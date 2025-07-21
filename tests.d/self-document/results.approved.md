# Test suite self-document

## Test script 01.self-document

### ✅ Testing self document command

❯ `selfDocument --output "${TEST_DIRECTORY}" --core-only`

**Error output**:

```text
INFO     Generating documentation for the core functions only.
INFO     Found 197 functions with documentation.
INFO     The documentation has been generated in ⌜/tmp/valet.d/d1-2/lib-valet.md⌝.
INFO     The prototype script has been generated in ⌜/tmp/valet.d/d1-2/lib-valet⌝.
INFO     The vscode snippets have been generated in ⌜/tmp/valet.d/d1-2/valet.code-snippets⌝.
```

❯ `fs::head /tmp/valet.d/d1-2/lib-valet.md 10`

**Standard output**:

```text
# Valet functions documentation

> Documentation generated for the version 1.2.3 (1987-05-25).

## array::appendIfNotPresent

Add a value to an array if it is not already present.

- $1: **array name** _as string_:
      The variable name of the array.
```

❯ `fs::head /tmp/valet.d/d1-2/lib-valet 10`

**Standard output**:

```text
#!/usr/bin/env bash
# This script contains the documentation of all the valet library functions.
# It can be used in your editor to provide auto-completion and documentation.
#
# Documentation generated for the version 1.2.3 (1987-05-25).

# ## array::appendIfNotPresent
# 
# Add a value to an array if it is not already present.
# 
```

❯ `fs::head /tmp/valet.d/d1-2/valet.code-snippets 10`

**Standard output**:

```text
{
// Documentation generated for the version 1.2.3 (1987-05-25).

"array::appendIfNotPresent": {
  "prefix": "array::appendIfNotPresent",
  "description": "Add a value to an array if it is not already present...",
  "scope": "",
  "body": [ "array::appendIfNotPresent \"${1:**array name**}\" \"${2:**value variable name**}\"$0" ]
},

```

