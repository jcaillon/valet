---
title: 📂 test
cascade:
  type: docs
url: /docs/libraries/test
---

## test::endTest

Call this function after each test to write the test results to the report file.
This create a new H3 section in the report file with the test description and the exit code.

- $1: the title of the test
- $2: the exit code of the test
- $3: (optional) a text to explain what is being tested

```bash
  test::endTest "Testing something" $?
```


## test::commentTest

Call this function to add a paragraph in the report file.

- $1: the text to add in the report file

```bash
test::commentTest "This is a comment."
```




> Documentation generated for the version 0.17.92 (2024-06-05).
