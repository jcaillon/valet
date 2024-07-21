# Test suite 1008-lib-autocompletion

## Test script 01.utilities

### Testing autocompletionComputeSize

Exit code: `0`

**Standard** output:

```plaintext
GLOBAL_LINES=10
GLOBAL_COLUMNS=10
autocompletionComputeSize '' '' 1 1 20 20
10 x 9 at 1:2
autocompletionComputeSize 2 '' 1 1 20 20
10 x 2 at 1:2

autocompletionComputeSize '' '' 1 1 5 5
5 x 5 at 1:2

autocompletionComputeSize '' '' 5 5 6 9
9 x 5 at 2:6

autocompletionComputeSize '' '' 7 7 10 4
4 x 6 at 7:1

autocompletionComputeSize '' true 7 7 10 10
10 x 3 at 1:8
```

