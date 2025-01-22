# Test suite self-document

## Test script 01.self-document

### ✅ Testing self document command

❯ `selfDocument --output "${TEST_DIRECTORY}" --core-only`

**Error output**:

```text
INFO     Generating documentation for the core functions only.
INFO     Found 154 functions with documentation.
INFO     The documentation has been generated in ⌜/tmp/valet.d/d1-2/lib-valet.md⌝.
INFO     The prototype script has been generated in ⌜/tmp/valet.d/d1-2/lib-valet⌝.
INFO     The vscode snippets have been generated in ⌜/tmp/valet.d/d1-2/valet.code-snippets⌝.
```

❯ `io::head /tmp/valet.d/d1-2/lib-valet.md 10`

**Standard output**:

```text
# Valet functions documentation

> Documentation generated for the version 1.2.3 (1987-05-25).

## ansi-codes::*

ANSI codes for text attributes, colors, cursor control, and other common escape sequences.
These codes can be used to format text in the terminal.

These codes were selected because they are widely supported by terminals and they
```

❯ `io::head /tmp/valet.d/d1-2/lib-valet 10`

**Standard output**:

```text
#!/usr/bin/env bash
# This script contains the documentation of all the valet library functions.
# It can be used in your editor to provide auto-completion and documentation.
#
# Documentation generated for the version 1.2.3 (1987-05-25).

# ## ansi-codes::*
# 
# ANSI codes for text attributes, colors, cursor control, and other common escape sequences.
# These codes can be used to format text in the terminal.
```

❯ `io::head /tmp/valet.d/d1-2/valet.code-snippets 10`

**Standard output**:

```text
{
// Documentation generated for the version 1.2.3 (1987-05-25).

"ansi-codes::*": {
  "prefix": "ansi-codes::*",
  "description": "ANSI codes for text attributes, colors, cursor control, and other common escape sequences...",
  "scope": "",
  "body": [ "ansi-codes::*$0" ]
},

```

