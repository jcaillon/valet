# Test suite 1013-lib-test

## Test script 00.tests

### Testing the self test hooks

We can't check for after each test suites/tests hooks because they are executed after the test.

Exit code: `0`

**Standard output**:

```text
→ 
before-tests
before-each-test-suite
before-each-test
after-each-test

```

