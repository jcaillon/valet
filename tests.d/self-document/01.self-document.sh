#!/usr/bin/env bash

command::sourceFunction "selfDocument"

# shellcheck source=../../libraries.d/lib-fs
source fs

function main() {
  test_selfDocument

  # shellcheck disable=SC2016
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

  test::title "Documentation variable"
  test::printVars _DOCUMENTATION

  test_selfDocument::convertFunctionDocumentationToMarkdown
  test_selfDocument::convertFunctionDocumentationToSnippetBody
}

function test_selfDocument::convertFunctionDocumentationToMarkdown() {
  test::title "✅ Testing selfDocument::convertFunctionDocumentationToMarkdown"

  test::func selfDocument::convertFunctionDocumentationToMarkdown _DOCUMENTATION
}

function test_selfDocument::convertFunctionDocumentationToSnippetBody() {
  test::title "✅ Testing selfDocument::convertFunctionDocumentationToSnippetBody"

  test::func selfDocument::convertFunctionDocumentationToSnippetBody exe::invoke _DOCUMENTATION

    # shellcheck disable=SC2016
  _DOCUMENTATION2='## exe::invoke

This function call an executable with its optional arguments.

- $1: **executable** _as string_:
      the executable or function to execute
- ${stdoutPath} _as string_:
      (optional) The file path to use for the stdout of the executable. Otherwise a temporary work file will be used.
      (defaults to "")
'

  test::printVars _DOCUMENTATION2
  test::func selfDocument::convertFunctionDocumentationToSnippetBody exe::invoke _DOCUMENTATION2

    # shellcheck disable=SC2016
  _DOCUMENTATION3='## exe::invoke

This function call an executable with its optional arguments.
'

  test::printVars _DOCUMENTATION3
  test::func selfDocument::convertFunctionDocumentationToSnippetBody exe::invoke _DOCUMENTATION3
}

function test_selfDocument() {
  test::title "✅ Testing self document command"

  fs::createTempDirectory
  TEST_DIRECTORY="${REPLY}"

  # shellcheck disable=SC2317
  function test::scrubOutput() {
    GLOBAL_TEST_OUTPUT_CONTENT="${GLOBAL_TEST_OUTPUT_CONTENT// [0-9][0-9][0-9] functions/ xxx functions}"
  }

  test::exec selfDocument --output "\"\${TEST_DIRECTORY}\"" --core-only

  unset -f test::scrubOutput

  test::exec fs::head "${TEST_DIRECTORY}/lib-valet.md" 10
  test::exec fs::head "${TEST_DIRECTORY}/lib-valet" 10
  test::exec fs::head "${TEST_DIRECTORY}/valet.code-snippets" 10
}

function core::getVersion() {
  REPLY="1.2.3"
}

main
