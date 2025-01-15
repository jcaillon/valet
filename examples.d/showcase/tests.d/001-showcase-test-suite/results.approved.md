# Test suite 001-showcase-test-suite

## Test script 00.tests

### Testing the showcase command1

Exit code: `0`

**Standard output**:

```text
→ showcaseCommand1 -o -2 optionValue2 arg1 more1 more2
That's it!
```

**Error output**:

```text
INFO     First argument: arg1.
INFO     Option 1: true.
INFO     Option 2: optionValue2.
INFO     More: more1 more2.
INFO     Extracted text is: ⌜My bold text⌝
```

### Testing the showcase sudo command by replacing sudo with echo

Exit code: `0`

**Standard output**:

```text
→ showCaseSudo
whoami
```

### Testing the behavior of onInterrupt

Exit code: `0`

**Standard output**:

```text
→ onInterrupt
onInterrupt is working
```

