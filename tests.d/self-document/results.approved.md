# Test suite self-document

## Test script 01.self-document

### ✅ Testing self document command

❯ `selfDocument --output "${TEST_DIRECTORY}" --core-only`

**Error output**:

```text
INFO     Generating documentation for the core functions only.
INFO     Found xxx functions with documentation.
INFO     The documentation has been generated in ⌜/tmp/valet.d/d1-2/lib-valet.md⌝.
INFO     The prototype script has been generated in ⌜/tmp/valet.d/d1-2/lib-valet⌝.
INFO     The vscode snippets have been generated in ⌜/tmp/valet.d/d1-2/valet.code-snippets⌝.
INFO     Found 14 commands with documentation.
INFO     The commands documentation has been generated in ⌜/tmp/valet.d/d1-2/valet-commands.md⌝.
```

❯ `fs::head /tmp/valet.d/d1-2/lib-valet.md 10`

**Standard output**:

```text
# Valet functions documentation

> Documentation generated for the version 1.2.3 (1987-05-25).

## ⚡ array::appendIfNotPresent

Add a value to an array if it is not already present.
Works for normal and associative arrays.

Inputs:
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
# Works for normal and associative arrays.
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
  "body": [ "array::appendIfNotPresent \"${1:array name}\" \"${2:value variable name}\"$0" ]
},

```

### Documentation variable

```text
_DOCUMENTATION='## exe::invoke

This function call an executable with its optional arguments.

By default it redirects the stdout and stderr and captures them to output variables.
This makes the executes silent unless the executable fails.
By default, it will exit (core::fail) if the executable returns a non-zero exit code.

This function should be used as a wrapper around any external program as it allows to easily
mock the program during tests and facilitates debugging with trace level log.

- $1: **executable** _as string_:
      the executable or function to execute
- $@: **arguments** _as any_:
      the arguments to pass to the executable
- ${noFail} _as bool_:
      (optional) A boolean to indicate if the function should call core::fail (exit) in case the execution fails.
      If true and the execution fails, the script will exit.
      (defaults to false)
- ${replyPathOnly} _as bool_:
      (optional) If set to true, the function will return the file path of the stdout and stderr files
      instead of their content. This will make the function faster.
      (defaults to "${GLOBAL_DEFAULT_REPLY_PATH_ONLY}")
- ${stdoutPath} _as string_:
      (optional) The file path to use for the stdout of the executable. Otherwise a temporary work file will be used.
      (defaults to "")

Returns:

- ${REPLY_CODE}: The exit code of the executable.
- ${REPLY}: The content of stdout (or file path to stdout if `replyPathOnly=true`).
- ${REPLY2}: The content of stderr (or file path to stdout if `replyPathOnly=true`).
- ${REPLY_ARRAY[@]}: The content of stderr (or file path to stdout if `replyPathOnly=true`).

```bash
exe::invoke git branch --list --sort=-committerdate
echo "${REPLY}"
```

> Notes'
```

### ✅ Testing selfDocument::convertFunctionDocumentationToMarkdown

❯ `selfDocument::convertFunctionDocumentationToMarkdown _DOCUMENTATION`

Returned variables:

```text
REPLY='## ⚡ exe::invoke

This function call an executable with its optional arguments.

By default it redirects the stdout and stderr and captures them to output variables.
This makes the executes silent unless the executable fails.
By default, it will exit (core::fail) if the executable returns a non-zero exit code.

This function should be used as a wrapper around any external program as it allows to easily
mock the program during tests and facilitates debugging with trace level log.

Inputs:

- `$1`: **executable** _as string_:

  the executable or function to execute

- `$@`: **arguments** _as any_:

  the arguments to pass to the executable

- `${noFail}` _as bool_:

  (optional) A boolean to indicate if the function should call core::fail (exit) in case the execution fails.
  If true and the execution fails, the script will exit.

  (defaults to false)

- `${replyPathOnly}` _as bool_:

  (optional) If set to true, the function will return the file path of the stdout and stderr files
  instead of their content. This will make the function faster.

  (defaults to "${GLOBAL_DEFAULT_REPLY_PATH_ONLY}")

- `${stdoutPath}` _as string_:

  (optional) The file path to use for the stdout of the executable. Otherwise a temporary work file will be used.

  (defaults to "")

Returns:

- `${REPLY_CODE}`: The exit code of the executable.
- `${REPLY}`: The content of stdout (or file path to stdout if `replyPathOnly=true`).
- `${REPLY2}`: The content of stderr (or file path to stdout if `replyPathOnly=true`).
- `${REPLY_ARRAY[@]}`: The content of stderr (or file path to stdout if `replyPathOnly=true`).

Example usage:

```bash
exe::invoke git branch --list --sort=-committerdate
echo "${REPLY}"
```

> Notes
'
```

### ✅ Testing selfDocument::convertFunctionDocumentationToSnippetBody

❯ `selfDocument::convertFunctionDocumentationToSnippetBody exe::invoke _DOCUMENTATION`

Returned variables:

```text
REPLY='exe::invoke \"${1:executable}\" \"${2:arguments}\" --- noFail=${3:false} replyPathOnly=${4:\"\\${GLOBAL_DEFAULT_REPLY_PATH_ONLY}\"} stdoutPath=${5:\"\"}$0'
```

```text
_DOCUMENTATION2='## exe::invoke

This function call an executable with its optional arguments.

- $1: **executable** _as string_:
      the executable or function to execute
- ${stdoutPath} _as string_:
      (optional) The file path to use for the stdout of the executable. Otherwise a temporary work file will be used.
      (defaults to "")
'
```

❯ `selfDocument::convertFunctionDocumentationToSnippetBody exe::invoke _DOCUMENTATION2`

Returned variables:

```text
REPLY='exe::invoke \"${1:executable}\" stdoutPath=${2:\"\"}$0'
```

```text
_DOCUMENTATION3='## exe::invoke

This function call an executable with its optional arguments.
'
```

❯ `selfDocument::convertFunctionDocumentationToSnippetBody exe::invoke _DOCUMENTATION3`

Returned variables:

```text
REPLY='exe::invoke$0'
```

