# Test suite lib-progress

## Test script 00.progress

### ✅ Testing progress_getProgressBarString

❯ `progress_getProgressBarString 0 1`

Returned variables:

```text
RETURNED_VALUE=' '
```

❯ `progress_getProgressBarString 10 1`

Returned variables:

```text
RETURNED_VALUE=' '
```

❯ `progress_getProgressBarString 50 1`

Returned variables:

```text
RETURNED_VALUE='▌'
```

❯ `progress_getProgressBarString 90 1`

Returned variables:

```text
RETURNED_VALUE='▉'
```

❯ `progress_getProgressBarString 100 1`

Returned variables:

```text
RETURNED_VALUE='█'
```

❯ `progress_getProgressBarString 22 10`

Returned variables:

```text
RETURNED_VALUE='██▏       '
```

❯ `progress_getProgressBarString 50 15`

Returned variables:

```text
RETURNED_VALUE='███████▌       '
```

❯ `progress_getProgressBarString 83 30`

Returned variables:

```text
RETURNED_VALUE='████████████████████████▉     '
```

