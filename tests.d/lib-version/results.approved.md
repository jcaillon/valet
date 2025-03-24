# Test suite lib-version

## Test script 00.version

### ✅ Testing version::compare function

❯ `version::compare 1.2.3 1.2.3`

Returned variables:

```text
RETURNED_VALUE='0'
```

❯ `version::compare 1.2.3-alpha 1.2.4+az123`

Returned variables:

```text
RETURNED_VALUE='-1'
```

❯ `version::compare 1.2.3 1.2.2`

Returned variables:

```text
RETURNED_VALUE='1'
```

❯ `version::compare 2.2.3 1.2.3-alpha`

Returned variables:

```text
RETURNED_VALUE='1'
```

❯ `version::compare 1.2.3+a1212 1.3.3`

Returned variables:

```text
RETURNED_VALUE='-1'
```

❯ `version::compare 1.2.3-alpha+a123123 1.2.3-alpha+123zer`

Returned variables:

```text
RETURNED_VALUE='0'
```

❯ `version::compare 1.2a.3 1.2.3derp`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to compare versions ⌜1.2a.3⌝ and ⌜1.2.3derp⌝ because they are not valid semantic versions.
```

### ✅ Testing version::bump

❯ `version::bump 0.0.0 minor`

Returned variables:

```text
RETURNED_VALUE='0.1.0'
```

❯ `version::bump 1.2.3-alpha+zae345 major`

Returned variables:

```text
RETURNED_VALUE='2.0.0'
```

❯ `version::bump 1.2.3-alpha+zae345 minor`

Returned variables:

```text
RETURNED_VALUE='1.3.0'
```

❯ `version::bump 1.2.3-alpha+zae345 patch`

Returned variables:

```text
RETURNED_VALUE='1.2.4'
```

❯ `version::bump 1.2.3-alpha+zae345 major false`

Returned variables:

```text
RETURNED_VALUE='2.0.0-alpha+zae345'
```

❯ `version::bump 1.2.156-alpha patch false`

Returned variables:

```text
RETURNED_VALUE='1.2.157-alpha'
```

❯ `version::bump aze patch false`

Exited with code: `1`

**Error output**:

```text
FAIL     Failed to bump the version ⌜aze⌝ because it is not valid semantic version.
```

