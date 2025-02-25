# Test suite lib-progress

## Test script 00.progress

### ✅ Testing progress_getStringToDisplay

❯ `GLOBAL_COLUMNS=10 progress_getStringToDisplay '░<bar>░' 10 50 Message`

Returned variables:

```text
RETURNED_VALUE='░████    ░'
```

❯ `GLOBAL_COLUMNS=10 progress_getStringToDisplay '<spinner> <percent> ░<bar>░' 10 0 Message`

Returned variables:

```text
RETURNED_VALUE='<spinner>   0% ░░'
```

❯ `GLOBAL_COLUMNS=0 progress_getStringToDisplay '<spinner> <percent> ░<bar>░' 0 0 ''`

Returned variables:

```text
RETURNED_VALUE='<spinner>'
```

❯ `GLOBAL_COLUMNS=20 progress_getStringToDisplay '<spinner> <percent> ░<bar>░ <message>' 9 0 Message`

Returned variables:

```text
RETURNED_VALUE='<spinner>   0% ░         ░ '
```

❯ `GLOBAL_COLUMNS=24 progress_getStringToDisplay '<spinner> <percent> ░<bar>░ <message>' 10 0 Message`

Returned variables:

```text
RETURNED_VALUE='<spinner>   0% ░          ░ Me…'
RETURNED_VALUE2='1'
```

❯ `GLOBAL_COLUMNS=29 progress_getStringToDisplay '<spinner> <percent> ░<bar>░ <message>' 10 0 Message`

Returned variables:

```text
RETURNED_VALUE='<spinner>   0% ░          ░ Message'
```

❯ `GLOBAL_COLUMNS=35 progress_getStringToDisplay '<spinner> <percent> ░<bar>░ <message>' 10 0 Message`

Returned variables:

```text
RETURNED_VALUE='<spinner>   0% ░          ░ Message'
```

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

