---
title: 🧪 Test commands
cascade:
  type: docs
weight: 30
url: /docs/test-commands
---

Valet comes with a standardized way to implement and run tests for your commands and functions.

## 🤵 Test suites

Tests are organized in thematic groups which are called _test suites_. A test suite is a directory which contains test scripts. All test suite directories should be created under a parent `tests.d` directory.

You can check the [test suites defined for Valet][valet-test-suites] to have an example.

A test suite can, for example, regroup tests for a particular command. Organize them as you please, you can even define a single test suite for all your tests.

The tests are then coded in `.sh` scripts directly under a test suite directory.

## ✅ Approval testing

In your test scripts, you will call your command functions or run any code that you wish to test. However, you will not directly do assertions like in other test frameworks (e.g. you will not do something like `assert.equal (true, true);`).

Instead:

1. You will just print what you want to the stdout `&1` (e.g. `echo stuff`) or stderr `&2` (e.g. `echo thing 1>&2`) file descriptors. 
2. These outputs will be captured and appended to a test report file named `results.received.md`. 
3. This file will then be compared to an existing file named `results.approved.md` which is supposed to be committed with your sources and which contains the expected test report. 
4. If the files are different but the new received test if correct (or if the approved version does not exist yet), you can approve it and `results.received.md` will be the new `results.approved.md`. 
5. When you run the test again, the 2 files will be identical, ensuring you that your tests still lead to the same results.

You can check an example of [test report for the string library of Valet][valet-string-tests-report].

Each test suite will generate a different test results markdown file that can be approved.

## 🧪 Tests

Tests are implemented in `.sh` scripts directly under a test suite directory. The name of the script will determine the `h2` header of the report file while the name of the test suite directory will determine the `h1` header. You can have several scripts or one script per test suite.

You have 2 extra functions at your disposal in test scripts (see [libraries/test](../libraries/test) for more details):

- `test::commentTest "comment"`: Add a text paragraph in the test result file. E.g. `test::commentTest "Here we are testing that 1+1 is equal to 2. Awesome."`
- `test::endTest "title" $? "description"`: Call this function after each test to append the test results to the report file. This create a new `h3` header with the title, write the given exit code and include the stdout and stderr of the test inside markdown code. It optionally can add a description to the test.

You can check a script example to [test the Valet string library here][valet-string-lib-tests].

## ✒️ Implement tests

Here is a very simple example of script to test a command function `myCommand`:

```bash {linenos=table,linenostart=1,filename="test.sh"}
#!/usr/bin/env bash
myCommand
test::endTest "Testing my command" 0
```

This assumes that `myCommand` will print logs or something to the stdout/stderr, otherwise the test report will just contain the exit code equal to 0 (and headers).

We can improve this by capturing the return code of the function and display it in the test report:

```bash {linenos=table,linenostart=1,filename="test.sh"}
#!/usr/bin/env bash
returnCode=0
myCommand || returnCode=$?
test::endTest "Testing my command" ${returnCode}
```

It is also recommended to implement tests in bash functions and make use of local variables.

Find another example for [the showcase here][showcase-tests].

{{< callout type="warning" >}}
It is very important to note that tests, like commands, are executed with the bash options `set -Eeu -o pipefail`. If you expect a function or a command to return a code different than 0, you must handle it or the test (and thus the whole program) will exit.

E.g. do `myFunctionThatReturnsOne || echo "Failed as expected"`.
{{< /callout >}}

While you can test a command by invoking valet (e.g. `valet my-command argument1`), it is recommended to test the command function itself (e.g. `myCommandFunction argument1`):

- The result is the same (and you are not testing valet, you are testing your command implementation),
- and this avoid bash to create a fork and start another bash process (for `valet`), which would slow down your tests.

## 🏃‍♂️ Run tests

All your test suites directories (i.e. the `tests.d` directories) should be located under your Valet user directory (`~/.valet.d` by default).

Here is an example of directory structure for your user directory:

{{< filetree/container >}}
  {{< filetree/folder name="~/.valet.d" >}}
    {{< filetree/folder name="showcase" >}}
      {{< filetree/folder name="tests.d" >}}
        {{< filetree/folder name="test-suite1" >}}
          {{< filetree/file name="test.sh" >}}
        {{< /filetree/folder >}}
      {{< /filetree/folder >}}
    {{< /filetree/folder >}}
    {{< filetree/folder name="personal" >}}
      {{< filetree/folder name="tests.d" >}}
        {{< filetree/file name="before-tests" >}}
        {{< filetree/folder name="personal-test-suite2" >}}
          {{< filetree/file name="test2.sh" >}}
        {{< /filetree/folder >}}
      {{< /filetree/folder >}}
    {{< /filetree/folder >}}
    {{< filetree/folder name="shared-commands" >}}
      {{< filetree/folder name="tests.d" >}}
        {{< filetree/folder name="test-suite3" >}}
          {{< filetree/file name="test.sh" >}}
        {{< /filetree/folder >}}
      {{< /filetree/folder >}}
    {{< /filetree/folder >}}
  {{< /filetree/folder >}}
{{< /filetree/container >}}

You can run all your tests with:

```bash
valet self test
```

If you change your code or add new tests, you will have to approve the test results. While you can do it manually by copying files, it is recommended to _auto-approve_ the results and then use `git diff` to review the changes. You can auto-approve all test results by using the `-a` option:

```bash
valet self test -a
```

Once you have validated the approved version, you can commit it. Or revert to the HEAD version if something went wrong.

You can also exclude or include test suite using `-i` and `-e` options (check `valet self test -h` for more). E.g.:

```bash
valet self test -i my-test-suite
```

## 🪝 Test hooks

In addition to the test scripts, you can create other specific scripts which will be source'd at different time during the tests execution:

| Script path | Purpose |
|-------------|---------|
| `tests.d/before-tests` | Source'd before any test suite inside the tests.d folder is executed. |
| `tests.d/after-tests` | Source'd after all the test suites inside the tests.d folder are executed. |
| `tests.d/before-each-test-suite` | Source'd before the execution of each test suite. |
| `tests.d/after-each-test-suite` | Source'd after the execution of each test suite. |

[valet-test-suites]: https://github.com/jcaillon/valet/tree/main/tests.d
[valet-string-tests-report]: https://github.com/jcaillon/valet/blob/main/tests.d/1003-lib-string/results.approved.md
[valet-string-lib-tests]: https://github.com/jcaillon/valet/blob/main/tests.d/1003-lib-string/00.tests.sh
[showcase-tests]: https://github.com/jcaillon/valet/blob/main/examples.d/showcase/tests.d/001-showcase-test-suite/00.tests.sh