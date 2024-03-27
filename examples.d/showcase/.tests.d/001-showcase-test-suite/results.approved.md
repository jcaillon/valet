# Test suite 001-showcase-test-suite

## Test script 00.tests

### Testing the showcase command1

Exit code: 0

**Standard** output:

```plaintext
--- Testing with '-o -2 optionValue2 arg1 more1 more2' ---
```

**Error** output:

```log
INFO     First argument: arg1.
INFO     Option 1: true.
INFO     Option 2: optionValue2.
INFO     More: more1 more2.
```

### Testing the showcase sudo command by replacing sudo with echo

Exit code: 0

**Standard** output:

```plaintext
whoami
```

### Testing the hello world command

Exit code: 0

**Standard** output:

```plaintext
Hello world!
```

### Testing the behavior of onInterrupt

Exit code: 0

**Standard** output:

```plaintext
onInterrupt is working
```

