---
title: 📂 test
cascade:
  type: docs
url: /docs/libraries/test
---

## test::commentTest

Call this function to add a paragraph in the report file.

- $1: **comment** _as string_:
      the text to add in the report file

```bash
test::commentTest "This is a comment."
```


## test::endTest

Call this function after each test to write the test results to the report file.
This create a new H3 section in the report file with the test description and the exit code.

- $1: **title** _as string_:
      the title of the test
- $2: **exit code** _as int_:
      the exit code of the test
- $3: comment _as string_:
      (optional) a text to explain what is being tested
      (defaults to "")

```bash
test::endTest "Testing something" $?
```




> Documentation generated for the version 1.3.1 (2024-11-21).
