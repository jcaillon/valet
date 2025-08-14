# Test suite 001-showcase-test-suite

## Test script 00.tests

### ✅ Testing showcaseCommand1

❯ `showcaseCommand1 arg1 arg2`

**Standard output**:

```text
That's it!
```

**Error output**:

```text
INFO     First argument: arg1.
INFO     Option 1: .
INFO     Option 2: two.
INFO     More: arg2.
INFO     Extracted text is: ⌜My bold text⌝
```

### ✅ Testing showcaseCommand1

❯ `showcaseCommand1 -o -2 optionValue2 arg1 more1 more2`

**Standard output**:

```text
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

❯ `trap::onCleanUp`

**Standard output**:

```text
trap::onCleanUp is working
```

